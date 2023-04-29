class Api::V1::UrlsController < Api::V1::BaseController
  skip_before_action :authenticate_user, only: [:show]
  before_action :find_short_url, only: :show

  def index
    render_resource(current_user.short_urls, ::Api::V1::ShortUrlSerializer, :ok, true)
  end

  def create
    short_url = current_user.short_urls.build(short_url_params)
    if short_url.save
      render_resource(short_url, ::Api::V1::ShortUrlSerializer, :ok)
    else
      render_error(short_url.errors.full_messages.join(', '), :unprocessable_entity)
    end
  end

  def show
    redirect_to @short_url.original_url, status: :moved_permanently, allow_other_host: true
  end

  private

  def short_url_params
    params.require(:short_url).permit(:original_url)
  end

  def find_short_url
    @short_url = ShortUrl.find_by(short_code: params[:id])
    render_error('Short URL not found', :not_found) if @short_url.blank?
  end
end
