require 'rails_helper'

RSpec.describe ExamsController, type: :controller do
  describe "GET index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'PATCH update' do
    it 'updates the exam' do
      create :cert_voucher
      exam = Exam.new(cert_voucher_id: CertVoucher.first.id, exam_code: "2243", exam_date: "02-01-2022", passed: true, exam_grade: "B")
      exam.save
      patch :update, params: { id:exam.id, first_name: "Anuska", last_name: "Pant" }
      expect(response).to have_http_status(201)
    end

    it 'does not update the exam' do
      create :cert_voucher
      exam = Exam.new(cert_voucher_id: CertVoucher.first.id, exam_code: "2243", exam_date: "02-01-2022", passed: true, exam_grade: "B")
      exam.save
      patch :update, params: {id: exam.id, exam_code: nil }
      expect(response).to have_http_status(422)
    end
  end

  describe 'GET show' do
    it 'shows the exam' do
      create :cert_voucher
      exam = Exam.new(cert_voucher_id: CertVoucher.first.id, exam_code: "2243", exam_date: "02-01-2022", passed: true, exam_grade: "B")
      exam.save
      get :show, params: { id:exam.id }
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST create' do
    it 'creates an exam and renders a successful response' do
      create :cert_voucher
      post :create, params: {cert_voucher_id: CertVoucher.first.id, exam_code: "2243", exam_date: "02-01-2022", passed: true, exam_grade: "B"}
      expect(response).to have_http_status(201)
    end

    it 'does not create an exam' do
      post :create, params: { id: nil }
      expect(response).to have_http_status(422)
    end
  end

  describe 'DESTROY delete' do
    it 'deletes an exam and renders a successful response' do
      create :cert_voucher
      exam = Exam.new(cert_voucher_id: CertVoucher.first.id, exam_code: "2243", exam_date: "02-01-2022", passed: true, exam_grade: "B")
      exam.save
      delete :destroy, params: { id:exam.id }
      expect(response).to have_http_status(204)
    end
  end
end