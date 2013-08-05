class Project

  include Tripod::Resource

  rdf_type 'http://example.com/project'
  graph_uri 'http://example.com/dsi_data'

  field :label, 'http://example.com/label'
  field :webpage, 'http://example.com/webpage'
  field :tags, 'http://example.com/tag', multivalued: true
  field :duration, 'http://example.com/time_interval'
  field :creator, 'http://example.com/def/project/creator', is_uri: true

  attr_accessor :tags_list, :start_date, :end_date, :creator_role

  validates :label, :webpage, presence: true
  validates :start_date, :end_date, :creator_role, presence: { if: :new_record? }

  # override initialise
  def initialize(uri=nil, graph_uri=nil)
    super(uri || "http://example.com/project/#{Guid.new}")
  end

  def guid
    self.uri.to_s.split("/").last
  end

  def to_param
    guid
  end

  # Temporary
  def tags_list=(list)
    self.tags = list.split(", ")
  end

  def create_time_interval!
    new_time_interval = TimeInterval.new
    new_time_interval.start_date = start_date
    new_time_interval.end_date   = end_date
    new_time_interval.save

    self.duration = new_time_interval.uri.to_s
    save
  end

  def duration_resource
    TimeInterval.find(self.duration)
  end

  def add_creator_membership!(organisation)
    creator_membership = ProjectMembership.new
    creator_membership.organisation = organisation.uri.to_s
    creator_membership.project      = self.uri.to_s
    creator_membership.nature       = self.creator_role
    creator_membership.save

    self.creator = organisation.uri.to_s
    self.save
  end

  def organisations
    project_membership_project_predicate = ProjectMembership.fields[:project].predicate.to_s
    project_membership_org_predicate = ProjectMembership.fields[:organisation].predicate.to_s
    Organisation
      .where("?pm_uri <#{project_membership_project_predicate}> <#{self.uri}>")
      .where("?pm_uri <#{project_membership_org_predicate}> ?uri")
  end

  def organisation_resources
    organisations.resources
  end

  def any_organisations?
    organisations.count > 0
  end

  def invite_new_organisation!
    false
  end

end