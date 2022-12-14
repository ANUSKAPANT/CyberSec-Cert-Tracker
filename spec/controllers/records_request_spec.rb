require 'rails_helper'

RSpec.describe 'Records', type: :request do

  before (:each) do
    create(:user)
  end

  let!(:records) { create_list(:student_course, 5) }

  describe 'GET /records' do
    before do
      records.first(3).each do |student_course|
        create(:cert_voucher, student_course: student_course)
      end
    end
    it 'renders unauthorized' do
      get records_path
      expect(response).to have_http_status(401)
    end
    it 'returns records' do
      get records_path, headers: { "Authorization": "Bearer #{User.first.token}" }
      json = JSON.parse(response.body)
      expect(json).not_to be_empty
      expect(json['records'].size).to eq(5)
    end
    it 'returns status code 200' do
      get records_path, headers: { "Authorization": "Bearer #{User.first.token}" }
      expect(response).to have_http_status(200)
    end
  end
end