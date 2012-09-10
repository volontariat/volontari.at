$(document).ready ->
  $( ".accordions" ).each (k, v) ->
    $(v).accordion({ autoHeight: false });
    
  $(".tabs").each (k, v) ->
    $(v).tabs({ autoHeight: false });