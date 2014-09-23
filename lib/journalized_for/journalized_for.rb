module Redmine
  module JournalizedFor
    extend ActiveSupport::Concern

    module ClassMethods
      def journalized_for(name, options ={})
        cattr_accessor :journalized_for_options

        options.assert_valid_keys(:if, :title)
        self.journalized_for_options = {name: name, if: ->(_){ true }, title: ->(o){ o.to_s }, property: self.class.name.underscore}.merge(options)

        send :include, Redmine::JournalizedFor::Callbacks

        after_create   :journalize_for_create,  if: ->(o){ self.journalized_for_options[:if][o.send( self.journalized_for_options[:name] )] }
        after_destroy  :journalize_for_destroy, if: ->(o){ self.journalized_for_options[:if][o.send( self.journalized_for_options[:name] )] }
      end
    end

  end
end