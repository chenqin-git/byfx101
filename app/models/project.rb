class Project < ApplicationRecord
  belongs_to :user
  validates :name, presence: true

  has_many :project_relationships
  has_many :members, through: :project_relationships, source: :user
end
