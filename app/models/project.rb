class Project < ApplicationRecord
    belongs_to :user
    # IMP now i can call @project.tasks, this below creates a method for that yes
    has_many :tasks, dependent: :destroy 

    validates :title, presence: true
    validates :position, presence: true
end
