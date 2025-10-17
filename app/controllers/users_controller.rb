# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Layout/LineLength

# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
    @student = @user.build_student
    @teacher = @user.build_teacher
    @admin = @user.build_admin
  end

  def edit; end

  def create
    @user = User.new(user_params)

    if @user.valid?
      case @user.role_id.to_i
      when 1
        @student = @user.build_student(student_params)
        if @student.save && @user.save
          redirect_to @user, notice: "ユーザー「#{@user.name}」を登録しました"
        else
          flash.now[:alert] = '登録に失敗しました'
          render :new
        end

      when 2
        @teacher = @user.build_teacher(teacher_params)
        logger.debug "teacher_params: #{teacher_params.inspect}"
        if @teacher.save && @user.save
          logger.debug "assigned_date: #{@user.teacher.assigned_date.inspect}"
          redirect_to @user, notice: "ユーザー「#{@user.name}」に失敗しました"
        else
          flash.now[:alert] = '登録に失敗しました'
          render :new
        end

      when 3
        @admin = @user.build_admin(admin_params)
        if @admin.save && @user.save
          redirect_to @user, notice: "ユーザー「#{@user.name}」を登録しました"
        else
          flash.now[:alert] = '登録に失敗しました'
          render :new
        end
      end

    else
      flash.now[:alert] = '登録に失敗しました'
      render :new
    end
  end

  def update; end

  def destroy; end

  private

  # フォームで別々に入力された年月日をくっつける
  def build_date(hash, prefix)
    y = hash["#{prefix}_year"]
    m = hash["#{prefix}_month"]
    d = hash["#{prefix}_day"]
    begin
      Date.new(y.to_i, m.to_i, d.to_i)
    rescue StandardError
      nil
    end
  end

  def user_params
    params.expect(user: %i[first_name last_name first_name_kana last_name_kana email password role_id identifier])
  end

  # raw に代入した後、年月日を合成しその値を返す
  def student_params
    raw = params.expect(user: { student: %i[attendance_number department_id grade enrolled_year enrolled_month
                                            enrolled_day graduated_year graduated_month graduated_day dropout_year dropout_month dropout_day] })[:student]

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
    raw = params.expect(user: { teacher: %i[instructor_number department_id position_id assigned_year assigned_month
                                            assigned_day retired_year retired_year retired_month retired_day] })[:teacher]

    raw.merge(
      assigned_date: build_date(raw, :assigned),
      retired_date: build_date(raw, :retired)
    ).except(
      :assigned_year, :assigned_month, :assigned_day,
      :retired_year, :retired_month, :retired_day
    )
  end

  def admin_params
    raw = params.expect(user: { admin: %i[admin_number joined_year joined_month joined_day retired_year retired_month
                                          retired_day] })[:admin]

    raw.merge(
      joined_date: build_date(raw, :joined),
      retired_date: build_date(raw, :retired)
    ).except(
      :joined_year, :joined_month, :joined_day,
      :retired_year, :retired_month, :retired_day
    )
  end
end

# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Layout/LineLength
