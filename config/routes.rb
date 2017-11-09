Rails.application.routes.draw do
  resources :fan_comments
  resources :reviews
  resources :authors
  resources :users
  resources :books
  # resources :recordd
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'hello/index', to: 'hello#index'
  get 'hello/view'
  get 'hello/list'
  get 'recordd/find'
  get 'recordd/find_by'
  get 'recordd/groupby'
  get 'recordd/transact'
  get 'recordd/keywd_process'
  get 'recordd/belongs'
  get 'recordd/hasmany'

  get 'ctrl/para(/:id)', to: 'ctrl#para'
  get 'ctrl/para_array(/:category)', to: 'ctrl#para_array'
  get 'ctrl/req_head'
  get 'ctrl/req_head2'
  get 'ctrl/upload_process'
  get 'ctrl/log'
  get 'ctrl/get_json'
end
