class HomeController < ApplicationController
  before_action :require_login, except: [:index]
  
  def index
      @posts=Post.all.page(params[:page]).per(12).order("created_at DESC")
    
     
  end
  

  def delete
    @del_post = Post.find(params[:post_id])
    @del_post.delete
    
    redirect_to "/home/index"
  end
  
  def delete_reply
    @del_reply = Reply.find(params[:reply_id])
    @del_reply.delete
    
    redirect_to :back
  end
  
  def update_view
    @upd_post = Post.find(params[:post_id])
  end

  def do_update
    
    @do_upd_post = Post.find(params[:post_id])
    
    file = params[:pic]
    
    uploader = MktimageUploader.new
    uploader.store!(file)
    
    @do_upd_post.image_url = uploader.url
    @do_upd_post.title = params[:title]
    @do_upd_post.content = params[:content]
    @do_upd_post.contact = params[:contact]
    @do_upd_post.price = params[:price]
    @do_upd_post.user_id = params[:user_email]
    @do_upd_post.save
    
    redirect_to "/home/index"
  end
  
  def complete
    @new_post = Post.new
    
    file = params[:pic]
   
    uploader = MktimageUploader.new
    uploader.store!(file)
    @new_post.image_url = uploader.url
    
    @new_post.title = params[:title]
    @new_post.content = params[:content]
    @new_post.contact = params[:contact]
    @new_post.user_id = params[:user_email]
    @new_post.price = params[:price]
    @new_post.save
    

    tag = Tag.find_or_create_by(name: params[:hashtag1])
    Hashtag.create(post_id: @new_post.id, tag_id: tag.id)
    
    tag = Tag.find_or_create_by(name: params[:hashtag2])
    Hashtag.create(post_id: @new_post.id, tag_id: tag.id)
    
    tag = Tag.find_or_create_by(name: params[:hashtag3])
    Hashtag.create(post_id: @new_post.id, tag_id: tag.id)
    
    redirect_to "/home/index"
  end
 
  def view_each
    @one_post = Post.find(params[:post_id])
  end
  
  def reply_write
    @new_reply = Reply.new
    @new_reply.content = params[:comment]
    @new_reply.post_id = params[:id_of_post]
    @new_reply.user_id = params[:user_id]
    @new_reply.save
    
    redirect_to :back
  end
  

  def myinfo
    
  end
  
  def show_user_post
    
    @myposts= current_user.posts
        
  end
  

  def tags
    tag = Tag.find_by(name: params[:name])
    @posts = tag.posts.all.page(params[:page]).per(12).order("created_at DESC")
  end
  
end