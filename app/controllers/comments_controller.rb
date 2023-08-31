class CommentsController < ApplicationController
  before_action :set_movie
  before_action :set_comment, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to movie_path
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_comment
    @comment = @movie.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
