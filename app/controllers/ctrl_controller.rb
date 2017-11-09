class CtrlController < ApplicationController
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
end
