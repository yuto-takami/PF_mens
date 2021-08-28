class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.page(params[:page]).per(9).reverse_order
    if @reviewws == nil
       @reviews = []
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザーの編集完了しました！'
      redirect_to user_path(@user.id)
    else
      flash.now[:danger] = 'ユーザーの編集に失敗しました'
      render :edit
    end
  end

  def like
    reviews_ids = Favorite.where(user_id: params[:id]).pluck(:review_id)
    @reviews = Review.where(id: reviews_ids)
    if @reviews == nil
       @reviews = []
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
