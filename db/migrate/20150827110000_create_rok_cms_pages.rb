class CreateRokCmsPages < ActiveRecord::Migration
  def change
    create_table :rok_cms_pages do |t|
      t.integer :layout_id
      t.string :title
      t.string :slug
      t.text :content
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.boolean :published, default: false

      t.timestamps null: false
    end

    add_index :rok_cms_pages, :layout_id
    add_index :rok_cms_pages, :slug
  end
end
