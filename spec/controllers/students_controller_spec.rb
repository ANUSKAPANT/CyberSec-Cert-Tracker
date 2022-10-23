require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  describe "GET index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'PATCH update' do
    it 'updates the student' do
      create :company
      student = Student.new(first_name: "Anooska", last_name: "Pa", canvas_id: "123", title: "CyberSec", company_id: Company.first.id, email_id: "demo@example.com")
      student.save
      patch :update, params: { id: student.id, first_name: "Anuska", last_name: "Pant" }
      expect(response).to have_http_status(201)
    end

    it 'does not update the student' do
      create :company
      student = Student.new(first_name: "Anooska", last_name: "Pa", canvas_id: "123", title: "CyberSec", company_id: Company.first.id, email_id: "demo@example.com")
      student.save
      patch :update, params: {id: student.id, first_name: nil }
      expect(response).to have_http_status(422)
    end
  end

  describe 'GET show' do
    it 'shows the student' do
      create :company
      student = Student.new(first_name: "Anooska", last_name: "Pa", canvas_id: "123", title: "CyberSec", company_id: Company.first.id, email_id: "demo@example.com")
      student.save
      get :show, params: { id: student.id }
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST create' do
    it 'creates a student and renders a successful response' do
      create :company
      post :create, params: { first_name: "Anooska", last_name: "Pa", canvas_id: "123", title: "CyberSec", company_id: Company.first.id, email_id: "demo@example.com" }
      expect(response).to have_http_status(201)
    end

    it 'does not create a student' do
      post :create, params: { id: nil }
      expect(response).to have_http_status(422)
    end
  end

  describe 'DESTROY delete' do
    it 'deletes a student and renders a successful response' do
      create :company
      student = Student.new(first_name: "Anooska", last_name: "Pa", canvas_id: "123", title: "CyberSec", company_id: Company.first.id, email_id: "demo@example.com")
      student.save
      delete :destroy, params: { id: student.id }
      expect(response).to have_http_status(204)
    end
  end
end