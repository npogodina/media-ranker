class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: {scope: :category}
  validates :category, presence: true
  validates_inclusion_of :category, :in => ["book", "album", "movie"]

  def self.top_ten(category)
    top_ten= Work.where(category: category).order(:publication_year).limit(3)
  end
end
