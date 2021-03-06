class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:login, :avatar, :birthday, :country, :city, :address, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:login, :avatar, :birthday, :country, :city, :address, :email, :password, :password_confirmation, :current_password)
  end

end
