class AddContentsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :abstract, :text
    add_column :posts, :verification, :text
    add_column :posts, :technique, :text
    add_column :posts, :discussion, :text
    add_column :posts, :superiority, :text
    add_column :posts, :suggestion, :text
  end
end
