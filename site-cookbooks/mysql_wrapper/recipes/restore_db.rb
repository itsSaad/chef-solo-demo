remote_file '/tmp/restore_db.sql.zip' do
  source 'http://sportsdb.org/modules/sd/assets/downloads/mlb-samples-2008.09.19.sql.zip'
  owner 'root'
  group 'root'
  mode '0664'
  action :create
end

execute 'extract restore_db.sql.zip' do
  command 'unzip -j -aa -f -u restore_db.sql.zip'
  cwd '/tmp'
  not_if { File.exists?("/tmp/mlb-samples-2008.09.19.sql") }
end
execute 'restore-databases' do
  command "mysql -S /var/run/mysql-default/mysqld.sock -u root -p#{node['mysql_wrapper']['mysql_root_password']} --execute='create database somedb;' && mysql -S /var/run/mysql-default/mysqld.sock -u root -p#{node['mysql_wrapper']['mysql_root_password']} -D somedb </tmp/mlb-samples-2008.09.19.sql"
end
