class PostsController < ApplicationController
  before_action :members_only, only: [:new, :create]
  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)
    @post.user_id = session[:user_id]
		if @post.save
			redirect_to root_url
		else
  		render 'new'
		end
  end

  def index
  	@posts = Post.all
  end

  private
  	def members_only
      unless logged_in?
        flash[:danger] = 'Please log in to make a post'
        redirect_to login_path
      end
    end

    def post_params
  		params.require(:post).permit(:body)
  	end
end
