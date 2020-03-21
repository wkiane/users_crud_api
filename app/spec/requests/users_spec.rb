require 'rails_helper'
require "rspec/json_expectations"


RSpec.describe "Users", type: :request do
  describe "POST /auth" do
    it "it should create a user" do
      user_params = attributes_for(:user)
    
      post "/auth", params: user_params
    
      expect(response).to have_http_status(200)
      expect(response.body).to include_json(
        status: "success"
      )
    end

    it "it should not create a user without the first_name" do
      user_params = attributes_for(:user, first_name: "")
    
      post "/auth", params: user_params
      
      expect(response).to have_http_status(422)
      expect(response.body).to include_json(
        status: "error",
        errors: {
          first_name: [
            "can't be blank"
          ],
        }
      )
    end

    it "it should not create a user without the last_name" do
      user_params = attributes_for(:user, last_name: "")
    
      post "/auth", params: user_params
      
      expect(response).to have_http_status(422)
      expect(response.body).to include_json(
        status: "error",
        errors: {
          last_name: [
            "can't be blank"
          ],
        }
      )
    end
  end
end



