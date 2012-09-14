
function togglePriorty(id,v) {
	var a = ["nostar","onestar","twostar","threestar","fourstar","fivestar"];
	var $w=$("#rating" + id);
	
	$w.attr("class","rating " + a[v]);
	var $f = $($w.parents("form:first"));
	var $e = $("#task_priority",$f).eq(0);
	$e.val(10*v);
	if (id>0) {
		$f.submit();
	}
	
}

function toggleStatus(id,v) {
	var $w=$("#rating" + id);
	var $f = $($w.parents("form:first"));
	if(id>0) {
		$f.submit();
	}
	
}

$(function() {

	
	$( "li.draggable" ).draggable({
			appendTo: "body",
			helper: "clone",
			cursor: "move",
	});

	$( "ol.tasks" ).sortable({
			sort: function() {
				// gets added unintentionally by droppable interacting with sortable
				// using connectWithSortable fixes this, but doesn't allow you to customize active/hoverClass options
				$( this ).removeClass( "ui-state-default" );
			}
	});
	$( "li.stack" ).droppable({
				tolerance: "intersect",
				accepts: "li.task",
				activeClass: "ui-state-default",
			    hoverClass: "ui-state-hover",
				drop: function( event, ui ) {
					var task_id=$(ui.draggable).attr('task_id');
					var stack_id=$(ui.draggable).attr('stack_id');
					var new_stack_id=$(this).attr('stack_id');
					try {
						$.ajax({
					   		type: "PUT",
					   		url: "/stacks/" + stack_id + "/tasks/" + task_id + ".js",
					   		data: {
					   			new_stack_id: new_stack_id
					   			
					   		},
					   		success: function(msg){
						 		// alert( "Data Saved: " + msg );
								$(ui.draggable).remove();
					
					   		},
					   		error: function (xhr, ajaxOptions, thrownError) {
        						alert(xhr.status + ": " + thrownError);
      						}
						 });
					} catch(x) {
						alert(x);
					}
				}
	});
	
	
}

)
