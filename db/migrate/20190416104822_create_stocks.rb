class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.references :post
      t.references :user

      t.timestamps
    end
  end
end
