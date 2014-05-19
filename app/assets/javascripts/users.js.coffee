$ ->

  $('#delete_button').on 'click', -> 

  $(document).on "click", "#edit_button", ->
    run_id = $(this).attr('data-run-id');
    $.ajax '/runs/' + run_id + "/edit",
      type: 'GET'
    
  $(document).on "click", "#fade", ->
    $("#fade").hide();
    $(".modal_custom").hide();
    return

  $(document).on "click", ".close", ->
    $("#fade").hide();
    $(".modal_custom").hide();
    return

  $(document).on "click", "#last_seven", (e) ->
    e.preventDefault();
    value = $(this).attr('id')
    $.ajax '/runs/filter',
      type: 'GET',
      data: { "filter": {"type": value} }
    return

  $(document).on "click", "#last_thirty", (e)  ->
    e.preventDefault();
    value = $(this).attr('id')
    $.ajax '/runs/filter',
      type: 'GET',
      data: { "filter": {"type": value} }
    return

  $(document).on "click", "#year",  (e) ->
    e.preventDefault();
    value = $(this).attr('id')
    $.ajax '/runs/filter',
      type: 'GET',
      data: { "filter": {"type": value} }
    return

  $(document).on "click", "#lifetime",  (e) ->
    e.preventDefault();
    value = $(this).attr('id')
    $.ajax '/runs/filter',
      type: 'GET',
      data: { "filter": {"type": value} }
    return
