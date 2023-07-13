class BooksController < ApplicationController
  before_action :authenticate_request, except: [:index, :show]

  def index
    @books = Book.all
    render json: @books
  end

  def show
    @book = Book.find(params[:id])
    render json: @book
  end

 
  def new
    @book = Book.new
  end

  
  def edit
    @book = Book.find(params[:id])
  end

  
  def create
    unless current_user
      render json: { error: 'Unauthorized' }, status: :unauthorized
      return
    end
    
    @book = @current_user.books.create(book_params)
    #@book.user = current_user
    
    if @book.save
      render json: @book, status: :created
    else
      render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def book_params
      params.require(:book).permit(:title, :author, :price, :published_at, :user_id)
    end
end
