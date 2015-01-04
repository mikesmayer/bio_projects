class Project < ActiveRecord::Base
  has_many :read_groups, dependent: :destroy
  has_many :runs, -> { uniq }, through: :read_groups

  def read_group_count
    read_groups.count
  end
end