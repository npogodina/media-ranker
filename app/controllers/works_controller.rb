class WorksController < ApplicationController
  def index
    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
    @movies = Work.where(category: "movie")
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
      flash[:success] = "Successfully created #{@work.category} #{@work.id}" 
      redirect_to work_path(@work)
    else
      error_messages = @work.errors.full_messages.map { |message| "<li>#{message}</li>" }.join
      flash.now[:error] = "A problem occured. Could not create #{@work.category}. <ul>#{error_messages}</ul>"
      render :new 
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
    elsif @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}" 
      redirect_to work_path(params[:id])
    else 
      error_messages = @work.errors.full_messages.map { |message| "<li>#{message}</li>" }.join
      flash.now[:error] = "A problem occured. Could not update #{@work.category}. <ul>#{error_messages}</ul>"
      render :edit
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    end

    @work.destroy
    flash[:success] = "Successfully deleted #{@work.category} #{@work.id}" 
    redirect_to root_path
  end

  private

  def work_params
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
