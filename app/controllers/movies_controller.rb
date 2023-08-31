class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    @movies = Movie.all
    @q = Movie.ransack(params[:q])
  end

  def show
    @comment = Comment.new
    @comments = @movie.comments.order(created_at: :desc)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
        redirect_to root_path
    else
      render :new
    end
  end
  
  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to root_path
  end

  def search
    @q = Movie.ransack(search_params)
    @movies = @q.result
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:movie_url, :team_id, :player, :day, :lyrics, :stadium_id, :text).merge(user_id: current_user.id)
  end

  def search_params
    params.require(:q).permit(:team_id_eq, :player_cont, :lyrics_cont, :stadium_id_eq)
  end
end