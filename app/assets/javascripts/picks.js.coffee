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
        for e in data
          $('.team-results').append $ "<div class='col-md-4'>Round: " + e['round'] + "</div><div class='col-md-4'>Pick: " + e['pick'] + "</div><div class='col-md-4'>" + e['player']['pname'] + " (" + e['player']['position'] + ")</div>"
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
          $('.round-results').append $ "<div class='col-md-4'>Pick: " + e['pick'] + "</div><div class='col-md-4'>Team: " + e['team']['tname'] + "</div><div class='col-md-4'>" + e['player']['pname'] + " (" + e['player']['position'] + ")</div>"
  )

  $(document).on('click','.draft-me', (event) ->
    player_id = $(this).attr('player_id')
    $.ajax 'teams/draft_player',
      type: 'POST',
      dataType: 'json',
      data:{player: player_id},
      error: (jqXHR,textStatus,error) ->
        alert "Error drafting player"
      success: (data,textStatus,jqXHR) ->
        remove_drafted_player(data)
        refresh_live_stats()
  )

  $(document).on('click','.position', (event) ->
    position = $(this).attr('position')
    $.ajax 'players/avail_by_position',
      type: 'GET',
      dataType: 'json',
      data:{position: position},
      error: (jqXHR,textStatus,error) ->
        alert "Error retrieving players"
      success: (data,textStatus,jqXHR) ->
        $('.position-results').html('')
        for e in data
          $('.position-results').append $ "<div class='col-md-12'>" + e['pname'] + "</div>"
  )

  refresh_rate = 5000
  setTimeout(f = (->
    refresh_live_stats()
    setTimeout(f, refresh_rate)
  ), refresh_rate)

  update_realtime_stats = (data) ->
    $('.recent-picks-container').html('')
    for d in data[0]
      $('.recent-picks-container').append("<p>" + d['team']['tname'] + " drafted " + d['player']['position'] + " " + d['player']['pname'] + "</p>")
    $('.picking_now').html(data[1]['team']['tname'])
    $('.picking_next').html(data[2]['team']['tname'])

  remove_drafted_player = (pid) ->
    $('.draftables-admin-container').find('div[player_id="' + pid + '"]').remove()

  refresh_live_stats = ->
    $.ajax '/',
      dataType: 'json',
      error: (jqXHR, textStatus, error) ->
        #flash message
      success: (data, textStatus, jqXHR) ->
        update_realtime_stats(data)
