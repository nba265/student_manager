# frozen_string_literal: true

module Customers
  class PasswordsController < Devise::PasswordsController
    def reset_password
      customer = Customer.find_by(email: params[:customer][:email])

      if customer&.valid_password?(params[:customer][:current_password])
        if customer.update(password: params[:customer][:password],
                           password_confirmation: params[:customer][:password_confirmation])
          redirect_to customer_session_path, notice: 'Password has been changed successfully.'
        else
          flash.now[:alert] = 'Password change failed.'
          render :edit
        end
      else
        flash.now[:alert] = 'Email or old password is incorrect.'
        render :edit
      end
    end

    # GET /resource/password/new
    # def new
    #   super
    # end

    # POST /resource/password
    # def create
    #   super
    # end

    # GET /resource/password/edit?reset_password_token=abcdef
    # def edit
    #   super
    # end

    # PUT /resource/password
    # def update
    #   super
    # end

    # protected

    # def after_resetting_password_path_for(resource)
    #   super(resource)
    # end

    # The path used after sending reset password instructions
    # def after_sending_reset_password_instructions_path_for(resource_name)
    #   super(resource_name)
    # end
  end
end
