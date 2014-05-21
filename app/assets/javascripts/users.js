$(function() {
  
  $(document).on('click', '.edit_button', function() {
    user_id = $(this).attr('data-user-id');
    run_id = $(this).attr('data-run-id');
    $.ajax({
      url: '/users/' +  user_id  + '/runs/' + run_id + "/edit",
      type: 'GET'
    });
  });

  $(document).on('click', '#fade', function() {
    $("#fade").hide();
    $(".modal_custom").hide();
  });

  $(document).on('click', '.close', function() {
    $("#fade").hide();
    $(".modal_custom").hide();
  });

  $(document).on('click', '#last_seven', function(e) {
    e.preventDefault();
    value = $(this).attr('id')
    $.ajax ({
      url: '/runs/filter',
      type: 'GET',
      data: { "filter": {"type": value} }
    });
  });

  $(document).on('click', '#last_thirty', function() {
    e.preventDefault();
    value = $(this).attr('id')
    $.ajax ({
      url: '/runs/filter',
      type: 'GET',
      data: { "filter": {"type": value} }
    });
    
  });

  $(document).on('click', '#last_year', function() {
    e.preventDefault();
    value = $(this).attr('id')
    $.ajax ({
      url: '/runs/filter',
      type: 'GET',
      data: { "filter": {"type": value} }
    });
  });

  $(document).on('click', '#lifetime', function() {
    e.preventDefault();
    value = $(this).attr('id')
    $.ajax ({
      url: '/runs/filter',
      type: 'GET',
      data: { "filter": {"type": value} }
    });
  });

  $(document).on('submit', '#new_run', function() {

    $('#new_run').on('ajax:complete', function(event, data, status, xhr) {
      var my_data = $.parseJSON(data.responseText);
      var run_date = my_data.run.run_date;
      var run_distance = my_data.run.distance;
      var run_time = my_data.run.run_time;
      var pace = my_data.run.pace;
      var run_id = my_data.run.run_id;
      var user_id = my_data.run.user_id;
      

      $('#create_modal').fadeOut();
      $('#fade').fadeOut();
    
      $('#run_table_body').prepend(
        '<tr>' + '<td class="stat_data run_cell">' + run_date + '</td>'+ 
          '<td class="stat_data run_cell">' + run_time + '</td>' +
          '<td class="stat_data run_cell">' + run_distance + '</td>'+
          '<td class="stat_data run_cell">' + pace + '</td>' +
            '<td><form action="/users/' + user_id + '/runs/' + run_id + '" class="button_to" data-remote="true" method="get"><div><input class="btn btn-default view_button" data-user-id="' + user_id + '" data-run-id="' + run_id + '" type="submit" value="View Details"></div></form></td>' +
          "<td><button class='btn btn-default edit_button' data-run-id='" + run_id +
             "' id='edit_button'>Edit</button></td>" +
             '<td><button class="btn btn-default delete_button" data-run-id="' + run_id + '">Delete</button></td>' +
             '</tr>')
    });
  });


  $(document).on('submit', '.edit_run', function() {
    
    $('.edit_run').on('ajax:complete', function(event, data, status, xhr) {
      alert('hello');
      var my_data = $.parseJSON(data.responseText);
      var run_date = my_data.run.run_date;
      var run_distance = my_data.run.distance;
      var run_time = my_data.run.run_time;
      var pace = my_data.run.pace;
      var run_id = my_data.run.run_id;

      var element_id = 'tr#' + run_id;
      var element_id_1 = element_id + " td:first";
      var element_id_2 = element_id + " td:eq(1)";
      var element_id_3 = element_id + " td:eq(2)";
      var element_id_4 = element_id + " td:eq(3)";
      var element_id_5 = element_id + " td:eq(5)";

      var run_date_string = '<td class="stat_data run_cell">' + run_date + '</td>';
      var run_time_string = '<td class="stat_data run_cell">' + run_time + '</td>';
      var run_distance_string = '<td class="stat_data run_cell">' + run_distance + '</td>';
      var pace_string = '<td class="stat_data run_cell">' + pace + '</td>';

     
      $('#edit_modal').fadeOut();
      $('#fade').fadeOut();
      $(element_id_1).replaceWith(run_date_string);
      $(element_id_2).replaceWith(run_time_string);
      $(element_id_3).replaceWith(run_distance_string);
      $(element_id_4).replaceWith(pace_string);
    });
  });

  $(document).on('click', '.delete_button', function() {
    var item_row = $(this).parents('tr');
    var run_id = $(this).attr('data-run-id');
    user_id = $(this).attr('data-user-id');
    var current_url = "/users/" + user_id +"/runs/" + run_id;
    $.ajax ({
      url: current_url,
      type: 'POST',
      data: {"_method":"delete"},
    }).success(function() {
      $(item_row).remove();
    });
  });

  $(document).on('click', '.login_button', function() {
    $('.login_modal').fadeIn();
    $('#fade').fadeIn();
  });

  $(document).on('click', '.logout_button', function() {
    $.ajax({
      url: '/logout',
      type: 'GET'
    }) 
  });

  $(document).on('click', '.view_button', function(e) {
    e.preventDefault();
    var run_id = $(this).attr('data-run-id');
    var user_id = $(this).attr('data-user-id');
    var current_url = '/users/' + user_id + '/runs/' + run_id


    $.ajax({
      url: current_url,
      type: 'GET',
      dataType: 'json'
    }).success(function(response) {
      var run_date = response.run.run_date;
      var run_distance = response.run.distance;
      var run_time = response.run.run_time;
      var pace = response.run.pace;
      var notes = response.run.notes;
      var route = response.run.route;
      var runs = response.run.runs;
      console.log();

      var the_page =  '<div class="close glyphicon glyphicon-remove"></div>' +
                      '<h1>Your Run</h1>' +
                      '<p>' + run_date + '</p>' +
                      '<p>' + run_distance + '</p>' +
                      '<p>' + run_time + '</p>' +
                      '<p>' + pace + '</p>' +
                      '<p>' + notes + '</p>' +
                      '<p>' + route + '</p>';

      $('#show_modal').html(the_page);
      $('#fade').fadeIn();
      $('#show_modal').fadeIn();
      

    });  
  });
});





