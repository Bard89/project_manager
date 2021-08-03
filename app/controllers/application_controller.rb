class ApplicationController < ActionController::Base
  # Protect every route by default.
  # at every single action the user have to be authenticated, we can add except 
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  # pundit (authorisation)
  include Pundit

  # Pundit: white-list approach
  # whitelist approach -> every action is denied unless I explicitelly allow it
    # in other words, no action is allowed unlesss explicitly allowed
  # also after every action i call method verify_authorised, I still call pundit, even when i forget
  # it makes sure the pundit is called for every action except for the index one 
  
  # applies to every action, except index action 
  after_action :verify_authorized, except: [:index, :dashboard], unless: :skip_pundit? # the excep is probably just for mon-nested routes !
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?


  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  private
  # skip pundit only when I am in the device controller (user that needs to sign up)
  # or when i'm in the admin or pages controller
  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
