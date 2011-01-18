require 'rubygems'
require 'yaml'

db_config = "#{shared_path}/config/database.yml"

data = YAML.load_file(db_config)

data['development']['adapter'] = 'mysql2' if data['development'] != nil
data['test']['adapter'] = 'mysql2' if data['test'] != nil
data['production']['adapter'] = 'mysql2' if data['production'] != nil

File.open(db_config, "w") {|file| file.puts(data.to_yaml) }
