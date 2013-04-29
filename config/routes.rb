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
  match '/watchers/autocomplete_for_project/:project_id' => 'watchers#autocomplete_for_project',
        :via => :get,
        :as => 'autocomplete_project_watchers'
end
