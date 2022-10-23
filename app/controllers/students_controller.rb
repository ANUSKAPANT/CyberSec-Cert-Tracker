class StudentsController < ApplicationController
  before_action :set_student, only: %i[update destroy show]

  def index
    render json: StudentSerializer.new(Student.all).serialized_json
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      render json: @student, status: :created
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: StudentSerializer.new(@student).serialized_json, status: :ok
  end

  def update
    if @student.update(student_params)
      render json: @student, status: :created
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @student.destroy
  end

  def set_student
    @student = Student.find(params[:id])
  end

  private

  def student_params
    params.permit(:first_name, :last_name, :canvas_id, :title, :company_id, :email_id)
  end
end
