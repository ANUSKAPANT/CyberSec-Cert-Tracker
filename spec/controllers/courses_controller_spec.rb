require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe "GET index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'PATCH update' do
    it 'updates the course' do
      create :vendor
      course = Course.new(name: "Test course", vendor_id: Vendor.first.id)
      course.save
      patch :update, params: {id: course.id, name: "New Course" }
      expect(response).to have_http_status(201)
    end

    it 'does not update the course' do
      create :vendor
      course = Course.new(name: "Test course", vendor_id: Vendor.first.id)
      course.save
      patch :update, params: {id: course.id, name: nil }
      expect(response).to have_http_status(422)
    end
  end

  describe 'GET show' do
    it 'shows the course' do
      create :vendor
      course = Course.new(name: "Test course", vendor_id: Vendor.first.id)
      course.save
      get :show, params: { id: course.id }
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST create' do
    it 'creates a course and renders a successful response' do
      create :vendor
      post :create, params: { name: "Test course", vendor_id: Vendor.first.id }
      expect(response).to have_http_status(201)
    end

    it 'does not create a course' do
      post :create, params: { id: nil }
      expect(response).to have_http_status(422)
    end
  end

  describe 'DESTROY delete' do
    it 'deletes a course and renders a successful response' do
      create :vendor
      course = Course.new(name: "Test course", vendor_id: Vendor.first.id)
      course.save
      delete :destroy, params: { id: course.id }
      expect(response).to have_http_status(204)
    end
  end
end