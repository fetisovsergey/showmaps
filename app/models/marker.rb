class Marker < ActiveRecord::Base
  belongs_to :map
  validates :longtitude, presence: true
  validates :latitude, presence: true 

  #validates :description, presence: true

  geocoded_by :address, :skip_index => true
  
  reverse_geocoded_by :latitude, :longtitude
  after_validation :reverse_geocode

  has_attached_file :photo, :styles => { :medium => "300x300>", :full => "1200x1200>" }, :default_url => ""
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

end

