# coding:utf-8

class HelloController < ApplicationController
  def index
    render text: 'Hello world!'
  end

  def view
    @msg = 'Hello world <3'
  end

  def list
    @books = Book.all
  end
end
