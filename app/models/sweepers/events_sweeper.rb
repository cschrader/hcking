class Sweepers::EventsSweeper < ActionController::Caching::Sweeper
  observe Event

  def after_save(event)
    expire_cache_for_events
  end

  private
  def expire_cache_for_events
    expire_page(:controller => 'welcome', :action => 'city')
    expire_fragment('all_events_calendar')
  end
end