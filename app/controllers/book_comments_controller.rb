class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @book_comment = BookComment.find(params[:id])
    if @book_comment.user == current_user
     @book_comment.destroy
     redirect_to book_path(@book_comment.book)
    end
  end

  private

  def  book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end