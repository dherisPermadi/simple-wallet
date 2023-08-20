# README - Wallet (Simple E-Wallet)

# Requirement
  - PostgreSQL
  - Rails v. 7.0.7
  - Ruby v. 3.1.2

# Install Gem / Libraries
  - run ```bundle install```

# Set the ENV Variable
  - Create ```.env``` file in the root
  - Set value to variables ```POSTGRES_USER and POSTGRES_PASSWORD```

# Database Build
  - run ```rake db:create```
  - run ```rake db:migrate```
  - run ```rake db:seed```

# Run Unit Test
  - run ```bundle exec rspec```
