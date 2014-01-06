class ClientsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def index
    respond_with current_user.clients, root: false
  end

  def create
    current_user.clients.find_by(company_name: params[:company_name])
    respond_with current_user.clients.create(client_params)
  end

  def update
    client = current_user.clients.find_by(id: params[:id])
    respond_with client.update(client_params)
  end

  private

  def client_params
    params.required(:client).permit(:company_name, :contact_person, :kvk, :address, :postal_code, :city)
  end
end
