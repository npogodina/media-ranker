class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: {scope: :category}
  validates :category, presence: true
end
