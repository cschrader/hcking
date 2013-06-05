class BlogPostsController < ApplicationController

  before_filter :sidebar_values
  before_filter :advertisement, :only => [:index, :show, :feed]

  def index
    @city = City.find_by_name params[:city]
    @posts = BlogPost.for_web.blog.order("publishable_from desc").page(params[:page]).per(10).where(:city_id => @city.id)
    find_post_by_params
  end

  def show
    @post = BlogPost.find(params[:id])
  end

  def feed
    @posts = BlogPost.for_web.blog.limit(10)
    respond_to do |format|
      format.atom { render :layout => false }
    end
  end

  private

  def advertisement
    case params[:action]
    when 'show', 'index'
      @advertisement = Advertisement.blog_post
    when 'feed'
      @advertisement = Advertisement.rss
    end
  end

  def find_post_by_params
    if params[:year]
      if params[:day]
        start_date = DateTime.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
        end_date = start_date
      elsif params[:month]
        start_date = DateTime.new(params[:year].to_i, params[:month].to_i)
        end_date = start_date.end_of_month
      else
        start_date = DateTime.new(params[:year].to_i)
        end_date = start_date.end_of_year
      end

      @posts = @posts.where("publishable_from >= ? and publishable_from <= ?", start_date, end_date)
    elsif params[:category_id]
      @current_category = Category.find(params[:category_id])
      @posts = @posts.where(category_id: params[:category_id])
    end
  end

  def sidebar_values
    @categories = Category.where("id in (select category_id from blog_posts where blog_type = 'blog' and publishable)").uniq.order(:title)
    @single_events = SingleEvent.where("occurrence > ?", Time.now).limit(3)
  end
end
