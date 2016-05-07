class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string    :external_id, null: false
      t.string    :name, null: false
      t.string    :url, null: false
      t.integer   :status, null: false

      t.timestamps null: false
    end
  end
end
