$(document).ready(function() {

  // I just learned about "window.location = URL", I should probably replace a lot of this with it.

   $(".login").submit(function() {
     console.log(event)
     event.preventDefault();
     var $target = $(event.target);
     $target.find(".login_submit").val("Logging in...");

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

   $(".signup").submit(function() {
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

   $(".delete").submit(function() {
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

   $("a").click(function() {
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

