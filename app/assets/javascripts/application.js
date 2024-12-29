// app/assets/javascripts/application.js
import "@rails/ujs";
import "@rails/activestorage";
import "channels";
import { Turbo } from "@hotwired/turbo-rails"
if (process.env.RAILS_ENV === 'test') {
    Turbo.session.drive = false
}


Rails.start();

