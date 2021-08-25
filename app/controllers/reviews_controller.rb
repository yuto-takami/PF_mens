class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @tag_list = params[:review][:tag_name].split(nil)
    if @review.save
       @review.save_tag(@tag_list)
       redirect_to reviews_path
    else
       render :new
    end
  end

  def index
    @tag_lists = Tag.all
    @reviews = Review.page(params[:page]).reverse_order
  end

  def show
    @review = Review.find(params[:id])
    @post_tags = @review.tags
    @review_comment = ReviewComment.new
  end

  def edit
    @review = Review.find(params[:id])
    @review.tag_name = @review.tags.pluck(:tag_name).join(" ")
  end

  def update
    @review = Review.find(params[:id])
    @tag_list = params[:review][:tag_name].split(nil)
    if @review.update(review_params)
       @review.update_tag(@tag_list)
       redirect_to review_path(@review.id)
    else
       render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path
  end

  def search
    @tag = Tag.find(params[:tag_id])
    @review = @tag.review.all
    @reviews = Review.page(params[:page]).reverse_order
  end
  
  def area
  end

  private

  def review_params
    params.require(:review).permit(:shop_name, :image, :caption, :evaluation).merge(area: params[:review][:area].to_i)
  end
end
