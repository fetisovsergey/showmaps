class Map < ActiveRecord::Base
  has_many :markers, dependent: :destroy
end

