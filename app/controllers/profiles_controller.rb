class ProfilesController < ApplicationController
  before_action(:authorize_user, only: %i[edit update])
  before_action(:set_profile, only: %i[edit update])

  # def index
  def show
    @profile = Profile.where(user_id: params[:user_id]).first
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile.attributes = profile_params
    @profile.age = Date.today.year - @profile.birthday.year unless profile_params[:birthday].blank?
    if @profile.save
      flash[:success] = 'Profile has been updated.'
      redirect_to(user_profile_path)
    else
      redirect(root_path)
    end
  end

  private

  def authorize_user
    unless current_user.id.eql?(params[:user_id].to_i)
      flash[:error] = 'You cannot access this page'
      redirect_back(fallback_location: root_path)
    end
  end

  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:photo, :sex, :birthday, :hometown, :current_location, :bio)
  end
end
