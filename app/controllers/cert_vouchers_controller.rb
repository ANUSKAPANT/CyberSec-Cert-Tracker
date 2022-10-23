class CertVouchersController < ApplicationController
  before_action :set_cert_voucher, only: %i[update destroy show]

  def index
    render json: CertVoucherSerializer.new(CertVoucher.all).serialized_json
  end

  def create
    @cert_voucher = CertVoucher.new(cert_voucher_params)
    if @cert_voucher.save
      render json: @cert_voucher, status: :created
    else
      render json: @cert_voucher.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: CertVoucherSerializer.new(@cert_voucher).serialized_json, status: :ok
  end

  def update
    if @cert_voucher.update(cert_voucher_params)
      render json: @cert_voucher, status: :created
    else
      render json: @cert_voucher.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @cert_voucher.destroy
  end

  def set_cert_voucher
    @cert_voucher = CertVoucher.find(params[:id])
  end

  private

  def cert_voucher_params
    params.permit(:student_course_id, :certification_name, :created_date, :expiry_date)
  end
end
