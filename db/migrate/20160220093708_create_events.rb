class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string      :external_id
      t.string      :name
      t.string      :description
      t.datetime    :start_time
      t.datetime    :end_time
      t.string      :attending_count
      t.string      :interested_count
      t.datetime    :last_updated
      t.references  :group, index: true
      t.references  :location, index: true

      t.timestamps null: false
    end
  end
end
