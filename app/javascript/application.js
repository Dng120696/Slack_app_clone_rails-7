// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery
import "@hotwired/turbo-rails";
import "controllers";
import "channels";

window.scroll_bottom = function () {
  if ($("#messages").length > 0) {
    $("#messages").scrollTop($("#messages")[0].scrollHeight);
  }
};

window.submit_message = function () {
  $("#message_body").on("keydown", function (e) {
    if (e.keyCode === 13) {
      $("button").click();
      e.target.value = "";
    }
  });
};
$(document).on("turbo:load", function () {
  scroll_bottom();
  submit_message();
});
