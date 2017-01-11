class HomeController < ApplicationController
  def index
    render json: 'Home payment-api v0.1'
  end
end
