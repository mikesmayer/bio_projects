class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name,

             :read_group_count

  has_many :read_groups
  has_many :runs
end
