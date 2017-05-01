Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	# it all starts here
  root to: 'landing#index'

  post 'subscribe', to: 'landing#subscribe'
  direct :subscribe do
    { controller: 'landing', action: 'subscribe' }
  end

end
