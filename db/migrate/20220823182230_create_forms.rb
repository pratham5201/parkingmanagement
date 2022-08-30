# frozen_string_literal: true

# form database
class CreateForms < ActiveRecord::Migration[7.0]
  def change
    create_table :forms do |t|
      t.string :clientname
      t.string :carnumber
      t.string :carcolor
      t.integer :price
      t.integer :slot
      t.string :status
      t.integer :floor_id
      t.time :intime
      t.time :outtime
      t.timestamps
    end
  end
end
