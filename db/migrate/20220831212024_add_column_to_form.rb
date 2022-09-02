class AddColumnToForm < ActiveRecord::Migration[7.0]
  def change
    add_column :forms, :slotn, :integer
  end
end
