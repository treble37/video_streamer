class AddLengthToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :length, :string
  end
end
