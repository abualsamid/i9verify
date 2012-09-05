
function togglePriorty(id,v) {
	var a = ["nostar","onestar","twostar","threestar","fourstar","fivestar"];
	var $w=$("#rating" + id);
	
	$w.attr("class","rating " + a[v]);
	var $f = $($w.parents("form:first"));
	var $e = $("#task_priority",$f).eq(0);
	$e.val(10*v);
	$f.submit();
}
