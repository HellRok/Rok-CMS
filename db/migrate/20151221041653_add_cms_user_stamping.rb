class AddCmsUserStamping < ActiveRecord::Migration
  def change
    add_column :rok_cms_pages, :creator_id, :integer
    add_column :rok_cms_pages, :updater_id, :integer
    add_column :rok_cms_themes, :creator_id, :integer
    add_column :rok_cms_themes, :updater_id, :integer
    add_column :rok_cms_layouts, :creator_id, :integer
    add_column :rok_cms_layouts, :updater_id, :integer
  end
end
