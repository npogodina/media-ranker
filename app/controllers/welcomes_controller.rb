class WelcomesController < ApplicationController
  def show
    @top_albums = Work.top_ten("album")
    @top_books = Work.top_ten("book")
    @top_movies = Work.top_ten("movie")

    @spotlight = Work.spotlight
    @user = User.find_by(id: session[:user_id])
  end
end
