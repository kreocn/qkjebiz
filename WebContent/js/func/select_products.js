/** 所需 jquery1.8 / jqueryui1.10(修改版) / common_ajax2.0.js */
var SimpleLoadProducts = function(_successCallback, _extraParam){
	var loadsimple = new LoadProductsAutoComplete();
	loadsimple.config = { ajax_url_action : ajax_url,
	_successCallback : _successCallback,
	extraParam : _extraParam };
	loadsimple.addEvent();
};
var LoadProductsAutoComplete = function(){
	var selfobj = this;
	this.config = { ajax_url_action : ajax_url,
	_successCallback : function(event, ui){},
	extraParam : "" };
	var cache = {};// 缓存
	this.addEvent = function(){
		// 检查额外参数
		var _extraParam = "";
		if (!(typeof selfobj.config.extraParam == "undefined" || selfobj.config.extraParam == "")) _extraParam = selfobj.config.extraParam + "&";
		// 会员号搜索
		$("#auto_prod_name").autocomplete({ minLength : 0,
		autoFocus : true,
		source : function(request, response){
			var term = request.term;
			if (term in cache) {
				response($.map(cache[term], function(item){
					return { vitem : item,
					value : item.title,
					label : selfobj.boldColorTerm(item.title, request.term) };
				}));
				return;
			}
			var ajax = new Common_Ajax();
			ajax.config.action_url = selfobj.config.ajax_url_action;
			ajax.config._success = function(data, textStatus){
				cache[term] = data;
				response($.map(data, function(item){
					return { vitem : item,
					value : item.title,
					label : selfobj.boldColorTerm(item.title, request.term) };
				}));
			};
			ajax.addParameter("work", "AutoComplete");
			ajax.addParameter("parameters", _extraParam + "privilege_id=QKJCJ_QKJMANAGE_STORES_AJAXLOAD_SELECT&title=" + encodeURI(request.term));
			ajax.sendAjax();
		},
		select : function(event, ui){
			$("#auto_prod_id").val(ui.item.vitem.uuid);
			$("#tiaomainput").val(ui.item.vitem.bar_code);
			// $("#auto_prod_name").data("vitem", vitem);
			selfobj.config._successCallback(event, ui);
		},
		focus : function(event, ui){
		// $("#auto_prod_name").val(ui.item.vitem.title);
		},
		close : function(event, ui){
			if ($("#auto_prod_name").val() == '') $("#auto_prod_id").val("");
		} });
	};

	this.boldColorTerm = function(str, term){
		return str.replace(eval("/" + term + "/ig"), "<b style='color: red;'>$&</b>");
	};
};
// 防止回车提交表单
$("form").keypress(function(e){
	if (e.keyCode == 13) {
		e.preventDefault();
	}
});