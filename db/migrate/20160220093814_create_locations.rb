class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string    :name
      t.float     :latitude
      t.float     :longitude
      t.string    :street
      t.string    :zip
      t.string    :city
      t.string    :state
      t.string    :country

      t.timestamps null: false
    end
  end
end
