class TagTask < ApplicationRecord
  belongs_to :tag
  belongs_to :task

  validates :task_id, presence: true # validace je zbytecna, je navic, deje se stejne
  validates :tag_id, presence: true

end
