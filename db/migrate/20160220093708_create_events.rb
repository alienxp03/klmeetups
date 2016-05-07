class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string      :external_id
      t.string      :name, null: false
      t.string      :url, null: false
      t.text        :description, null: false
      t.integer     :entry_type, null: false
      t.integer     :status, null: false
      t.string      :email
      t.datetime    :start_time, null: false
      t.datetime    :end_time
      t.datetime    :last_updated
      
      t.references  :group, index: true
      t.references  :location, index: true

      t.timestamps null: false
    end
  end
end
