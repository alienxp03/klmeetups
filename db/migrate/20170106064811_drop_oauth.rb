class DropOauth < ActiveRecord::Migration
  def change
    drop_table :oauths
  end
end
