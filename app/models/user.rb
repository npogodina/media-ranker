class User < ApplicationRecord
  has_many :votes, order: 'created_at'
  
  validates :name, presence: true
end
