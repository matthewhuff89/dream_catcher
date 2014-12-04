$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  // Need to prevent the Default action of the Login form.
  // I just learned about "window.location = URL", I should probably replace a lot of this with it.

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
      $("body").fadeOut(1400, function() {
         console.log(response);
      $("body").html(response).fadeIn(1400);
      })

  });
    });

  $(".signup").submit(function () {
    console.log(event)
    event.preventDefault();
    var $target = $(event.target);
    $target.find("input[type=submit]").val("Creating Account...");

    $.ajax({
      type: "POST",
      url: $target.attr("action"),
      data: $target.serialize()
    }).done(function(response) {
      $("body").fadeOut(1400, function() {
        console.log(response);
        $("body").html(response).fadeIn(1400);
      });
    });

  });

  $(".delete").submit(function () {
    console.log(event)
    event.preventDefault();
    var $target = $(event.target);
    $target.find("input[type=submit]").val("Deleting Account...");

    $.ajax({
      type:"DELETE",
      url: $target.attr("action")
    }).done(function(response) {
      $("body").fadeOut(1400, function() {
        $("body").html(response).fadeIn(1400);
      });
    });
  });

  $("a").click(function () {
    event.preventDefault();
    var $target = $(event.target);
    $.ajax({
      type:"GET",
      url: $target.attr("href")
    }).done(function(response) {
      $("body").fadeOut(1400, function() {
        console.log(response);
        $("body").html(response).fadeIn(1400);
      });
    });
  });

});

