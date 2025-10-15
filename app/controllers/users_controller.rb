# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
    @student = Student.new
    @teacher = Teacher.new
    @admin = Admin.new
  end

  def edit; end

  def update; end

  def destroy; end
end
