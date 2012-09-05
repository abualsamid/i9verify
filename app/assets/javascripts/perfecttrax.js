$(function() {
  $('.pagination[remote=true] a').live('click', function () {
     $.rails.handleRemote($(this));
   	 return false;
  });

  try {
  	$('#new_task_container input#task_name').focus(function () {
      $('#new_task_container #new_task_body').show();
      return false;
    });
  } catch(x) {
    log(x);
  }
  
  /*
  try {
  	$('#new_task_container input#task_name').blur(function () {
  		if (!$(this).val()) {
  			$('#new_task_container #new_task_body').hide();
  		}
      
      return false;
    });
  } catch(x) {
    log(x);
  }
  */
  
  $('.datepicker').datepicker();
});
