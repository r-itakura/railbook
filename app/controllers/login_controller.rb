class LoginController < ApplicationController
  # ログインボタンの押下時に実行されるアクション
  def auth
    #入力値にしたがってユーザー情報を取得
    usr = User.find_by(username: params[:username])
    # ユーザー情報が存在し、認証に成功したら
    if usr && usr.authenticate(params[:passwrod]) then
      # 認証に成功した場合はid値をセッションに設定し、元のページへリダイレクト
      reset_session
      session[:usr] = usr.id
      redirect_to params[:referer]
    else
      # 失敗した場合、flashメッセージをセットしログインページを表示
      flash.now[:referer] = params[:referer]
      @error = 'ユーザー名、パスワードが間違っています'
      render 'index'
    end
  end
end
