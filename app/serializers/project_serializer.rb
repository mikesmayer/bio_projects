class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name,

             :read_group_count,
             :contact_list

  has_many :read_groups
  has_many :runs

  def contact_list
    ReadGroup.where(project_id: object.id).pluck(:contact_email).uniq
  end
end
