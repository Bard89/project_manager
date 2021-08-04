class ChangeUserIdTagTaskIdToBeTrueIntags < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:tags, :tag_task_id, true) # now I can create the tag without the necessity to associate it with a task, through a Tagtasks table
  end
end
