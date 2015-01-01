
class RegistrationsController < Devise::RegistrationsController
  
  def after_inactive_sign_up_path_for(resource)

  	check_email_path
  end
  
  private
 
  def sign_up_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, :password, :password_confirmation, :avatar)
  end
 
  def account_update_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, :password, :password_confirmation, :current_password, :avatar)
  end
end