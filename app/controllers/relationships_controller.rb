class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @user = User.find(params[:relationship][:Followed_id])
    current_user.Follow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).Followed
    current_user.unFollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end