class CreateProject < ActiveRecord::Migration
  def up
    add_column :read_groups, :project_id, :integer

    create_table :projects do |t|
      t.string :name, :null => false
    end

    project_names = ReadGroup.pluck(:project).uniq

    project_names.each do |project_name|
      project = Project.where(name: project_name).first_or_create
      project.read_groups << ReadGroup.where("project = ?", project_name)
    end
  end

  def down
    drop_table :projects
    remove_column :read_groups, :project_id, :integer
  end
end
