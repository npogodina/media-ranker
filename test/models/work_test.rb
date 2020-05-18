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

    it "is invalid if the category is not one of three options: book, album, movie" do
      work = Work.new(
        category: "gardening book",
        title: "Floret Farm's Cut Flower Garden"
        )
        result = work.valid?
        expect(result).must_equal false
    end
  end

  describe "top_ten" do
    it "returns a collection of no more than 10 works from a specified category" do
      top_books = Work.top_ten("book")
      expect(top_books.length).must_be :<, 11
      
      top_books.each do |book|
        expect(book.category).must_equal "book"
      end
    end

    it "returns an empty collection if there are no works in a specified category" do
      enigma = works(:enigma)
      enigma.destroy
      movies = Work.where(category: "movie")
      expect(movies).must_be_empty

      top_movies = Work.top_ten("movie")
      expect(top_movies).must_be_empty
    end

    it "return a collection sorted by rating in descending order" do
      # TODO
    end

    it "raises an exception if category is not allowed" do
      expect {
        Work.top_ten("video-game")
      }.must_raise ArgumentError
    end

  end

  describe "spotlight" do

  end
end
