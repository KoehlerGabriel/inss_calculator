import Rails from "@rails/ujs";
import { Application } from "@hotwired/stimulus";

Rails.start();
const application = Application.start();
application.debug = false;
window.Stimulus = application;

export { application };
