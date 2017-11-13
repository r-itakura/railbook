class HelloController < ApplicationController

  # viewアクションのみに適用されるbeforeフィルターcheck_loginedを登録
  before_action :check_logined, only: :view

  def index
    render plain: 'こんにちは、世界！'
  end

  def view
    @msg = 'こんにちは、世界的！'
  end

  def list
    @books = Book.all
  end

  private
  def check_logined
    # セッション情報:usr(id値)が存在するか
    if session[:usr] then
      #存在する場合はuseテーブルを検索し、ユーザ情報を取得
      begin
        @usr = User.find(session[:usr])
        #ユーザー情報が存在しない場合は不正ユーザーとみなし、セッションを破棄
      rescue ActiveRecord::RecordNotFound
        reset_session
      end
    end
    #ユーザー情報を取得できなかった場合はログインページへリダイレクト
    unless @usr
      flash[:refeler] = request.fullpath
      redirect_to controller: :login, action: :index
    end
  end


end
