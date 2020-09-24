# frozen_string_literal: true

require "test_helper"

class AuthorizeParamsTest < Minitest::Test
  let(:app) { ->(env) { } }

  let(:strategy) do
    OmniAuth::Strategies::Typeform.new(app, "consumer_id", "consumer_secret")
  end

  test "sets defaults scopes" do
    strategy.stubs(:session).returns({})
    assert_equal "accounts:read", strategy.authorize_params.scope
  end

  test "injects required scopes" do
    strategy =
      OmniAuth::Strategies::Typeform.new(nil, "ID", "SECRET", scope: "team")
    strategy.stubs(:session).returns({})

    assert_equal "team accounts:read", strategy.authorize_params.scope
  end

  test "sets unique scopes" do
    strategy = OmniAuth::Strategies::Typeform.new(
      nil,
      "ID",
      "SECRET",
      scope: "accounts:read"
    )
    strategy.stubs(:session).returns({})

    assert_equal "accounts:read", strategy.authorize_params.scope
  end
end
