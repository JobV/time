class ClientsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def index
    respond_with current_user.clients, root: false
  end

  def create
    company_name = params[:client][:company_name]
    respond_with current_user.clients.create(company_name: company_name)
  end

  def update
    client = Client.find_by(id: params[:id])
    respond_with client.update(client_params)
  end

  private

  def client_params
    params.required(:client).permit(:company_name, :contact_person, :kvk, :address, :postal_code)
  end
end
