class AddReferenceToTag < ActiveRecord::Migration[6.1]
  def change
    add_reference :tags, :tag_task, null: false, foreign_key: true
  end
end
