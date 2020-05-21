class User < ApplicationRecord
  has_many :votes
  has_many :works, through: :votes

  validates :name, presence: true
  default_scope { order(created_at: :asc) }
end
