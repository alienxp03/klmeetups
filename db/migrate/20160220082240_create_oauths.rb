class CreateOauths < ActiveRecord::Migration
  def change
    create_table :oauths do |t|
      t.string :access_token

      t.timestamps null: false
    end
  end
end
