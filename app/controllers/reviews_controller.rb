class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @tag_list = params[:review][:tag_name].split(/[[:blank:]]+/)
    if @review.save
      @review.save_tag(@tag_list)
      flash[:success] = 'レビュー新規投稿完了しました！'
      redirect_to reviews_path
    else
      flash.now[:danger] = 'レビュー新規登録に失敗しました'
      render :new
    end
  end

  def index
    @tag_lists = Tag.all
    @reviews = Review.all.page(params[:page]).per(12).reverse_order
    if @reviews == nil
       @reviews = []
    end
  end

  def show
    @review = Review.find(params[:id])
    @post_tags = @review.tags
    @review_comment = ReviewComment.new
  end

  def edit
    @review = Review.find(params[:id])
    @review.tag_name = @review.tags.pluck(:tag_name).join(' ')
  end

  def update
    @review = Review.find(params[:id])
    @tag_list = params[:review][:tag_name].split(/[[:blank:]]+/)
    if @review.update(review_params)
      @review.update_tag(@tag_list)
      flash[:success] = 'レビュー編集完了しました！'
      redirect_to review_path(@review.id)
    else
      flash.now[:danger] = 'レビューの編集に失敗しました'
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
    @reviews = @tag.review.all.page(params[:page]).per(12).reverse_order
    if @reviews == nil
       @reviews = []
    end
  end

  def area
    @area_name = Review.areas.keys[params[:id].to_i]
    @reviews = Review.where(area: params[:id]).page(params[:page]).per(12).reverse_order
  end

  private

  def review_params
    params.require(:review).permit(:shop_name, :image, :caption, :evaluation).merge(area: params[:review][:area].to_i)
  end
end
