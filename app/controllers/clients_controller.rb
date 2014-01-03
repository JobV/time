class ClientsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def index
    respond_with current_user.clients, root: false
  end

  def create
    client = Client.new(client_params)
    client.users << current_user
    if client.save
      respond_with client
    else
      render json: { status: :bad_request, error: "Can't save client." }
    end
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
