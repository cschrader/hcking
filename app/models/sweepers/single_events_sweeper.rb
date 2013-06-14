class Sweepers::SingleEventSweeper < ActionController::Caching::Sweeper
  observer SingleEvent

  def after_save(single_event)
    expire_cache_for_single_events
  end

  private
  def expire_cache_for_single_events
    expire_page(:controller => 'welcome', :action => 'city')
    expire_fragment('all_events_calendar')
  end
end