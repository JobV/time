class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def index
    @new_project = Project.new
    @projects = current_user.projects
    respond_with @projects, root: false
  end

  def create
    client = current_user.clients.find_by(company_name: params[:client])
    respond_with current_user.projects.create(project_params.merge(client_id: client.id))
  end

  def show
    @project = find_project_by_id
  end

  def edit
    @project = find_project_by_id
  end

  def update
    @project = find_project_by_id
    respond_with @project.update(project_params)
  end

  def destroy
    @project = find_project_by_id
    respond_with @project.delete
  end

  private

  def find_project_by_id
    Project.find_by(id: params[:id])
  end

  def project_params
    params.required(:project).permit(:name, :hourly_rate, :client_id)
  end
end
