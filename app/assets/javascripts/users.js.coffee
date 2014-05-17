$ ->

  $('#delete_button').on 'click', -> 

  $(document).on "click", "#edit_button", ->
    run_id = $(this).attr('data-run-id');
    $.ajax '/runs/' + run_id + "/edit",
      type: 'GET'
    
  $(document).on "click", "#fade", ->
    $("#fade").hide();
    $(".modal").hide();
    return

  $(document).on "click", ".close", ->
    $("#fade").hide();
    $(".modal").hide();
    return