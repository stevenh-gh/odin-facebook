class ProfilesController < ApplicationController
  before_action(:set_profile, only: %i[edit update])

  def index
    @profile = current_user.profile || current_user.create_profile
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile.attributes = profile_params
    @profile.age = Date.today - @profile.birthday
    if @profile.save
      flash[:success] = 'Profile has been updated.'
      redirect_back(fallback_location: root_path)
    else
      redirect(root_path)
    end
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:photo, :sex, :birthday, :hometown, :current_location, :bio)
  end
end
