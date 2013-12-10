RedmineApp::Application.routes.draw do
  resources :issues, :only => [] do
    member do
      put :edit
    end
  end
  match '/projects/:project_id/issues/new', :to => 'issues#new', :as => 'switch_simple_mode_for_new', :via => :post
end
