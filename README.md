# README - Wallet (Simple E-Wallet)
A Simple Wallet API that developd to fulfilled 6 endpoint API that needed to be created:
  1. Register User
  2. Balance Read
  3. Balance Topup
  4. Transfer
  5. Top transaction for users
  6. Top overall top transacting users by value

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

# Run Server on Local / Development Environment
  - make sure you are in the root of the folder project / repository
  - run ```rails s```
  - then you can use the API Documentation to try all of the endpoints

# API Documentation (Postman)
https://www.postman.com/planetary-desert-155889/workspace/wallet/collection/18529314-c2a4f605-9b50-42f1-8cc8-34dd15c5a640?action=share&creator=18529314
