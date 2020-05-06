class ProgressTask < ApplicationRecord
  has_many :notifications, as: :object
end
