class HomesController < ApplicationController
  def top
    @all_ranks = Review.find(Favorite.group(:review_id).order('count(review_id) desc').limit(6).pluck(:review_id))
    if @all_ranks == nil
       @all_ranks = []
    end
  end

  def map
  end
end
