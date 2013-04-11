ActiveAdmin.register User do
  scope_to(:association_method => :unscoped) { User }
  
  index do
    column :name
    column :email
    column :active
    column :created_at
    
    default_actions
  end
  
  form multipart: true do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :active
    end

    f.buttons
  end
  
end
