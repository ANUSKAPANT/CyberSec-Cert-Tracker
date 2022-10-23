class CoursesController < ApplicationController
  before_action :set_course, only: %i[update destroy show]

  def index
    render json: CourseSerializer.new(Course.all).serialized_json
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      render json: @course, status: :created
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: CourseSerializer.new(@course).serialized_json, status: :ok
  end

  def update
    if @course.update(course_params)
      render json: @course, status: :created
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy
  end

  def set_course
    @course = Course.find(params[:id])
  end

  private

  def course_params
    params.permit(:name, :vendor_id)
  end
end
  