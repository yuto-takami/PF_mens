class AddAreaToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :area, :integer
  end
end
