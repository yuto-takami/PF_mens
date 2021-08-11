class ReviewsController < ApplicationController
  
  def new
    @review = Review.new
  end
  
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.save
    redirect_to reviews_path
  end
  
  def index
    @reviews = Review.page(params[:page]).reverse_order
  end
  
  def show
    @review = Review.find(params[:id])
    @review_comment = ReviewComment.new
  end
  
  def edit
    
  end
  
  def update
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path
  end
  
  private

  def review_params
    params.require(:review).permit(:shop_name, :image, :caption)
  end
  
end
