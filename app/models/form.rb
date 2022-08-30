# frozen_string_literal: true

# form model
class Form < ApplicationRecord
  belongs_to :floor
  belongs_to :user
end
