RedmineApp::Application.routes.draw do
  resources :projects, :only => [] do
    resources :assignees, :only => [] do
      collection do
        get 'autocomplete'
      end
    end
  end
end
