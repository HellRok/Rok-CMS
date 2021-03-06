class CreateRokCmsLayouts < ActiveRecord::Migration
  def change
    create_table :rok_cms_layouts do |t|
      t.integer :site_id
      t.string :name
      t.text :content, default: "[[page:content]]"
      t.integer :theme_id

      t.timestamps null: false
    end

    add_index :rok_cms_layouts, :site_id
    add_index :rok_cms_layouts, :theme_id
  end
end
