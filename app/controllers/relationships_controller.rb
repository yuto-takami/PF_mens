class RelationshipsController < ApplicationController
  # フォロー機能を作成、保存、削除する
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  # フォロー、フォロワー表示
  def followings
    user = User.find(params[:user_id])
    @users = user.followings.page(params[:page]).per(20)
    if @users == nil
       @users = []
    end
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers.page(params[:page]).per(20)
    if @users == nil
       @users = []
    end
  end
end
