class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :title, presence: true, uniqueness: {scope: :category}
  validates :category, presence: true
  validates_inclusion_of :category, :in => ["book", "album", "movie"]

  def self.sort_by_votes(category)
    unless ["album", "movie", "book"].include?(category)
      raise ArgumentError.new("Unsupported category")
    end

    Work.where(category: category)
      .left_joins(:votes)
      .group("works.id")
      .order('count(votes.id) DESC')
      .order("works.id DESC")
  end

  def self.top_ten(category)
    unless ["album", "movie", "book"].include?(category)
      raise ArgumentError.new("Unsupported category")
    end

    top_ten = Work.sort_by_votes(category).limit(10)
  end

  def self.spotlight
    Work
      .left_joins(:votes)
      .group("works.id")
      .order('count(votes.id) DESC')
      .order("works.id DESC")
      .first
  end
end
