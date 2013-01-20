ActiveAdmin.register Language do
  
  index do
    column :name
    
    default_actions
  end
  
  form do |f|
    f.inputs do
      f.input :name
    end

    f.buttons
  end
  
  show do
    attributes_table do
      row :name
    end
  end
  
end
