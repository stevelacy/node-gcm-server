$(document).ready(function() {

	var socket = io();
	
  $('.items .item .button').click(function(){
    var id = $(this).data('id');
    socket.emit('send', {id: id});
  });
});