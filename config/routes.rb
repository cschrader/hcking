Hcking::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "callbacks" }

  devise_scope :users do
    get 'users', :to => 'users#show', :as => :user_root # Rails 3
  end

  ActiveAdmin.routes(self)

  namespace :admin do
    resources :events do
      resources :single_events
    end
  end

  namespace :api do
    resource :calendar, only: [:show] do
      get :presets
      get :entries

      post :presets, :action => :update_presets
    end

    resources :user_tags, :path => "/user/:kind", :constraints => { id: /.*/, kind: /(like|hate)/ }, :only => [:create, :destroy]
    match "markdown_converter" => "markdown_converter#convert"
  end

  if defined?(Smurfville) != nil
    mount Smurfville::Engine => "/smurfville"
  end

  resources :users, only: [:show] do
    resources :authorizations, only: [:destroy]
  end

  match "podcast/category/:category_id" => "podcasts#index", as: "podcast_categorie"
  match "podcast/:year" => "podcasts#index", year: /\d{4}/
  match "podcast/:year/:month" => "podcasts#index", year: /\d{4}/, month: /\d{1,2}/
  match "podcast/:year/:month/:day" => "podcasts#index", year: /\d{4}/, month: /\d{1,2}/,  day: /\d{1,2}/
  match "podcast/:year/:month/:day/:id" => "podcasts#show"
  match "podcast/feed/:category_id" => "podcasts#feed", as: "podcast_feed"

  resources :podcasts, path: "podcast", only: [:show] do
    resources :comments, except: [:new]
  end

  match 'podcasts/:city' => 'podcasts#index', as: "podcasts"

  resources :blog_posts, path: "blog", only: [:show] do
    collection do
      get :feed, defaults: { format: 'atom' }
    end
    resources :comments, except: [:new]
  end

  match "blog/category/:category_id" => "blog_posts#index", as: "blog_categorie"
  match "blog/:year" => "blog_posts#index", year: /\d{4}/
  match "blog/:year/:month" => "blog_posts#index", year: /\d{4}/, month: /\d{1,2}/
  match "blog/:year/:month/:day" => "blog_posts#index", year: /\d{4}/, month: /\d{1,2}/,  day: /\d{1,2}/
  match "blog/:year/:month/:day/:id" => "blog_posts#show"

  resources :signed_urls, only: :index

  resources :search, only: [:index]
  resources :comments, only: [:create, :edit, :show]
  resources :suggestions, only: [:new, :create, :show]
  #resource :calendar, only: [:show]

  resources :events, only: [:index, :show] do
    resources :comments, except: [:new]

    resources :single_events, path: "dates", only: [:show] do
      resource :participate, only: [:update], constraints: { state: /(push|delete)/ }
      resources :comments, except: [:new]
    end
  end

  match "calendar/", :to => redirect("/calendar/K%C3%B6ln")
  match "calendar/:city"     => "calendars#show", :as => "calendar"
  match "blog_post/:city"           => "blog_posts#index", :as => 'blog_posts'
  match "ical/:city"                    => "ical#general"
  match "personalized_ical/:guid/:city" => "ical#personalized"
  match "user_ical/:guid/:city"         => "ical#like_welcome_page"
  match "ical"                    => "ical#general"
  match "personalized_ical/:guid" => "ical#personalized"
  match "user_ical/:guid"         => "ical#like_welcome_page"
  match "single_event_ical/:id"   => "ical#for_single_event"
  match "event_ical/:id"          => "ical#for_event"
  match "tag_ical/:id"            => "ical#for_tag"
  match "abonnieren"              => "subscribe#index"
  match "humans"                  => "humans#index"
  match "impressum"               => "pages#show", page_name: "impressum"
  match "newsletter"              => "pages#show", page_name: "newsletter"
  match ":page_name"              => "pages#show"
  match "city/:city"                     => "welcome#city", :as => "welcome"

  root to: "welcome#index"
end
