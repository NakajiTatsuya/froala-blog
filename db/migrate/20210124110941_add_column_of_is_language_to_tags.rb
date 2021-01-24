class AddColumnOfIsLanguageToTags < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :is_language, :boolean, default: false, null: false
  end
end
