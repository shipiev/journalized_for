module Redmine
  module JournalizedFor
    module Callbacks
      extend ActiveSupport::Concern

      def journalized_for_options_name

      end

      def journalize_for_create
        journal = Journal.new(journalized: send( self.journalized_for_options[:name] ), user: User.current, notes: '')
        journal.details.build(
            property: self.journalized_for_options[:property],
            prop_key: id,
            value: self.journalized_for_options[:title][self] )
        journal.save
      end

      def journalize_for_destroy
        journal = Journal.new(journalized: send( self.journalized_for_options[:name] ), user: User.current, notes: '')
        journal.details.build(
            property: self.journalized_for_options[:property],
            prop_key: id,
            old_value: self.journalized_for_options[:title][self] )
        journal.save
      end

      module ClassMethods; end
    end
  end
end