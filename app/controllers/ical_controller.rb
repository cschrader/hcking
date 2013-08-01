class IcalController < ApplicationController
  GABBA_MAPPING = {
    general: "iCal",
    personalized: "iCal-personalized",
    like_welcome_page: "iCal-not-hated"
  }

  before_filter :set_calendar_headers
  before_filter :gabba,
    only: GABBA_MAPPING.keys,
    if: ->{ Rails.env.production? }
  rescue_from ActiveRecord::RecordNotFound, with: :render_empty

  def general
    render_events SingleEvent.where(occurrence: time_range)
  end

  def personalized
    render_events user.single_events.where(occurrence: time_range)
  end

  def like_welcome_page
    @presets_json = CalendarPreset.presets_for_user(user)

    if params[:city]
      @city = City.find_by_name params[:city]
      @single_events = SingleEvent.where(occurrence: time_range).in_categories(@presets_json[:diy]).where(:city_id => @city.id)
    else
      @single_events = SingleEvent.where(occurrence: time_range).in_categories(@presets_json[:diy])
    end


    @single_events.select! { |single_event| single_event.is_for_user? user }
    render_events @single_events
  end

  def for_single_event
    render_event SingleEvent.find(params[:id])
  end

  def for_event
    render_events Event.find(params[:id]).single_events
  end

  def for_tag
    render_events SingleEvent.only_tagged_with(params[:id])
  end

  private

  def set_calendar_headers
    response.headers["Content-Type"] = "text/calendar; charset=UTF-8"
  end

  def render_event(event)
    ri_cal = RiCal.Calendar
    ri_cal.events.push event.to_ri_cal_event(is_google_bot)
    render text: ri_cal
  end

  def render_events(events)
    ri_cal = RiCal.Calendar
    ri_cal.events.push(*events.to_a.map do |e| 
      e.to_ri_cal_event(is_google_bot)
    end)
    render text: ri_cal
  end

  def render_empty
    render_events []
  end

  def gabba
    gabba = Gabba::Gabba.new "UA-35910989-2", "nerdhub.de"
    gabba.event "Event", GABBA_MAPPING[params[:action].to_sym]
  end

  def time_range
    (Date.today - 1.months)..(Date.today + 2.months)
  end

  def user
    User.find_by_guid(params[:guid]) || raise(ActiveRecord::RecordNotFound)
  end

end
