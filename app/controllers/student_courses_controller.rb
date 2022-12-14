class StudentCoursesController < BaseController
  before_action :set_student_course, only: %i[update destroy show]

  def index
    options = { include: [:course, :student] }
    render json: StudentCourseSerializer.new(StudentCourse.all, options).serialized_json
  end

  def create
    options = { include: [:course, :student] }
    @student_course = StudentCourse.new(student_course_params)
    if @student_course.save
      render json: StudentCourseSerializer.new(@student_course, options).serialized_json, status: :ok
    else
      render json: @student_course.errors, status: :unprocessable_entity
    end
  end

  def show
    if @student_course.present?
      options = { include: [:course, :student] }
      render json: StudentCourseSerializer.new(@student_course, options).serialized_json, status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def update
    options = { include: [:course, :student] }
    if @student_course.update(student_course_params)
      render json: StudentCourseSerializer.new(@student_course, options).serialized_json, status: :ok
    else
      render json: @student_course.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @student_course.destroy
  end

  def set_student_course
    @student_course = StudentCourse.find(params[:id])
  end

  private

  def student_course_params
    params.permit(:student_id, :course_id, :registration_date, :canvas_course_completion, :dcldp_code, :voucher_purchased, :test_result)
  end
end
