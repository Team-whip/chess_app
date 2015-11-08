class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:player).permit(:first_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:player).permit(:email, :password, :password_confirmation, :current_password)
  end

end
