class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :tag_tasks, dependent: :destroy ##
  has_many :tags, through: :tag_tasks

  # for the active storage
  has_one_attached:file

  validates :title, presence: true
  validates :is_done, inclusion: { in: [ true, false ] }

  # pg gem
  include PgSearch::Model
  pg_search_scope :search_by_title,
        against: [ :title],
        using: {
            tsearch: { prefix: true }
        }
  # multisearch from pg gem
  multisearchable against: [:title]
end
