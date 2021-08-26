class SearchesController < ApplicationController
  def search
    @value = params['search']['value']
    @datas = search_for(@value).page(params[:page]).per(12)
  end

  private
  
  def search_for(value)
    Review.where('shop_name LIKE ?', "%#{value}%")
  end
end
