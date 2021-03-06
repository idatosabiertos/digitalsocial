class Organisations::BuildController < ApplicationController

  before_filter :authenticate_user!, except: [:new_user, :create_user]
  before_filter :redirect_to_new_organisation_if_logged_in, only: [:new_user, :create_user]

  before_filter :get_project_from_session, only: [:edit_project, :update_project]
  before_filter :find_project_from_id_param, only: [:invite_organisations, :create_new_organisation_invite]

  before_filter :ensure_current_organisation_is_project_member, only: [:edit_project, :update_project,
                                                                       :invite_organisations, :create_new_organisation_invite]

  def new_user
    @user = User.new
  end

  def create_user
    @user = User.new(params[:user])

    if @user.save
      sign_in @user
      redirect_to [:organisations, :build, :new_organisation]
    else
      render :new_user
    end
  end

  def new_organisation
    @organisation = OrganisationPresenter.new
  end

  def create_organisation
    @organisation = OrganisationPresenter.new
    @organisation.attributes = params[:organisation_presenter]
    @organisation.user       = current_user

    if @organisation.save
      set_current_organisation( @organisation.organisation_guid ) # so that the following steps are for the right org.
      redirect_to [:organisations, :build, :edit_organisation]
    else
      render :new_organisation
    end
  end

  def edit_organisation
    @organisation = current_organisation
  end

  def update_organisation
    @organisation = current_organisation

    if @organisation.update_attributes(params[:organisation])
      redirect_to [:organisations, :build, :new_project]
    else
      render :edit_organisation
    end
  end

  def new_project
    if (@project = current_organisation.project_resources.first).present?
      #redirect_to organisations_build_edit_project_path(id: @project.guid)
    end

    @project = Project.new
  end

  def create_project
    @project = Project.new
    @project.scoped_organisation = current_organisation
    @project.creator             = current_organisation.uri

    @project.assign_attributes params[:project]
    
    if @project.valid_for_first_page?
      session[:project_page_one_data] = params[:project].to_json
      redirect_to organisations_build_edit_project_path
    else
      render :new_project
    end
  end

  def edit_project

  end

  def update_project
    transaction = Tripod::Persistence::Transaction.new
    if @project.update_attributes(params[:project], transaction: transaction ) && @project.save_reach_value(transaction: transaction)
      transaction.commit
      redirect_to organisations_build_invite_organisations_path(id: @project.guid)
    else
      transaction.abort
      render :edit_project
    end
  end

  def invite_organisations
    @project_invite = ProjectInvitePresenter.new
    @project_invite.project_uri = @project.uri
    @project_invite.invitor_organisation_uri = current_organisation.uri
  end

  def create_new_organisation_invite
    @project_invite = ProjectInvitePresenter.new
    @project_invite.attributes = params[:project_invite_presenter]
    @project_invite.project_uri = @project.uri
    @project_invite.invitor_organisation_uri = current_organisation.uri

    if @project_invite.save
      redirect_to [:organisations, :build, :finish], notice: "Organisation invited. We'll email the contact you entered."
    else
      flash.now[:alert] = "Invite failed. #{@project_invite.errors.messages.values.join(', ')}"
      render :invite_organisations
    end
  end

  def finish

  end

  private

  def redirect_to_new_organisation_if_logged_in
    redirect_to [:organisations, :build, :new_organisation] if user_signed_in?
  end

  def get_project_from_session
    project_data = session[:project_page_one_data]
    if project_data
      @project = Project.new
      @project.scoped_organisation = current_organisation
      project_json_data = JSON.parse(project_data)
      @project.assign_attributes project_json_data
      @project
    else
      redirect_to [:organisations, :build, :new_project], notice: "You must first fill in this form."
    end
  end
  
  def find_project_from_id_param
    @project = Project.find(Project.slug_to_uri(params[:id]))
  end
  
  def ensure_current_organisation_is_project_member
    unless current_organisation.is_member_of_project?(@project)
      redirect_to :dashboard, notice: "Your current organisation is not a member of that project."
    end
  end
end
