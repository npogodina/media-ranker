class WelcomesController < ApplicationController
  def show
    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
    @movies = Work.where(category: "movie")
  end
end
