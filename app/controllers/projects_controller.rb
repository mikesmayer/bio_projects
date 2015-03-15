class ProjectsController < ApplicationController
  respond_to :json

  def index
    @projects = Project.all.sort_by(&:name)

    respond_with @projects
  end

  def show
    render json: Project.find(params[:id])
  end

  def update
    project = Project.find(params[:id])

    status = project.update_attributes(project_params) ? 200 : :unprocessable_entity
    respond_with project, status: status
  end

  def destroy
    ## this is faster deletion over safe deletion
    @project = Project.find(params[:id])
    @project.read_groups.each{|read_group| ReadGroup.destroy_all_associations(read_group.id)}

    respond_with @project.destroy
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
