# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(document).on('click','.team', (event) ->
    team_id = $(this).attr('team_id')
    $.ajax 'teams/picks',
      type: 'GET',
      dataType: 'json',
      data:{team: team_id},
      error: (jqXHR,textStatus,error) ->
        alert "Error retrieving team picks"
      success: (data,textStatus,jqXHR) ->
        $('.team-results').html('')
        unless data.count > 0
          $('.team-results').append "<h3>No Team Picks Available</h3>"
        for e in data
          row = $('.team-results').append $ "<div class='col-md-4'>Round: " + e['round'] + "</div>" + "<div class='col-md-4'>Pick: " + e['pick'] + "</div>" + "<div class='col-md-4'>Player: " + e['player'] + "</div>"
  )

  $(document).on('click','.round', (event) ->
    $(this).addClass 'selected'
    round_id = $(this).attr('round_id')
    $.ajax 'picks/by_round',
      type: 'GET',
      dataType: 'json',
      data:{round: round_id},
      error: (jqXHR,textStatus,error) ->
        alert "Error retrieving round picks"
      success: (data,textStatus,jqXHR) ->
        $('.round-results').html('')
        for e in data
          row = $('.round-results').append $ "<div class='col-md-12'>" + e['team']['tname'] + " drafted " + e['player']['pname'] + ' (' + e['player']['position'] + ')' + "</div>"
  )

  $(document).on('click','.player', (event) ->
    player_id = $(this).attr('player_id')
    $.ajax 'teams/draft_player',
      type: 'POST',
      dataType: 'json',
      data:{player: player_id},
      error: (jqXHR,textStatus,error) ->
        alert "Error drafting player"
      success: (data,textStatus,jqXHR) ->
  )

  refresh_rate = 5000
  setTimeout(f = (->
    $.ajax '/',
      dataType: 'json',
      error: (jqXHR, textStatus, error) ->
        console.log(error)
        #flash message
      success: (data, textStatus, jqXHR) ->
        update_page_stats(data)
    setTimeout(f, refresh_rate)
  ), refresh_rate)

  update_page_stats = (data)=>
    #realtime
    #recent picks data[0]
    #picking now data[1]
    #picking next data[2]
    $('.recent-picks-container').html('')
    for d in data[0]
      $('.recent-picks-container').append("<p>" + d['team']['tname'] + " drafted " + d['player']['position'] + " " + d['player']['pname'] + "</p>")
    $('.picking_now').html(data[1]['team']['tname'])
    $('.picking_next').html(data[2]['team']['tname'])

    #available players
