class PaymentsController < ApplicationController
  before_action :set_contract
  before_action :set_payment, only: [:show, :update, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    @payments = @contract.payments
    @payments = @payments.date_filter(params[:from], params[:to]) if params[:from].present? && params[:to].present?
    @payment_presenter = PaymentPresenter.new(@payments)
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = @contract.payments.new(payment_params)

    if @payment.save
      render :show, status: :created, location: url_for([@contract, @payment])
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    if @payment.update(payment_params)
      render :show, status: :ok, location: contract_payment_path(@payment)
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
  end

  private
    def set_contract
      @contract = Contract.where(id: params[:contract_id]).first
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = @contract.payments.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.permit(:contract_id, :description, :value, :time, :is_imported, :is_deleted)
    end
end
