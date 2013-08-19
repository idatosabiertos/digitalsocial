class Address
  include Tripod::Resource

  rdf_type 'http://www.w3.org/2006/vcard/ns#Address'
  graph_uri Digitalsocial::DATA_GRAPH

  field :street_address, 'http://www.w3.org/2006/vcard/ns#streetAddress'
  field :locality, 'http://www.w3.org/2006/vcard/ns#locality'
  field :region, 'http://www.w3.org/2006/vcard/ns#region'
  field :country, 'http://www.w3.org/2006/vcard/ns#country'
  field :postalCode, 'http://www.w3.org/2006/vcard/ns#postalCode'

end