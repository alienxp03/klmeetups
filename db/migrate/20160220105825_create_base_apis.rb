class CreateBaseApis < ActiveRecord::Migration
  def change
    create_table :base_apis do |t|
      t.datetime    :last_updated

      t.timestamps null: false
    end
  end
end
