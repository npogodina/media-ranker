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

  describe "sort_by_votes" do
    it "return all works from a specified category" do
      books_num = Work.where(category: "book").count
      books = Work.sort_by_votes("book")
      expect(books.length).must_equal books_num

      books.each do |book|
        expect(book.category).must_equal "book"
      end
    end

    it "returns an empty collection if there are no works in a specified category" do
      enigma = works(:enigma)
      enigma.destroy
      movies = Work.where(category: "movie")
      expect(movies).must_be_empty

      sorted_movies = Work.sort_by_votes("movie")
      expect(sorted_movies).must_be_empty
    end

    it "returns a collection sorted by rating in descending order" do
      books = Work.sort_by_votes("book")
      expect(books.first).must_equal works(:wheel_2)

      i = 0
      while i < books.length - 1
        expect(books[i].votes.count).must_be :>=, books[i + 1].votes.count
        i += 1
      end  
    end

    it "orders a collection by id in case of a tie between votes" do
      books = Work.sort_by_votes("book")
      expect(books.first.votes.count).must_equal 3
      expect(books.first.votes.count).must_equal 3
      expect(books.first.id).must_be :>, books.second.id
    end

    it "raises an exception if category is not allowed" do
      expect {
        Work.sort_by_votes("video-game")
      }.must_raise ArgumentError
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

    it "returns a collection sorted by rating in descending order" do
      books = Work.top_ten("book")
      expect(books.first).must_equal works(:wheel_2)

      i = 0
      while i < books.length - 1
        expect(books[i].votes.count).must_be :>=, books[i + 1].votes.count
        i += 1
      end  
    end

    it "orders a collection by id in case of a tie between votes" do
      books = Work.top_ten("book")
      expect(books.first.votes.count).must_equal 3
      expect(books.first.votes.count).must_equal 3
      expect(books.first.id).must_be :>, books.second.id
    end
    it "raises an exception if category is not allowed" do
      expect {
        Work.top_ten("video-game")
      }.must_raise ArgumentError
    end
  end

  describe "spotlight" do
    it "return an instance of Work" do
      spotlight = Work.spotlight
      expect(spotlight).must_be_instance_of Work
    end

    it "returns nil if there are no works in the database yet" do
      works = Work.all
      works.each do |work|
        work.destroy
      end

      works = Work.all
      expect(works).must_be_empty
      expect(Work.spotlight).must_be_nil
    end

    it "returns a work with the highest rating" do
      spotlight = Work.spotlight
      works = Work.all

      i = 0
      while i < works.length
        expect(works[i].votes.count).must_be :<=, spotlight.votes.count
        i += 1
      end  
    end

    it "returns a work with a higher is in case of a tie in votes" do
      spotlight = Work.spotlight
      expect(spotlight).must_equal works(:wheel_2)

      works = Work.all
      highest_votes = works.select{ |work| work.votes.count == spotlight.votes.count }
      expect(highest_votes.length).must_equal 2
      expect(highest_votes).must_include works(:wheel_1)
      expect(spotlight.id).must_be :>, works(:wheel_1).id
    end
  end
end
