# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin 'jquery'
pin '@rails/ujs', to: 'https://cdnjs.cloudflare.com/ajax/libs/jquery-ujs/1.2.3/rails.min.js'
pin 'nested_form_fields'
pin_all_from 'app/javascript/customer', under: 'customer'
pin 'bootstrap', to: 'https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js', preload: true
