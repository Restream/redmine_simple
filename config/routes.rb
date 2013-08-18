RedmineApp::Application.routes.draw do
  resources :issues, :only => [] do
    member do
      put :edit
    end
  end
end
