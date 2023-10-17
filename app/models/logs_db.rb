class LogsDb < ApplicationRecord
  self.abstract_class = true

  connects_to database: { writing: :logs_db, reading: :logs_db }
end
