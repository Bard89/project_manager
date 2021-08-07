class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :tag_tasks, dependent: :destroy ##
  has_many :tags, through: :tag_tasks

  validates :title, presence: true
  # validates :is_done, presence: true # this validation then prevents from creating anything that has status is_done with false
  validates :is_done, inclusion: { in: [ true, false ] }

  # pg gem
  include PgSearch::Model
  pg_search_scope :search_by_title,
        against: [ :title],
        using: {
            # t search stands for fulltext search
            # now not the whole word needs to be included
            tsearch: { prefix: true } # <-- now `superman batm` will return something!
        }
  # multisearch from pg gem
  multisearchable against: [:title]
end
