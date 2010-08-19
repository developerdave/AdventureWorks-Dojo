require File.join(File.dirname(__FILE__), 'ADO')


module DBI
  class << self

    alias_method :original_connect, :connect

    def connect(driver_url, username, password)
      # Change to SQL 2005
      driver_url.sub! "SQLOLEDB", "SQLNCLI10"

      # Change to Windows Authentication
      driver_url = driver_url.sub! /User ID=[^;]*;Password=[^;]*;/, "Integrated Security=SSPI;"
      original_connect(driver_url, username, password)
    end
  end
end

HolidaysDb.establish_connection(
        :adapter => "sqlserver",
        :host => "localhost",
        :database => "AdventureWorksLT2008"


)

ActiveRecord::Base.pluralize_table_names = true