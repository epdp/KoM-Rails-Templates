# generate folders
run "mkdir app/views/common"
run "touch app/views/common/_footer.html.erb"
run "touch app/views/common/_header.html.erb"


generate(:controller, "maquetas")
run "rm app/controllers/maquetas_controller.rb"
# generate maquetas controller
file 'app/controllers/maquetas_controller.rb', <<-CODE
class MaquetasController < ApplicationController
  layout 'maquetas'
  
  def index
    
  end
end
CODE

run "touch app/views/maquetas/index.html.erb"

# generate application layout + maquetas layout
file 'app/views/layouts/application.html.erb', <<-CODE
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <title></title>
  <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
  <meta name="title" content="" />
  <meta name="description" content="" />
  <link rel="shortcut icon" href="/images/layout/favicon.ico" />
  
  <%= stylesheet_link_tag 'application', :media => "all" -%>
  <script type="text/javascript" charset="utf-8">
    // CSS for PC's only
    if(navigator.userAgent.indexOf('Windows') != -1) {
      document.write ('<%= stylesheet_link_tag "application_ie", :media => "all" -%>');
    }
  </script>
</head>
<!--
        Made by: Kings of Mambo | www.kingsofmambo.com
-->
<body>
 
  <div class="wrap">
    <%= yield %>
  </div>
 
</body>
</html>
CODE

file 'app/views/layouts/maquetas.html.erb', <<-CODE
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <title></title>
  <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
  <meta name="title" content="" />
  <meta name="description" content="" />
  <link rel="shortcut icon" href="/images/layout/favicon.ico" />
  
  <%= stylesheet_link_tag 'application', :media => "all" -%>
  <script type="text/javascript" charset="utf-8">
    // CSS for PC's only
    if(navigator.userAgent.indexOf('Windows') != -1) {
      document.write ('<%= stylesheet_link_tag "application_ie", :media => "all" -%>');
    }
  </script>
</head>
<!--
        Made by: Kings of Mambo | www.kingsofmambo.com
-->
<body>
  <%= render "common/header" %>
  <div class="wrap">
    <%= yield %>
  </div>
  <%= render "common/footer" %>
</body>
</html>
CODE

file 'config/datavase.yml', <<-CODE
  development:
    adapter: mysql
    database: project_development
    username: root
    password: root  
    socket: /Applications/MAMP/tmp/mysql/mysql.sock
    encoding: utf8

  # Warning: The database defined as "test" will be erased and
  # re-generated from your development database when you run "rake".
  # Do not set this db to the same as development or production.
  test:
    adapter: sqlite3
    database: db/test.sqlite3
    pool: 5
    timeout: 5000
    
  production:
    adapter: mysql
    encoding: utf8
    reconnect: false
    database: project_production
    pool: 5
    username: root
    password: *********
    socket: /var/run/mysqld/mysqld.sock
CODE

# Set up .gitignore files
  run "cp config/database.yml config/example_database.yml"
  run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
  run %{find . -type d -empty | grep -v "vendor" | grep -v ".git" | grep -v "tmp" | xargs -I xxx touch xxx/.gitignore}
  file '.gitignore', <<-END
.DS_Store
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
END

# setup git



git :init
git :add => "."
git :commit => "-a -m 'Initial commit'"