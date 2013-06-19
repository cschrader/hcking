class Sweepers::BoxesSweeper < ActionController::Caching::Sweeper
  observe Box

  def after_save(box)
    expire_cache_for_events
  end

  private
  def expire_cache_for_events
    expire_fragment('all_events_calendar')
  end
end