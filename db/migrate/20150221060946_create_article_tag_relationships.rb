class CreateArticleTagRelationships < ActiveRecord::Migration
    def change
        create_table :article_tag_relationships do |t|
            t.integer :article_id
            t.integer :tag_id
            t.timestamps null: false
        end
        add_index :article_tag_relationships, :article_id
        add_index :article_tag_relationships, :tag_id
        add_index :article_tag_relationships, [:article_id, :tag_id], unique: true
    end
end
