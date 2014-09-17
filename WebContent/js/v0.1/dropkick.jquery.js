var dk_Array = new Array();
jQuery.fn.dropkick = function(){
	var args = Array.prototype.slice.call(arguments);
	return $(this).each(function(i){
		if (!args[0] || typeof args[0] === 'object') {
			dk_Array[i] = new Dropkick(this, args[0] || {});
			$(this).attr("data-arrayid", i);
		} else if (typeof args[0] === 'string') {
			dk_Array[i] = Dropkick.prototype[args[0]].apply(new Dropkick(this), args.slice(1));
			$(this).attr("data-arrayid", i);
		}
	});
};
/**
 * 当select有改变时,调用重置dropkick
 */
jQuery.fn.dropkickRefresh = function(){
	return $(this).each(function(i){
		var dk_Object = dk_Array[$(this).attr("data-arrayid")];
		dk_Object.refresh();
	});
};
