class TagTask < ApplicationRecord
  belongs_to :tag
  belongs_to :task

  validates :task_id, presence: true
  validates :tag_id, presence: true

end
