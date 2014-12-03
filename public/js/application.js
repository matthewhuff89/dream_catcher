$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  // Need to prevent the Default action of the Login form.
  $(".login").submit(function () {
    console.log(event)
    event.preventDefault();
    var $target = $(event.target);
    $target.find(".login_submit").val("Logging in...");
    // So the pushed in data still needs to get to the post
    $.ajax({
      type:"POST",
      url: $target.attr("action"),
      data: $target.serialize()
  }).done(function(response) {
      $("body").fadeOut(1400)
      console.log(response);
      $("body").html(response);
  });
    });
});

