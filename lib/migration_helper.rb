module Ddb
  module Userstamp
    module MigrationHelper
      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods
        def userstamps(options = {})
          options = {
            include_deleted_by: false,
            type: :integer
          }.merge(options)

          column(Ddb::Userstamp.compatibility_mode ? :created_by : :creator_id, options[:type])
          column(Ddb::Userstamp.compatibility_mode ? :updated_by : :updater_id, options[:type])
          column(Ddb::Userstamp.compatibility_mode ? :deleted_by : :deleter_id, options[:type]) if options[:include_deleted_by]
        end
      end
    end
  end
end

ActiveRecord::ConnectionAdapters::Table.send(:include, Ddb::Userstamp::MigrationHelper)