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

 $("#advanced-search-form").submit(function(e){
    // var search_val = $(this).parent().find(".search").val();
    e.preventDefault();
		var params = {};
		var person_array = [];
		$("#advanced-search-form").find(".movie-person-block").each(function(count){
			var person_hash =  {};
			$(this).find("input").each(function(input_elem){
				if($(this).attr("class")==="actor" && $(this).is(':checked')===true)
					person_hash[$(this).attr("class")] = true;
				else if($(this).attr("class")==="director" && $(this).is(':checked')===true)
					person_hash[$(this).attr("class")] = true;
				else
					person_hash[$(this).attr("class")] = $(this).val();
				// alert(param);
			});
			person_array.push(person_hash);
		});
		params["movie_persons"] = person_array;
		
		var movie_hash = {};
		$("#advanced-search-form").find(".movie").find("input").each(function(){
			movie_hash[$(this).attr("id")] = $(this).val();
		});
		params["movie"] = movie_hash;
		
		var genre_hash = {};
		$("#advanced-search-form").find(".genre").find("input").each(function(){
			genre_hash[$(this).attr("id")] = $(this).val();
		});
		params["genre"] = genre_hash;
		
		var oscar_hash = {};
		$("#advanced-search-form").find(".oscar").find("input").each(function(){
			oscar_hash[$(this).attr("id")] = $(this).val();
		});
		params["oscar"] = oscar_hash;
		
		
		//alert(JSON.stringify(params));
    // document.location.href = '/advanced_search_result?' + JSON.stringify(params);
	/*$.post("/advanced_search_result", params).done(function(response){
			$("#content").find(".container").html(response);
		});*/
	
		$.ajax({
		    type: "POST",
		    url: "/advanced_search_result",
		    data: JSON.stringify(params),
		    contentType: "application/json",
		    success: function(response){
		          $("#content").find(".container").html(response);
		      }
		  });
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
    	"<input type=\"text\" class=\"fname\" placeholder=\"First Name\">" +
    	"<input type=\"text\" class=\"mname\" placeholder=\"Middle Name\">" + 
    	"<input type=\"text\" class=\"lname\" placeholder=\"Last Name\">" +
    	"<br />" +
    	"<label><input type=\"checkbox\" value=\"actor\" class=\"actor\"> Actor?</label>" +
    	"<label><input type=\"checkbox\" value=\"director\" class=\"director\"> Director?</label>" +
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

function rate_this_movie_submit() {
  var rating = parseInt($("#rate-this-movie").find('.rating').val());
  var curr_id = parseInt($('.movie').attr('id').split('movie_')[1]);
  if (rating >= 0 && rating <= 10) {
    $.ajax({
      type: "POST",
      url: "/movie/" + curr_id + "/rate",
      data: JSON.stringify({rating: rating, id: curr_id}),
      contentType: "application/json",
      success: function(resp){
        $('#user-rate').find('.error').hide();
        $('.movie').html(resp);
      }
    });
  } else {
    $('#user-rate').find('.error').show();
  }
  return false;
}

function edit_rating() {
  $('#user-rate.rated').find('.edit-rating').hide();
  $('#rate-this-movie').show();
  return false;
}



