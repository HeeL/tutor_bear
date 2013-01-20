ActiveAdmin.register BalanceHistory do
  
  index do
    column :user
    column :amount
    column :action
    column :created_at
    
    default_actions
  end
  
  form do |f|
    f.inputs do
      f.input :amount
      f.input :action, as: :select, collection: ['plus', 'minus']
    end

    f.buttons
  end
  
  show do
    attributes_table do
      row :amount
      row :action
      row :created_at
    end
  end
  
end
