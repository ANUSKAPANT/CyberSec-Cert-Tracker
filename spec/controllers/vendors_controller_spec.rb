require 'rails_helper'
RSpec.describe VendorsController, type: :controller do
  describe "GET index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'PATCH update' do
    it 'updates the vendor' do
      vendor = Vendor.new(name: "Test vendor")
      vendor.save
      patch :update, params: {id: vendor.id, name: "CompTier" }
      expect(response).to have_http_status(201)
    end

    it 'does not update the vendor' do
      vendor = Vendor.new(name: "Test vendor")
      vendor.save
      patch :update, params: {id: vendor.id, name: nil }
      expect(response).to have_http_status(422)
    end
  end

  describe 'GET show' do
    it 'shows the vendor' do
      vendor = Vendor.new( name: "Test vendor" )
      vendor.save
      get :show, params: { id: vendor.id }
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST create' do
    it 'creates a vendor and renders a successful response' do
      post :create, params: { name: "CompTier" }
      expect(response).to have_http_status(201)
    end

    it 'does not create a vendor' do
      post :create, params: { id: nil }
      expect(response).to have_http_status(422)
    end
  end

  describe 'DESTROY delete' do
    it 'deletes a vendor and renders a successful response' do
      vendor = Vendor.new( name: "Test vendor" )
      vendor.save
      delete :destroy, params: { id: vendor.id }
      expect(response).to have_http_status(204)
    end
  end
end