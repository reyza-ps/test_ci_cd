class EnableExtensions < ActiveRecord::Migration[7.0]
  def up
    connection.execute('create extension if not exists "uuid-ossp"')
    connection.execute('create extension if not exists "pgcrypto"')
  end

  def down
    disable_extension('uuid-ossp') if extensions.include?('uuid-ossp') 
    disable_extension('pgcrypto') if extensions.include?('pgcrypto')
  end
end