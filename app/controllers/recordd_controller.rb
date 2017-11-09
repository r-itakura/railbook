class RecorddController < ApplicationController
  def find
    @books = Book.find([2, 5, 10])
    logger.debug @books.inspect
    render 'hello/list'
  end

  def find_by
      @book = Book.find_by(publish: '技術評論社')
      render 'books/show'
  end

  def groupby
    @books = Book.select('publish, AVG(price) AS avg_price').group(:publish)
  end

  def keywd
    @search = SearchKeyword.new
  end

  def keywd_process
    @search = SearchKeyword.new(params.require(:search_keyword).permit(:keyword))
    if @search.valid?
      render plain: @search.keyword
    else
      render plain: @search.errors.full_messages[0]
    end
  end

  def belongs
    @review = Review.find(3)
  end

  def hasmany
    @book = Book.find_by(isbn: '978-4-7741-8411-1')
  end

  def transact
    Book.transaction do
      b1 = Book.new({isbn: '978-4-7741-5067-3',
                     title: 'Rubyポケットリファレンス',
                     price: 2580, publish: '技術評論社', published: '2017-04-17'})
      b1.save!
      raise '例外発生：処理はキャンセルされました。'

      b2 = Book.new({isbn: '978-4-7741-5067-5',
                     title: 'Tomcatポケットリファレンス',
                     price: 2580, publish: '技術評論社', published: '2017-05-10'})
      b2.save!
    end
    render plain: 'トランザクションは成功しました。'
  rescue => e
    render plain: e.message
  end
end