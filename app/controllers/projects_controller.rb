class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @new_project = Project.new
    @projects = Project.all
  end

  def create
    project = Project.new(project_params)
    project.users << current_user
    if project.save
      flash[:notice] = "New project made."
      redirect_to projects_path
    else
      flash[:alert] = "Project not made. Something went wrong."
      redirect_to projects_path
    end
  end

  def show
    @project = Project.find_by(id: params[:id])
  end

  def edit
    @project = Project.find_by(id: params[:id])
  end

  def update
    @project = Project.find_by(id: params[:id])
    if @project.update(project_params)
      flash[:notice] = "Your project has been updated."
      redirect_to project_path(@project)
    else
      flash[:alert] = "Your project was not updated. Something went wrong."
      redirect_to edit_project_path(@project)
    end
  end

  def destroy
    @project = Project.find_by(id: params[:id])
    @project.delete
    flash[:notice] = "Your project has been deleted."
    redirect_to projects_path
  end

  private

  def project_params
    params.required(:project).permit(:name)
  end
end
