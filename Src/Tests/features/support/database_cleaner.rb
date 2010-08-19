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
    adventure_works_tables = [ ]

	delete_all_data(AdventureWorksLT2008, adventure_works_tables)
  end
end