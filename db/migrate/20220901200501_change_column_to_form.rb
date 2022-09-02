class ChangeColumnToForm < ActiveRecord::Migration[7.0]
  def change
    change_column :forms, :intime, :datetime
    change_column :forms, :outtime, :datetime
  end
end
