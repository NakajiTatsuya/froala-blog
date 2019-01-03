Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "articles#index"
  resources :articles

  get 'articles/:id/tag' => 'articles#tag', as: 'manage_tag'

  # get 'manage-tag/cakephp' => 'articles#cakephp', as: 'manage_tag_cakephp'
  # get 'manage-tag/php' => 'articles#php', as: 'manage_tag_php'
  # get 'manage-tag/swift' => 'articles#swift', as: 'manage_tag_swift'
  # get 'manage-tag/reactnative' => 'articles#reactnative', as: 'manage_tag_reactnative'
  # get 'manage-tag/rubyonrails' => 'articles#rubyonrails', as: 'manage_tag_rubyonrails'

end