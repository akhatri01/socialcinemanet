$(document).ready(function() {
  $('#sort-movies').find('select').change(function() {
    var sort_option = $('#sort-movies').find('select option:selected').val();
    document.location.href = '/?sort_by=' + sort_option;
  });
});