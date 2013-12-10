class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json, :html

  def index
    @new_project = Project.new
    @projects = current_user.projects
    respond_with @projects, root: false
  end

  def create
    project = Project.new(project_params)
    project.users << current_user
    if project.save
      flash[:notice] = "New project made."
    else
      flash[:alert] = "Project not made. Something went wrong."
    end
    redirect_to projects_path
  end

  def show
    @project = find_project_by_id
  end

  def edit
    @project = find_project_by_id
  end

  def update
    @project = find_project_by_id
    if @project.update(project_params)
      flash[:notice] = "Your project has been updated."
      redirect_to project_path(@project)
    else
      flash[:alert] = "Your project was not updated. Something went wrong."
      redirect_to edit_project_path(@project)
    end
  end

  def destroy
    @project = find_project_by_id
    @project.delete
    flash[:notice] = "Your project has been deleted."
    redirect_to projects_path
  end

  private

  def find_project_by_id
    Project.find_by(id: params[:id])
  end

  def project_params
    params.required(:project).permit(:name)
  end
end
