require 'TimeConstraint'

Rails.application.routes.draw do
  resources :members
  resources :fan_comments
  resources :reviews
  resources :authors
  resources :users, except: [ :show, :destroy ]
  resources :books

  # resources :reviews do
  #   get :unapproval, on: :collection
  #   get :draft, on: :member
  # end

  # "浅い"URL p.386
  # resources :books do
  #   resources :reviews, shallow: true
  # end

  # TODO: namespace, scope, module まわり：http://qiita.com/blueplanet/items/522cc8364f6cf189ecad
  # namespace :admin do
  #   resources :books, format: false
  # end

  # id に制限かけたいとき
  # resources :books, constraints: { id: /[0-9]{1,2}/ }

  # 独自関数でやりたいとき　元ファイルはmodels/に置く
  # resources :books, constraints: TimeConstraint.new

  # 復数指定したいとき
  # constraints(id: /[0-9]{1,2}/) do
  #   resources :books
  #   resources :reviews
  # end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  root to: 'books#index'
end
