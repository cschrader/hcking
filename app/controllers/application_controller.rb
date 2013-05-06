class ApplicationController < ActionController::Base
  include CommentsPathHelper
  include OpengraphHelper

  protect_from_forgery

  before_filter :set_current_user

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: "Leider darfst du das nicht."
  end

  # TODO: Dies ist notwendig, da bei ActiveAdmin noch ein
  #       Bug existiert, der das Locale leider auf Englisch
  #       zurücksetzt. Siehe auch:
  #       https://github.com/gregbell/active_admin/issues/434
  before_filter :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def authenticate_admin_user! #use predefined method name
    redirect_to '/' and return if user_signed_in? && !current_user.admin
    authenticate_user!
  end

  def current_admin_user #use predefined method name
    return nil if user_signed_in? && !current_user.admin
    current_user
  end
  helper_method :current_admin_user

  def is_google_bot
    !request.env["HTTP_USER_AGENT"].match(/googlebot/i).nil?
  end

  private

  def set_current_user
    User.current = current_user
  end

end
