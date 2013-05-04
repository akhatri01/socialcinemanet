$(document).ready(function() {
  $('#sort-movies').find('select').change(function() {
    var sort_option = $('#sort-movies').find('select option:selected').val();
    document.location.href = '/?sort_by=' + sort_option;
  });

  $("#search-form").submit(function(e){
    var search_val = $(this).parent().find(".search").val();
    e.preventDefault();
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

function rate_it_edit_imdb_url(curr_url) {
  $('#edit-imdb-url-row').find('.right').html("<form id='new-imdb-url-wrap' action=''><input type='text' id='new-imdb-url' placeholder='IMDB url' value='" + curr_url + "'><input type='submit' class='submit'></form>");
  $('#edit-imdb-url-row').find('.right').find('#new-imdb-url').focus();
  var curr_id = parseInt($('.movie').attr('id').split('movie_')[1]);
  $('#new-imdb-url-wrap').find('.submit').click(function() {
    $.ajax({
      type: "POST",
      url: "/movie/imdb/update",
      data: {imdb_url: $('#new-imdb-url').val(), id: curr_id},
      success: function(resp) {
        // alert(resp);
        // $('#edit-imdb-url-row').find('.right').html(resp);
        $('.movie').html(resp);
      }
    });
    return false;
  });
}




