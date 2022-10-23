class CompaniesController < ApplicationController
  before_action :set_company, only: %i[update destroy show]

  def index
    render json: CompanySerializer.new(Company.all).serialized_json
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      render json: @company, status: :created
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: CompanySerializer.new(@company).serialized_json, status: :ok
  end

  def update
    if @company.update(company_params)
      render json: @company, status: :created
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @company.destroy
  end

  def set_company
    @company = Company.find(params[:id])
  end

  private

  def company_params
    params.permit(:name, :smc)
  end
end
