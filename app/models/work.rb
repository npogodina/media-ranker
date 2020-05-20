class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :title, presence: true, uniqueness: {scope: :category}
  validates :category, presence: true
  validates_inclusion_of :category, :in => ["book", "album", "movie"]

  def self.top_ten(category)
    unless ["album", "movie", "book"].include?(category)
      raise ArgumentError.new("Unsupported category")
    end

    top_ten = Work.where(category: category).left_joins(:votes).group("works.id").order('count(votes.id) DESC').limit(10)
    # top_ten = Work.where(category: category).order(:publication_year).limit(10)
  end

  def self.spotlight
    spoltight = Work.order(:publication_year).first
  end
end
