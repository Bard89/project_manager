class Tag < ApplicationRecord
  belongs_to :user
  has_many :tag_tasks, dependent: :destroy  ##
  has_many :tasks, through: :tag_tasks

  validates :title, presence: true

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
