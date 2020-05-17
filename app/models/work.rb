class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: {scope: :category}
  validates :category, presence: true
  validates_inclusion_of :category, :in => ["book", "album", "movie"]
end
