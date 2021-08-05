class Tag < ApplicationRecord
  belongs_to :user
  has_many :tag_tasks
  has_many :tasks, through: :tag_tasks

  validates :title, presence: true
end
