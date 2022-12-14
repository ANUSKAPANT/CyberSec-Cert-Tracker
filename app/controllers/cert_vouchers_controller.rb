class CertVouchersController < BaseController
  before_action :set_cert_voucher, only: %i[update destroy show]

  def index
    options = { include: [:student_course, "student_course.student", "student_course.course"] }
    render json: CertVoucherSerializer.new(CertVoucher.all, options).serialized_json
  end

  def create
    options = { include: [:student_course, "student_course.student", "student_course.course"] }
    @cert_voucher = CertVoucher.new(cert_voucher_params)
    if @cert_voucher.save
      student_crse = StudentCourse.find_by(id: cert_voucher_params['student_course_id'])
      student_crse.update(voucher_purchased: true)
      render json: CertVoucherSerializer.new(@cert_voucher, options).serialized_json, status: :ok
    else
      render json: @cert_voucher.errors, status: :unprocessable_entity
    end
  end

  def show
    options = { include: [:student_course, "student_course.student", "student_course.course"] }
    render json: CertVoucherSerializer.new(@cert_voucher, options).serialized_json, status: :ok
  end

  def update
    options = { include: [:student_course, "student_course.student", "student_course.course"] }
    if @cert_voucher.update(cert_voucher_params)
      render json: CertVoucherSerializer.new(@cert_voucher, options).serialized_json, status: :ok
    else
      render json: @cert_voucher.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @cert_voucher.destroy
  end

  private

  def set_cert_voucher
    @cert_voucher = CertVoucher.find(params[:id])
  end

  def cert_voucher_params
    params.permit(:student_course_id, :certification_name, :created_date, :expiry_date, :voucher_code, :test_result, :score, :test_center_id, :exam_date, :exam_code)
  end
end
