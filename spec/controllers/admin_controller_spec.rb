require 'rails_helper'

RSpec.describe AdminController, type: :controller do

  describe "GET #block_ip" do
    it "returns http success" do
      get :block_ip
      expect(response).to have_http_status(:success)
    end
  end

end
