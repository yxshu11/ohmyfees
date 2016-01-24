class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  # For security purpose as the call of card number and verification they are not logged.
  # filter_parameter_logging :card_number, :card_verification

end
