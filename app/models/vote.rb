class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :work, presence: true
  validates :user, presence: true
end
