$(document).ready(function() {
  $('#sort-movies').find('select').change(function() {
    var sort_option = $('#sort-movies').find('select option:selected').val();
    document.location.href = '/?sort_by=' + sort_option;
  });

  $(".search-submit").click(function(){
      // alert("Hello");
      
      var search_val = $(this).parent().find(".search").val();
      document.location.href = '/search?search_val=' + search_val;
      
    });
});

// function searchSubmit() {
//     var search_val = $(".search-submit").parent().find(".search").val();
//     document.location.href = '/search?search_val=' + search_val;
//     return true;
// }

function add_movie_person_block() {
  $('.movie-person-block').last().after(
    "<div class=\"movie-person-block\">" + 
    	"<input type=\"text\" id=\"fname\" placeholder=\"First Name\">" +
    	"<input type=\"text\" id=\"mname\" placeholder=\"Middle Name\">" + 
    	"<input type=\"text\" id=\"lname\" placeholder=\"Last Name\">" +
    	"<br />" +
    	"<label><input type=\"checkbox\" value=\"actor\" id=\"actor\"> Actor?</label>" +
    	"<label><input type=\"checkbox\" value=\"director\" id=\"director\"> Director?</label>" +
    "</div>"
  );
}