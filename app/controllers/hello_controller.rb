class HelloController < ApplicationController
  def index
    render plain: 'こんにちは、世界！'
  end

  def view
    @msg = 'こんにちは、世界的！'
  end

  def list
    @books = Book.all
  end
end
