require 'journalized_for/version'
require 'journalized_for/callbacks'
require 'journalized_for/journalized_for'

ActiveRecord::Base.send(:include, Redmine::JournalizedFor)