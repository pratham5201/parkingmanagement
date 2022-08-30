# frozen_string_literal: true

# floor model
class Floor < ApplicationRecord
  has_many :forms
  belongs_to :user
end
