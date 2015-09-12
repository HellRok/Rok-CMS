class AddBlogPostToLayout < ActiveRecord::Migration
  def change
    add_column :rok_cms_layouts, :post, :text
  end
end
