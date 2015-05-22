class Marker < ActiveRecord::Migration
  def change
      create_table :markers do |t|
       t.string :description
       t.string :address
       t.float :longtitude
       t.float :latitude
       t.integer :map_id
       t.timestamps
     end
  end
end
