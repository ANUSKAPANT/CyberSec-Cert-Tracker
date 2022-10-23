class ExamsController < ApplicationController
  before_action :set_exam, only: %i[update destroy show]

  def index
    render json: ExamSerializer.new(Exam.all).serialized_json
  end

  def create
    @exam = Exam.new(exam_params)
    if @exam.save
      render json: @exam, status: :created
    else
      render json: @exam.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: ExamSerializer.new(@exam).serialized_json, status: :ok
  end

  def update
    if @exam.update(exam_params)
      render json: @exam, status: :created
    else
      render json: @exam.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @exam.destroy
  end

  def set_exam
    @exam = Exam.find(params[:id])
  end

  private

  def exam_params
    params.permit(:cert_voucher_id, :exam_code, :exam_date, :passed, :exam_grade)
  end
end
