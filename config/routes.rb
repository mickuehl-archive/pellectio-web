Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	# it all starts here
  root to: 'landing#index'

  # retrieve and display an item
  get '/i/:region/:asin', :to => 'items#show'

  # redirect to Amazon
  get '/a/:region/:asin', :to => 'items#affiliate'

  # subscribe to the email list
  post 'subscribe', to: 'landing#subscribe'
  direct :subscribe do
    { controller: 'landing', action: 'subscribe' }
  end

  # sitemap.xml
  get 'sitemap.txt', :to => 'sitemap#index'

  # support for legacy routes
  get '/home', :to => 'landing#index'

end
