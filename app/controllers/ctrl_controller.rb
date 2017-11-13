class CtrlController < ApplicationController

  #index アクションに対してbeforeフィルタauthを登録
  before_action :auth, only: :index
  # # before/afterフィルターの登録
  # before_action :start_logger
  # after_action :end_logger

  # around_action :around_logger

  def index
    sleep 3
    render plain: 'indexアクションが実行されました。'
  end

  def index2
    sleep 10
    render plain: 'index2アクションが実行されました。'
  end

  def para
    render plain: 'idパラメータ：' + params[:id]
  end

  def para_array
    render plain: 'categoryパラメータ：' + params[:category].inspect
  end

  def req_head
    render plain: request.headers['User-Agent']
  end

  def req_head2
    @headers = request.headers
    @fullPath = request.fullpath
  end

  def upload_process

    # アップロードファイルを取得
    file = params[:upfile]

    # ファイル名を取得
    name = file.original_filename

    # 許可する拡張子を定義
    params = ['.jpg', '.jpeg', '.gif', '.png']

    # 配列paramsに拡張子が合致するものがあるか
    if !params.include?(File.extname(name).downcase)
      result = 'アップロードできるのは画像ファイルのみです'
    elsif file.size > 1.megabite
      # ファイルが1M以下か
      result = 'ファイルサイズは1Mまでです'
    else
      # /public/doc配下にファイル保存
      File.open("public/docs/#{name}", 'wb') {|f| f.write(file.read)}
      result = "#{name}をアップロードしました"
    end
    # 成功、エラーメッセージを保存
    render plain: result
  end

  def log
    logger.debug('デバッグです')
    render plain: 'ログでた？'
  end

  def get_json
    @books = Book.all
    render json: @books
  end

  private
    def start_logger
      logger.debug('[Start]' + Time.now.to_s)
    end
    def end_logger
      logger.debug('[Finish]' + Time.now.to_s)
    end
    def around_logger
      logger.debug('[Start]' + Time.now.to_s)
      yield # アクションを実行
      logger.debug('[Finish]' + Time.now.to_s)
    end
    def auth
      # 認証に利用するユーザー名、パスワード
      name = 'yyamada'
      passwd = ''
      # 基本認証を実行
      authenticate_or_request_with_http_basic('Railsbook') do |n, p|
        n === name && Digest::SHA1.hexdigest(p) == passwd
      end
    end
end
