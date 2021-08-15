class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :tag_tasks, dependent: :destroy ##
  has_many :tags, through: :tag_tasks

  # to be able to use strong params for associations # not working for some reason ... 
  # accepts_nested_attributes_for :tags

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
  
  # to be able to delete the uoploaded file in task
  attr_accessor :state_event, :remove_file

  after_save :purge_file, if: :remove_file
  private def purge_file
    file.purge_later
  end


end
