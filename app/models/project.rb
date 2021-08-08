class Project < ApplicationRecord
    belongs_to :user
    # IMP now i can call @project.tasks, this below creates a method for that yes
    has_many :tasks, dependent: :destroy 

    validates :title, presence: true
    validates :position, presence: true

    # including the module for pg search
    include PgSearch::Model
    
    pg_search_scope :search_by_title,
        against: [ :title],
        using: {
            tsearch: { prefix: true }
        }
    # multisearch from pg gem
    multisearchable against: [:title]
end
