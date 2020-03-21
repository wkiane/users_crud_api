require 'rails_helper'

RSpec.describe User, type: :model do

  it "it should not create a user without the fields first_name" do
    user = build(:user, first_name: "")
    
    expect(user).to_not be_valid
  end

  it "it should not create a user without the fields last_name" do
    user = build(:user, last_name: "")

    expect(user).to_not be_valid
  end

end
