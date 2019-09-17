require "rails_helper"

describe 'Login' do
  before(:each) do
    @user = User.create!(
      email: "whatchamacallit@example.com",
      password: "password",
      password_confirmation: "password"
    )
    allow(User).to receive(:find_by).and_return(@user)
  end

  it "returns the user's api_key" do
    post "/api/v1/sessions?email=whatchamacallit@exeample.com&password=password"

    expect(response).to be_successful

    api_key = JSON.parse(response.body)

    expect(api_key["data"].count).to eq(3)
    expect(api_key["data"]["attributes"]["api_key"]).to eq(@user.api_key)
  end

  it "does not return an api_key" do
    post "/api/v1/sessions?email=whatchamac@exeample.com&password=pord"

    expect(response).to_not be_successful
    api_key = response.body

    expect(api_key).to eq("Your Email or Password is incorrect")
  end
end
