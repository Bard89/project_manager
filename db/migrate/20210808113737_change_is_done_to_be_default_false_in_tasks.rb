class ChangeIsDoneToBeDefaultFalseInTasks < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :is_done, :boolean, :default => false
  end
end
