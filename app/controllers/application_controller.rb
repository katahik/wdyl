class ApplicationController < ActionController::Base
    # ここでindexを指定していないときは、Can't verify CSRF token authenticity.のエラー
    protect_from_forgery :only => :index
    # deviseにまつわる画面に行ったときに configure_permitted_parameters を実行
    before_action :configure_permitted_parameters, if: :devise_controller?
    # ユーザがログインしていない場合はログインページにリダイレクトさせる
    before_action :authenticate_user!

    protected
    # ストロングパラメーターを追加したい場合
    # diveseではサインアップ時にemailとパスワードのみ受け取るように設定されているから、usernameも追加
    def configure_permitted_parameters
        added_attrs = [ :email, :username, :password, :password_confirmation ]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
        devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    end
end
