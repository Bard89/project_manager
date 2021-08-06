class RemoveTagTaskIdFromTags < ActiveRecord::Migration[6.1]
  def change
    remove_column :tags, :tag_task_id
  end
end
