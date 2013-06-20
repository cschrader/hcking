# encoding: utf-8

class SingleEventsController < ApplicationController
  respond_to :html, :xml

  def show
    @advertisement = Advertisement.single_event
    @single_event = SingleEvent.find params[:id]
    opengraph_data @single_event.to_opengraph
    @event = @single_event.event
    respond_with @single_event
  end

  def after_save(single_event)
    expire_cache_for_single_events
  end

  private
  def expire_cache_for_single_events
    expire_fragment('all_events_calendar')
  end
  
end
