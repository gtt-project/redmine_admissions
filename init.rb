# frozen_string_literal: true

require 'redmine'

Rails.configuration.to_prepare do
  RedmineAdmissions.setup
end

Redmine::Plugin.register :redmine_admissions do
  name 'Redmine Admissions Plugin'
  author 'Jens Krämer, Georepublic'
  author_url 'https://hub.georepublic.net/gtt/redmine_admissions'
  description 'Allows users to self-join selected Projects'
  version '0.1.0'

  requires_redmine version_or_higher: '3.4.0'

end

