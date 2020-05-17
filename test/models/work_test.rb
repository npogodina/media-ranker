require "test_helper"

describe Work do
  describe 'validations' do

    it 'is valid when all fields are present' do
      work = Work.new(
        category: "book",
        title: "Floret Farm's Cut Flower Garden",
        creator: "Erin Benzakein",
        publication_year: 2017,
        description: "Gardening Book for Beginners, Floral Design and Flower Arranging Book"
      )
      result = work.valid?
      expect(result).must_equal true
    end

    it "is valid when just title and category are present" do
      work = Work.new(
      category: "book",
      title: "Floret Farm's Cut Flower Garden"
      )
      result = work.valid?
      expect(result).must_equal true
    end

    it 'is invalid without a title' do
      work = Work.new(category: "book")
      result = work.valid?
      expect(result).must_equal false
    end

    it 'is invalid without a category' do
      work = Work.new(title: "Floret Farm's Cut Flower Garden")
      result = work.valid?
      expect(result).must_equal false
    end

    it "is invalid if a work with the same title exists in the same category" do
      poodr = Work.find_by(title: "Practical Object Oriented Design in Ruby")
      duplicate = Work.new(
        category: "book",
        title: "Practical Object Oriented Design in Ruby"
      )
      result = duplicate.valid?
      expect(result).must_equal false
    end

    it "is valid if a work with the same title exists in a different same category" do
      poodr = Work.find_by(title: "Practical Object Oriented Design in Ruby")
      exciting_movie = Work.new(
        category: "movie",
        title: "Practical Object Oriented Design in Ruby"
      )
      result = exciting_movie.valid?
      expect(result).must_equal true
    end
  end
end
