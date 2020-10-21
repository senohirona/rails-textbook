class AddAuthorToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :Author, :string
  end
end
