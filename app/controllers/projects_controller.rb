class ProjectsController < ApplicationController
  respond_to :json

  def index
    @projects = ReadGroup.select(:project).distinct.map{|read_group|
      {id: read_group.project}
    }

    respond_with @projects
  end

  def show
    project_hash = {project: {id: params[:id]}}
    respond_with project_hash
  end

  def update
    ReadGroup.where(project: project_params[:id]).each do |read_group|
      read_group.update_attributes(project: project_params[:new_id])
    end

    respond_with 200
  end

  def project_params
    params.permit(:id, :new_id)
  end
end