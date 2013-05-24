ActiveAdmin.register Box do
  menu label: "Welcome Page", priority: 1

  index do
    column :id
    column :content_type
    column :grid_position
    column :city do |box|
      (box.city.nil?) ? '---' : box.city.name
    end
    column :carousel_position
    column :created_at
    column :updated_at

    default_actions
  end

  form do |f|
    types = {}
    [SingleEvent, BlogPost, Event, Advertisement].each do |model|
      types[model.model_name.human] = model
    end

    cities = {}
    City.all.each do |city|
      cities[city.name] = city.id
    end

    f.inputs do
      f.input :content_type, as: :select, collection: types
      f.input :content, as: :select, collection: SingleEvent.in_next(6.weeks), wrapper_html: { id: "SingleEvent" }
      f.input :content, as: :select, collection: BlogPost.most_recent, wrapper_html: { id: "BlogPost" }
      f.input :content, as: :select, collection: Event.all, wrapper_html: { id: "Event" }
      f.input :city, as: :select, collection: cities
    end

    f.inputs do
      f.input :carousel_position
      f.input :grid_position
    end

    f.actions
  end
end
