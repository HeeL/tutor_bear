ActiveAdmin.register User do
  scope_to(:association_method => :unscoped) { User }
  
  index do
    column :name
    column :email
    column :created_at
    column :min_price
    column :max_price
    
    default_actions
  end
  
  form multipart: true do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :min_price
      f.input :max_price
      f.input :active
    end

    f.buttons
  end
  
end
