class Tag < ApplicationRecord
  belongs_to :user
  has_many :tag_tasks
  has_many :tasks, through: :tag_tasks

  validates :task_id, presence: true
  validates :tag_id, presence: true
end
