// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require rails-ujs
import * as ActiveStorage from "@rails/activestorage";
ActiveStorage.start();
import "@hotwired/turbo-rails"
import "@rails/ujs";// Rails UJS modülünü içeri aktarır
Rails.start()