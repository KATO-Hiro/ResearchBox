class AddFiguresToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :figures, :json
  end
end
