# frozen_string_literal: true

# flor database
class CreateFloors < ActiveRecord::Migration[7.0]
  def change
    create_table :floors do |t|
      t.integer :floor
      t.integer :user_id
      t.timestamps
    end
  end
end
