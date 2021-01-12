class ApplicationController < ActionController::Base
    # ここでindexを指定していないときは、Can't verify CSRF token authenticity.のエラー
    protect_from_forgery :only => :index
    # ユーザがログインしていない場合はログインページにリダイレクトさせる
    before_action :authenticate_user!
end
