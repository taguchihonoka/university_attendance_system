# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
    @student = @user.build_student
    #@teacher = Teacher.new(user_id:@user.id)
    #@admin = Admin.new(user_id:@user.id)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      if @user.role_id.to_i == 1
        @student = @user.build_student(student_params)
        if @student.save
          redirect_to @user, notice: 'ユーザー「#{@user.name}」を登録しました'
        else
          flash.now[:alert] = '登録に失敗しました'
          @student ||= Student.new
          render :new
        end

      elsif @user.role_id.to_i == 2
        @teacher = Teacher.new(teacher_params)
        if @user.save && @teacher.save
          redirect_to @user, notice: 'ユーザー「#{@user.name}」に失敗しました'
        else
          flash.now[:alert] = '登録に失敗しました'
          render :new
        end

      elsif @user.role_id.to_i == 3
        @admin = Admin.new(admin_params)
        if @user.save && @admin.save
          redirect_to @user, notice: 'ユーザー「#{@user.name}」を登録しました'
        else 
          flash.now[:alert] = '登録に失敗しました'
          render :new
        end
      end

    else
      Rails.logger.debug "User errors: #{@user.errors.full_messages}"
      Rails.logger.debug "Student errors: #{@student&.errors&.full_messages}"
      Rails.logger.debug "student_params: #{student_params.inspect}"
      Rails.logger.debug "@student is nil? #{ @student.nil? }"
      flash.now[:alert] = '登録に失敗しました'
      @student ||= Student.new
      render :new
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  # フォームで別々に入力された年月日をくっつける
  def build_date(hash, prefix)
    y, m, d = hash["#{prefix}_year"], hash["#{prefix}_month"], hash["#{prefix}_day"] 
    Date.new(y.to_i, m.to_i, d.to_i) rescue nil
  end

  def user_params
    params.expect(user: %i[first_name last_name first_name_kana last_name_kana email password role_id identifier])
  end

  # raw に代入した後enrolled_date を合成しその値を返す
  def student_params
    raw = params.expect(user: { student: %i[attendance_number department_id grade enrolled_year enrolled_month enrolled_day graduated_year graduated_month graduated_day dropout_year dropout_month dropout_day] })[:student]

    raw.merge(
      enrolled_date: build_date(raw, :enrolled),
      graduated_date: build_date(raw, :graduated),
      dropout_date: build_date(raw, :dropout)
    ).except(
      :enrolled_year, :enrolled_month, :enrolled_day,
      :graduated_year, :graduated_month, :graduated_day,
      :dropout_year, :dropout_month, :dropout_day
    )
  end

  def teacher_params
    params.expect(teacher: %i[instoructor_number department position assigned_date retired_date])
  end

  def admin_params
    params.expect(admin: %i[admin_number joined_date retired_date])
  end
end
