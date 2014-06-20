module QueueClassicAdmin
  class QueueClassicJob < ActiveRecord::Base
    include JobCommon
    self.table_name = 'queue_classic_jobs'

    SEARCHABLE_COLUMNS = [
      :method,
      :args
    ]

    def self.search(query)
      sql = SEARCHABLE_COLUMNS.inject([]) do |sql, field|
        sql << "#{field} LIKE ?"
      end.join(" OR ")

      wildcard_query = ["%", query, "%"].join
      relation.where(sql, *([wildcard_query] * SEARCHABLE_COLUMNS.size))

      # rel = relation
      # SEARCH_FIELDS.each do |f|
      #   rel = rel.where("#{f} LIKE '%#{query}%'")
      # end
      # rel
    end
  end
end
