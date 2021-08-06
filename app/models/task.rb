class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :tag_tasks, dependent: :destroy ##
  has_many :tags, through: :tag_tasks

  validates :title, presence: true
  # validates :is_done, presence: true # this validation then prevents from creating anything that has status is_done with false
  validates :is_done, inclusion: { in: [ true, false ] }
end
