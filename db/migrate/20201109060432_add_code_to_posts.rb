class AddCodeToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :code, :string
  end
end
