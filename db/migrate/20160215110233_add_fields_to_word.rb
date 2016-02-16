class AddFieldsToWord < ActiveRecord::Migration
  def change
    add_column :words, :name, :string
    add_column :words, :meaning, :text
    add_column :words, :context, :string
    add_column :words, :root, :string
    add_column :words, :sentence, :text
  end
end
