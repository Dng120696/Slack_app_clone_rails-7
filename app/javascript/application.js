// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery
import "@hotwired/turbo-rails";
import "controllers";
import "channels";

window.scroll_bottom = function () {
  let messages = document.getElementById("messages");
  if (messages) {
    messages.scrollTop = messages.scrollHeight;
  }
};

window.submit_message = function () {
  let messageInput = document.getElementById("message_body");
  if (messageInput) {
    messageInput.addEventListener("keydown", function (e) {
      if (e.key === "Enter") {
        // Enter key
        document.querySelector("button").click();
        e.target.value = "";
      }
    });
  }
};

document.addEventListener("turbo:load", function () {
  scroll_bottom();
  submit_message();
});
