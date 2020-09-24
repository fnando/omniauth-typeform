# frozen_string_literal: true

require "test_helper"

class DataTest < Minitest::Test
  let(:app) { ->(env) { } }

  let(:strategy) do
    OmniAuth::Strategies::Typeform.new(app, "consumer_id", "consumer_secret")
  end

  let(:payload) do
    {
      "alias" => "john",
      "language" => "English",
      "email" => "john@example.com"
    }
  end

  test "returns info" do
    info = {email: "john@example.com", name: "john", language: "English"}
    raw_info = {email: "john@example.com", alias: "john", language: "English"}
    strategy.stubs(:raw_info).returns(raw_info)

    assert_equal info, strategy.info
  end

  test "returns raw info" do
    access_token = mock("access_token")
    response = mock("response", parsed: payload)
    access_token.expects(:get).with("/me").returns(response)
    strategy.stubs(:access_token).returns(access_token)

    raw_info = Hash[*payload.map {|(k, v)| [k.to_sym, v] }.flatten]

    assert_equal raw_info, strategy.raw_info
  end

  test "returns uid" do
    access_token = mock("access_token")
    response = mock("response", parsed: payload)
    access_token.expects(:get).with("/me").returns(response)
    strategy.stubs(:access_token).returns(access_token)

    assert_equal "john@example.com", strategy.uid
  end
end
