scope 'projects/:project_id' do
  resource :admissions, only: %i(create destroy update show)
end
