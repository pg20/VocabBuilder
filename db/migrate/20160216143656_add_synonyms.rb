class AddSynonyms < ActiveRecord::Migration
  def change
    add_column :words, :synonym, :text
  end
end
