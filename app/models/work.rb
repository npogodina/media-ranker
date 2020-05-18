class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: {scope: :category}
  validates :category, presence: true
  validates_inclusion_of :category, :in => ["book", "album", "movie"]

  def self.top_ten(category)
    unless ["album", "movie", "book"].include?(category)
      raise ArgumentError.new("Unsupported category")
    end
    
    top_ten = Work.where(category: category).order(:publication_year).limit(3)
  end

  def self.spotlight
    spoltight = Work.order(:publication_year).first
  end
end
