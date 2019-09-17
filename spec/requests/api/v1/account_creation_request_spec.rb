require "rails_helper"

describe "Acount Creation" do
  it "returns an api_key" do
    allow(SecureRandom)
      .to receive(:urlsafe_base64)
      .and_return("Kgs1XMbmJMzj-iVyz8ZWbg")

    post "/api/v1/users?email=whatever@exeample.com&password=password&password_confirmation=password"

    expect(response).to be_successful
    api_key = JSON.parse(response.body)

    expect(api_key["data"].count).to eq(3)
    expect(api_key["data"]["attributes"]["api_key"]).to eq("Kgs1XMbmJMzj-iVyz8ZWbg")
  end

  it "does not return an api_key" do
    post "/api/v1/users?email=&password=&password_confirmation="

    expect(response).to_not be_successful
    bad_request = response.body

    expect(bad_request).to eq("Password can't be blank and Email can't be blank")
  end
end
