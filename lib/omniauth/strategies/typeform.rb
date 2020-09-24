# frozen_string_literal: true

require "omniauth"
require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Typeform < OmniAuth::Strategies::OAuth2
      ACCOUNT_SCOPE = "accounts:read"

      option :client_options,
             site: "https://api.typeform.com",
             authorize_url: "/oauth/authorize",
             token_url: "/oauth/token"

      def callback_url
        options[:redirect_uri] || full_host + script_name + callback_path
      end

      def authorize_params
        super.tap do |params|
          scope = params[:scope].to_s.split(/\s+/)
          scope << ACCOUNT_SCOPE unless scope.include?(ACCOUNT_SCOPE)
          params[:scope] = scope.join(" ")
        end
      end

      uid do
        info[:email]
      end

      info do
        identity = raw_info.dup
        identity[:name] = identity.delete(:alias)
        identity
      end

      def raw_info
        @raw_info ||= deep_symbolize(access_token.get("/me").parsed)
      end
    end
  end
end
