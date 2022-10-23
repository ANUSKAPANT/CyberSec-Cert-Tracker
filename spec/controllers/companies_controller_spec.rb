require 'rails_helper'
RSpec.describe CompaniesController, type: :controller do
  describe "GET index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'PATCH update' do
    it 'updates the company' do
      company = Company.new(name: "Test company", smc: true)
      company.save
      patch :update, params: {id: company.id, name: "CompTier" }
      expect(response).to have_http_status(201)
    end

    it 'does not update the company' do
      company = Company.new(name: "Test company", smc: true)
      company.save
      patch :update, params: {id: company.id, name: nil }
      expect(response).to have_http_status(422)
    end
  end

  describe 'GET show' do
    it 'shows the company' do
      company = Company.new( name: "Test company", smc: true)
      company.save
      get :show, params: { id: company.id }
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST create' do
    it 'creates a company and renders a successful response' do
      post :create, params: { name: "CompTier", smc: true }
      expect(response).to have_http_status(201)
    end

    it 'does not create a company' do
      post :create, params: { id: nil }
      expect(response).to have_http_status(422)
    end
  end

  describe 'DESTROY delete' do
    it 'deletes a company and renders a successful response' do
      company = Company.new( name: "Test company", smc: true )
      company.save
      delete :destroy, params: { id: company.id }
      expect(response).to have_http_status(204)
    end
  end
end