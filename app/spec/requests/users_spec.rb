require 'rails_helper'


RSpec.describe "Auth", type: :request do
  describe "GET /users" do
    # index
    it "should not show index to not logged users" do
      get "/users"

      expect(response).to have_http_status(401)
      expect(response.body).to include_json(
          errors: [
            "You need to sign in or sign up before continuing."
          ]
      )
    end

    it "should not show index to not users" do
      user = create(:user)

      user_headers = user.create_new_auth_token
      get "/users", params: {}, headers: user_headers

      expect(response).to have_http_status(403)
      expect(response.body).to include_json(
          id: "forbidden",
          message: "Você não tem acesso a este recurso."
      )
    end

    it "should show index to admin users" do
      admin = create(:user, role: "admin")

      admin_headers = admin.create_new_auth_token
      get "/users", params: {}, headers: admin_headers

      expect(response).to have_http_status(200)
    end

  end
  
  describe "GET /users/id" do
    it "should not show a user to a not logged user" do
      user = create(:user)
      
      get "/users/#{user.id}"


      expect(response).to have_http_status(401)
      expect(response.body).to include_json(
        errors: [
          "You need to sign in or sign up before continuing."
        ]
      )
    end

    it "should not show another user to a logged user" do
      showed_user = create(:user)
      user = create(:user)

      user_headers = user.create_new_auth_token

      get "/users/#{showed_user.id}", params: {}, headers: user_headers

      expect(response).to have_http_status(403)
      expect(response.body).to include_json(
        id: "forbidden",
        message: "Você não tem acesso a este recurso."
      )
    end

    it "should show the profile to a logged user" do
      user = create(:user)

      user_headers = user.create_new_auth_token

      get "/users/#{user.id}", params: {}, headers: user_headers

      expect(response).to have_http_status(200)
    end

    it "should show any user to an admin user" do
      user = create(:user)
      admin = create(:user, role: "admin")

      admin_headers = admin.create_new_auth_token
      get "/users/#{user.id}", params: {}, headers: admin_headers

      expect(response).to have_http_status(200)
    end
  end

  describe "PUT /users/id" do
    it "should not update a user when not logged in" do 
      user = create(:user)

      user_params = {
        first_name: FFaker::Name.unique.first_name,
        last_name: FFaker::Name.unique.last_name
      }

      put "/users/#{user.id}", params: user_params

      expect(response).to have_http_status(401)
      expect(response.body).to include_json(
          errors: [
            "You need to sign in or sign up before continuing."
          ]
      )
    end

    it "should not update another user account" do
      update_user = create(:user)
      user = create(:user)

      user_params = {
        first_name: FFaker::Name.unique.first_name,
        last_name: FFaker::Name.unique.last_name
      }


      user_headers = user.create_new_auth_token
      put "/users/#{update_user.id}", params: user_params, headers: user_headers

      expect(response).to have_http_status(403)
      expect(response.body).to include_json(
        id: "forbidden",
        message: "Você não tem acesso a este recurso."
      )
    end

    it "should update the current logged profile" do
      user = create(:user)

      user_params = {
        first_name: FFaker::Name.unique.first_name,
        last_name: FFaker::Name.unique.last_name
      }

      user_headers = user.create_new_auth_token
      put "/users/#{user.id}", params: user_params, headers: user_headers

      expect(response).to have_http_status(200)
      expect(response.body).to include_json(
        user_params
      )

    end

    it "should update any account when admin user is logged" do
      admin = create(:user, role: "admin")
      user = create(:user)

      user_params = {
        first_name: FFaker::Name.unique.first_name,
        last_name: FFaker::Name.unique.last_name
      }

      admin_headers = admin.create_new_auth_token
      put "/users/#{user.id}", params: user_params, headers: admin_headers

      expect(response).to have_http_status(200)
      expect(response.body).to include_json(
        user_params
      )
    end

    it "it should not update a password without password_confirm"

    it "it should not update a password and password_confirm are not equal"

    it "it should not update password when length is minus than 6"

    it "should not update role field when user is logged in"

    it "should update role when admin is logged in"
  end


  describe "DELETE /users/id" do
    it "should not deleted a user when not logged in" do
      user = create(:user)

      delete "/users/#{user.id}"

      expect(response).to have_http_status(401)
      expect(response.body).to include_json(
        errors: [
          "You need to sign in or sign up before continuing."
        ]
      )
    end

    it "should not delete another user account" do
      deleted_user = create(:user)
      user = create(:user)

      user_headers = user.create_new_auth_token
      delete "/users/#{deleted_user.id}", params: {}, headers: user_headers

      expect(response).to have_http_status(403)
      expect(response.body).to include_json(
        id: "forbidden",
        message: "Você não tem acesso a este recurso."
      )
    end

    it "should deleted his own account" do
      user = create(:user)

      user_headers = user.create_new_auth_token
      delete "/users/#{user.id}", params: {}, headers: user_headers

      expect(response).to have_http_status(204)
    end

    it "should delete any user account when admin user" do
      admin = create(:user, role: "admin")
      user = create(:user)

      admin_headers = admin.create_new_auth_token
      delete "/users/#{user.id}", params: {}, headers: admin_headers

      expect(response).to have_http_status(204)
    end
  end  
end