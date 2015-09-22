class AddTreeToPages < ActiveRecord::Migration
  def change
    add_column :rok_cms_pages, :parent_id, :integer, index: true
    add_column :rok_cms_pages, :lft, :integer, index: true
    add_column :rok_cms_pages, :rgt, :integer, index: true
    add_column :rok_cms_pages, :depth, :integer, default: 0
    add_column :rok_cms_pages, :children_count, :integer, default: 0
    add_column :rok_cms_pages, :sort_order, :integer
    add_column :rok_cms_pages, :path, :text # URLs can be crazy long
  end
end
