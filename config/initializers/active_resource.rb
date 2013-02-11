require 'csv'

#enable ActiveResource logging
ActiveResource::Base.logger = ActiveRecord::Base.logger

# support csv format
module ActiveResource
  module Formats
    module CsvFormat
      extend self

      def extension
        "csv"
      end

      def mime_type
        "text/csv"
      end

      def encode(rows, options={})
        CSV.generate do |csv|
          rows.each do |row|
            csv << row
          end
        end
      end

      def decode(csv)
        tables = CSV.parse(csv, :headers => :first_row )

        data = []
        tables.each do |row|
          r = Hash[row.map { |key, value | [key.to_s.parameterize.underscore.to_sym, value] }]
          data << r
        end

        data
      end
    end
  end
end