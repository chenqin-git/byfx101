class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects
  has_many :orders
  has_many :account_books

  belongs_to :agent_rank

  has_many :project_relationships
  has_many :joined_projects, :through => :project_relationships, :source => :project

  accepts_nested_attributes_for :agent_rank, :reject_if => :all_blank
  accepts_nested_attributes_for :joined_projects, :reject_if => :any_blank

  scope :query, ->(email, agent_rank_id, start_date, end_date) {
    where("('' = ? or email like ?) and (-1 = ? or agent_rank_id = ?) and ('' = ? or created_at >= ?) and ('' = ? or created_at <= ?)",
      email, "%#{email}%",
      agent_rank_id, agent_rank_id,
      start_date, start_date,
      end_date, end_date)
  }

  def is_admin?
    return id == 1
  end

  def is_member_of?(project)
    joined_projects.include?(project)
  end

  def join!(project)
    joined_projects << project
  end

  def quit!(project)
    joined_projects.delete(project)
  end

  def balance!
    account_books && account_books.last && account_books.last.balance ? account_books.last.balance : 0
  end
end
