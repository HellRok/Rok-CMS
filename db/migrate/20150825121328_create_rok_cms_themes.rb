class CreateRokCmsThemes < ActiveRecord::Migration
  def change
    create_table :rok_cms_themes do |t|
      t.integer :site_id
      t.string :name
      t.string :update_url
      t.float :version
      t.text :html
      t.text :scss
      t.text :javascript
      t.text :compiled_css

      t.timestamps null: false
    end

    add_index :rok_cms_themes, :site_id
  end
end
