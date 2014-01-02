class ClientsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def index
    respond_with current_user.clients
  end

  def create
    client = Client.new(client_params)
    client.users << current_user
    if client.save
      # sumtin
    else
      # sumtin else
    end
  end

  private

  def client_params
    params.required(:client).permit(:company_name, :contact_person, :kvk, :address, :postal_code)
  end
end
