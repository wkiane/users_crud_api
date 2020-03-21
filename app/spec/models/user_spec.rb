require 'rails_helper'

RSpec.describe User, type: :model do

  it "should not create a user without the fields first_name" do
    user = build(:user, first_name: "")
    
    expect(user).to_not be_valid
  end

  it "should not create a user without the fields last_name" do
    user = build(:user, last_name: "")

    expect(user).to_not be_valid
  end

  it "should not update password when length is minus than 6" do
    user = create(:user)
    
    user.password = '1234'
    user.save

    expect(user).to_not be_valid    
  end

end
