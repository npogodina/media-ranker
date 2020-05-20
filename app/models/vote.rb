class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :work, presence: true,  uniqueness: {scope: :user}
  validates :user, presence: true
end