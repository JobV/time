class ActivitiesController < ApplicationController
  respond_to :json

  def index
    activities = current_user.activities
    respond_with activities, root: false
  end

  def create
  end
end
