class DatabaseCleaner
  def delete_all_data(database, tables)
    tables.each do |table|
      begin
        database.connection.execute("DELETE #{table}")
      rescue Exception => e
        puts e.message
        raise "There was a problem when trying to clean table '#{table}' exception: #{e.message}"
      end
    end
  end

  def reset_database
    holidays_tables = [ ]

	delete_all_data(HolidaysDb, holidays_tables)
  end
end