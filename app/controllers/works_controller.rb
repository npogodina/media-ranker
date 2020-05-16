class WorksController < ApplicationController
  def index
    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
    @movies = Work.where(category: "movie")
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    end

    # @trips = @work.trips
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params) 
    if @work.save 
      redirect_to works_path #!
      return
    else 
      render :new 
      return
    end
  end

  # def edit
  #   @driver = Driver.find_by(id: params[:id])

  #   if @driver.nil?
  #     head :not_found
  #     return
  #   end
  # end

  # def update
  #   @driver = Driver.find_by(id: params[:id])
  #   if @driver.nil?
  #     head :not_found
  #     return
  #   elsif @driver.update(driver_params)
  #     redirect_to driver_path(params[:id])
  #     return
  #   else 
  #     render :edit
  #     return
  #   end
  # end

  # def destroy
  #   @driver = Driver.find_by(id: params[:id])

  #   if @driver.nil?
  #     head :not_found
  #     return
  #   end

  #   @driver.destroy

  #   redirect_to drivers_path
  #   return
  # end

  # private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
