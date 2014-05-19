$ ->

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


  $(document).on "submit", "#new_run", (e) ->
    $('#new_run').on 'ajax:complete', (event, data, status, xhr) ->
      my_data = $.parseJSON(data.responseText);
      console.log(my_data);
      run_date = my_data.pretty_date;
      run_distance = my_data.data.distance;
      run_time = my_data.data.run_time
      pace = my_data.calculated_pace
      

      $('#create_modal').fadeOut();
      $('#fade').fadeOut();
    
      $('#run_table_body').prepend(
        '<tr>' + '<td class="stat_data run_cell">' + run_date + '</td>'+ 
          '<td class="stat_data run_cell">' + run_distance + '</td>'+ 
            '<td class="stat_data run_cell">' + run_time + '</td>' +
          '<td class="stat_data run_cell">' + pace + '</td>' +
            '<td><form action="/runs/' + my_data.data.id.toString() + 'class="button_to" data-remote="true" method="get"><div><input class="btn btn-default" type="submit" value="View Details"></div></form></td>' +
          "<td><button class='btn btn-default' data-run-id='" + my_data.data.id.toString() +
             "' id='edit_button'>Edit</button></td>" +
             '<td><button class="btn btn-default delete_button" data-run-id="' + my_data.data.id.toString() + '">Delete</button></td>' +
             '</tr>')

  $(document).on "submit", ".edit_run", (e) ->
    $('.edit_run').on 'ajax:complete', (event, data, status, xhr) ->
      
      my_data = $.parseJSON(data.responseText);
      run_date = my_data.run_date;
      run_time = my_data.run_time.toString();
      run_distance = my_data.distance;
      element_id = 'tr#' + my_data.id.toString();
      element_id_1 = element_id + " td:first"
      element_id_2 = element_id + " td:eq(1)"
      element_id_3 = element_id + " td:eq(2)"
      element_id_5 = element_id + " td:eq(5)"

      run_date_string = '<td class="stat_data run_cell">' + run_date + '</td>';
      run_time_string = '<td class="stat_data run_cell">' + run_time + '</td>';
      run_distance_string = '<td class="stat_data run_cell">' + run_distance + '</td>';
     
      $('#edit_modal').fadeOut();
      $('#fade').fadeOut();
      $(element_id_1).replaceWith(run_date_string);
      $(element_id_2).replaceWith(run_time_string);
      $(element_id_3).replaceWith(run_distance_string);

 
  
    
    
      
  




      
