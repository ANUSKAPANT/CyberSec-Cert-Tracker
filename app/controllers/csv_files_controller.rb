class CsvFilesController < BaseController
  skip_before_action :authorize_admin

  def create
    @file = CsvFile.new(file_params)
    if @file.save
      @file.create_records(params[:body].path)
      respond_to do |format|
        format.json  { render json: CsvFileSerializer.new(@file).serialized_json, status: :created }
      end
    else
      respond_to do |format|
        format.json { render json: @file.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def file_params
    params.permit(:file_name, :body, :user_id)
  end
end
