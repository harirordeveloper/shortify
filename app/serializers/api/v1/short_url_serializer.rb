class Api::V1::ShortUrlSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :original_url, :short_code, :short_url

  def short_url
    host = Rails.application.config.action_mailer.default_url_options[:host]
    short_link_url(object.short_code, host: host)
  end
end
