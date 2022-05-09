# frozen_string_literal: true

require File.expand_path('../lib/redmine_admissions/view_hooks', __FILE__)

if Rails.version > '6.0' && Rails.autoloaders.zeitwerk_enabled?
  Rails.application.config.after_initialize do
    RedmineAdmissions.setup
  end
else
  require 'redmine_admissions'
  Rails.configuration.to_prepare do
    RedmineAdmissions.setup
  end
end

Redmine::Plugin.register :redmine_admissions do
  name 'Redmine Admissions Plugin'
  author 'Jens Krämer, Georepublic'
  author_url 'https://github.com/georepublic'
  url 'https://github.com/gtt-project/redmine_admissions'
  description 'Allows users to self-join selected Projects'
  version '2.0.0'

  requires_redmine version_or_higher: '4.0.0'

end
