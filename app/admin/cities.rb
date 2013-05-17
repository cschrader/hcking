ActiveAdmin.register City do
  menu parent: "Kalender"
  config.sort_order = "name_asc"

  index do
    column :id
    column :name
    column :longitude
    column :latitude

    default_actions
  end

  show do
    render partial: 'show'
  end

  form do
    render partial: 'form'
  end

end
