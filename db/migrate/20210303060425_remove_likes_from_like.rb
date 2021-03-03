class RemoveLikesFromLike < ActiveRecord::Migration[6.1]
  def change
    remove_column :likes, :likes
  end
end
