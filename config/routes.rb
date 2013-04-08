RedmineApp::Application.routes.draw do
  resources :projects, :only => [] do
    resources :assignees, :only => [] do
      collection do
        get 'autocomplete'
      end
    end
  end
  resources :issues, :only => [] do
    member do
      put :edit
    end
  end
end
