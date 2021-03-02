class AddLikesToLike < ActiveRecord::Migration[6.1]
  def change
    add_column :likes, :likes, :int
  end
end
