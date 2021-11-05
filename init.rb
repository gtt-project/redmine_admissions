# frozen_string_literal: true

require 'redmine'

Rails.configuration.to_prepare do
  RedmineAdmissions.setup
end

Redmine::Plugin.register :redmine_admissions do
  name 'Redmine Admissions Plugin'
  author 'Jens Krämer, Georepublic'
  author_url 'https://github.com/georepublic'
  url 'https://github.com/gtt-project/redmine_admissions'
  description 'Allows users to self-join selected Projects'
  version '1.2.0'

  requires_redmine version_or_higher: '3.4.0'

end

