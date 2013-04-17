class UsersController < ApplicationController

  before_filter :authenticate_user!, only: [:edit, :update, :logout]
  before_filter :get_langs, only: :edit
  before_filter :set_langs, only: :update
  before_filter :check_reg_count, only: :register

  def show
    @user = User.find(params[:id])
  end
  
  def update
    if !current_user.update_attributes(params[:user])
      result = set_error(current_user.errors.full_messages.first)
    else
      result = set_success('Profile updated')
    end
    render json: result
  end

  def logout
    sign_out current_user
    flash[:notice] = 'Signed out successfully'
    redirect_to root_path
  end

  def login
    user = User.where(email: params[:email].to_s.downcase).first
    if !user
      result = set_error("We don't have a user with such email")
    elsif !user.valid_password?(params[:password])
      result = set_error("The password is not correct")
    else
      sign_in user
      result = set_success
    end
    render json: result
  end

  def register
    user = User.create(
      email: params[:email],
      password: params[:password], 
      name: params[:email].to_s.split('@').first
    )
    if user.persisted?
      sign_in user
      result = set_success
    else
      result = set_error(user.errors.full_messages.first)
    end
    render json: result
  end

  private

  def check_reg_count
    reg_count = User.where('created_at >= ? AND  last_sign_in_ip = ?', Time.now - 24.hours, request.remote_ip).count
    if reg_count >= 20
      render json: set_error('Too many registrations from your IP')
      return false
    end
  end

  def get_langs
    @langs = {}
    %w(learner teacher).each do |lt|
      @langs[lt.to_sym] = current_user.send(lt).languages.map(&:name).join(',')
    end
  end

  def set_langs
    %w(learner teacher).each do |lt|
      current_user.send(lt).languages = Language.with_translations.where('language_translations.name' => params["#{lt}_langs".to_sym].to_s.split(','))
    end
  end

end
