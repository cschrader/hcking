class PodcastsController < BlogPostsController
  before_filter :sidebar_values
  before_filter :advertisement, :only => [:index, :show]

  def index
    @posts = BlogPost.for_web.podcast.order("publishable_from desc").page(params[:page]).per(10)
    find_post_by_params
  end

  def show
    @post = BlogPost.find(params[:id])
  end

  def feed
    @category = Category.find(params[:category_id])
    @posts = BlogPost.for_web.podcast.where("category_id=?", params[:category_id]).limit(10)
    render 'podcasts/feed.rss', :layout => false
  end

  private

  def advertisement
    @advertisement = Advertisement.podcast
  end

  def sidebar_values
    @categories = Category.unscoped.where("id in (select category_id from blog_posts where blog_type='podcast' and publishable)").uniq.order(:title)
    @single_events = SingleEvent.where("occurrence > ?", Time.now).limit(3)
  end
end
