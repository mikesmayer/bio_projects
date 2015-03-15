class CreateProject < ActiveRecord::Migration
  def up
    add_column :read_groups, :project_id, :integer

    create_table :projects do |t|
      t.string :name, :null => false
    end

    project_names = ReadGroup.pluck(:project).uniq.compact

    if project_names.length > 0
      project_names.each do |project_name|
        project = Project.where(name: project_name).first_or_create
        project.read_groups << ReadGroup.where("project = ?", project_name)
      end
    end

    remove_column :read_groups, :project
  end

  def down
    remove_column :read_groups, :project_id
    drop_table :projects
    add_column :read_groups, :project, :string
  end
end
