class Clearance::UsersController < Clearance::BaseController
  before_action :redirect_signed_in_users, only: [:create, :new]

  # 会員登録画面の表示
  def new
    @user = user_from_params
    render template: "users/new"
  end

  # 会員登録処理 & ログイン処理
  def create
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
  end

  private

  # ログインしていた場合ルートにリダイレクトさせる
  def redirect_signed_in_users
    if signed_in?
      redirect_to Clearance.configuration.redirect_url
    end
  end

  # 会員登録後のリダイレクト先のURL
  def url_after_create
    Clearance.configuration.redirect_url
  end

  # 入力フォームからemailとpasswordを取得する
  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
    end
  end

  def user_params
    params[:user] || Hash.new
  end
end