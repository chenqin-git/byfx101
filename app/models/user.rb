class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects
  has_many :orders

  has_many :project_relationships
  has_many :joined_projects, :through => :project_relationships, :source => :project

  def is_member_of?(project)
    joined_projects.include?(project)
  end

  def join!(project)
    joined_projects << project
  end

  def quit!(project)
    joined_projects.delete(project)
  end
end
