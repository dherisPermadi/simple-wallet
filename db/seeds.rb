# frozen_string_literal: true

if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create!(name: 'API Client', scopes: '')
end