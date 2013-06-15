module PostHelper
  def post_path(controller, post,city="berlin")
    if controller.class == BlogPostsController
      blog_post_path(post,:city => city)
    elsif controller.class == PodcastsController
      podcast_path(post,:city=>city)
    end
  end

  def post_categorie_path(controller, post,city="berlin")
    if controller.class == BlogPostsController
      blog_categorie_path(post,:city => city)
    elsif controller.class == PodcastsController
      podcast_categorie_path(post,:city => city)
    end
  end
end
