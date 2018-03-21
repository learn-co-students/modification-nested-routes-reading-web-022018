class PostsController < ApplicationController

  def index
    if params[:author_id]
      @posts = Author.find(params[:author_id]).posts
    else
      @posts = Post.all
    end
  end

  def show
    if params[:author_id]
      if Author.find(params[:author_id]).posts.find_by_id(params[:id])
        @post = Author.find(params[:author_id]).posts.find_by_id(params[:id])
      else
        flash[:alert] = "Post not found"
        redirect_to author_path(Author.find(params[:author_id]))
      end
    else
      @post = Post.find(params[:id])
    end
  end

  def new
    @post = Post.new(author_id: params[:author_id])
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(params.require(:post))
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :author_id)
  end
end
