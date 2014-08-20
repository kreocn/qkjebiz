/**
 * 所需 jquery1.8 / jqueryui1.10(修改版) / common_ajax2.0.js
 */
var SimpleLoadMember = function(ajax_url_action, _successCallback) {
	var loadmember = new LoadMemberAutoComplete();
	loadmember.config = { ajax_url_action : ajax_url_action, _successCallback : _successCallback };
	loadmember.addEvent();
};

var LoadMemberAutoComplete = function() {
	var selfobj = this;

	this.config = { ajax_url_action : "/erp/common_ajax/json_ajax", _successCallback : function(event, ui) {
	} };

	var cache = {};// 缓存
	this.addEvent = function() {
		// 会员号搜索
		$("#order_user_id").autocomplete(
				{
					source : function(request, response) {
						var term = request.term;
						if (term in cache) {
							response($.map(cache[term], function(item) {
								return { order_user_id : item.uuid, order_user_mobile : item.mobile,
									order_user_name : item.member_name, value : item.uuid,
									label : selfobj.boldColorTerm(item.uuid, request.term) };
							}));
							return;
						}

						var ajax = new Common_Ajax();
						ajax.config.action_url = selfobj.config.ajax_url_action;
						ajax.config._success = function(data, textStatus) {
							cache[term] = data;
							response($.map(data, function(item) {
								return { order_user_id : item.uuid, order_user_mobile : item.mobile,
									order_user_name : item.member_name, value : item.uuid,
									label : selfobj.boldColorTerm(item.uuid, request.term) };
							}));
						};
						ajax.addParameter("work", "AutoComplete");
						ajax.addParameter("parameters", "privilege_id=QKJCJ_SYSEBIZ_AJAXLOAD_MEMBER&uuid=" + encodeURI(request.term));
						ajax.sendAjax();
					}, minLength : 1, select : function(event, ui) {
						// loadAddress(ui.item.order_user_id, true);
						selfobj.config._successCallback(event, ui);
					}, focus : function(event, ui) {
						$("#order_user_id").val(ui.item.order_user_id);
						$("#order_user_mobile").val(ui.item.order_user_mobile);
						$("#order_user_name").val(ui.item.order_user_name);
					} });

		// 手机搜索
		$("#order_user_mobile").autocomplete(
				{
					source : function(request, response) {
						var term = request.term;
						if (term in cache) {
							response($.map(cache[term], function(item) {
								return { order_user_id : item.uuid, order_user_mobile : item.mobile,
									order_user_name : item.member_name, value : item.mobile,
									label : selfobj.boldColorTerm(item.mobile, request.term) };
							}));
							return;
						}

						var ajax = new Common_Ajax();
						ajax.config.action_url = selfobj.config.ajax_url_action;
						ajax.config._success = function(data, textStatus) {
							cache[term] = data;
							response($.map(data, function(item) {
								return { order_user_id : item.uuid, order_user_mobile : item.mobile,
									order_user_name : item.member_name, value : item.mobile,
									label : selfobj.boldColorTerm(item.mobile, request.term) };
							}));
						};
						ajax.addParameter("work", "AutoComplete");
						ajax.addParameter("parameters", "privilege_id=QKJCJ_SYSEBIZ_AJAXLOAD_MEMBER&mobile=" + encodeURI(request.term));
						ajax.sendAjax();
					}, minLength : 2, select : function(event, ui) {
						// loadAddress(ui.item.order_user_id, true);
						selfobj.config._successCallback(event, ui);
					}, focus : function(event, ui) {
						$("#order_user_id").val(ui.item.order_user_id);
						$("#order_user_mobile").val(ui.item.order_user_mobile);
						$("#order_user_name").val(ui.item.order_user_name);
					} });

		// 会员姓名搜索
		$("#order_user_name").autocomplete(
				{
					source : function(request, response) {
						var term = request.term;
						if (term in cache) {
							response($.map(cache[term], function(item) {
								return { order_user_id : item.uuid, order_user_mobile : item.mobile,
									order_user_name : item.member_name, value : item.member_name,
									label : selfobj.boldColorTerm(item.member_name, request.term) };
							}));
							return;
						}

						var ajax = new Common_Ajax();
						ajax.config.action_url = selfobj.config.ajax_url_action;
						ajax.config._success = function(data, textStatus) {
							cache[term] = data;
							response($.map(data, function(item) {
								return { order_user_id : item.uuid, order_user_mobile : item.mobile,
									order_user_name : item.member_name, value : item.member_name,
									label : selfobj.boldColorTerm(item.member_name, request.term) };
							}));
						};
						ajax.addParameter("work", "AutoComplete");
						ajax.addParameter("parameters", "privilege_id=QKJCJ_SYSEBIZ_AJAXLOAD_MEMBER&member_name=" + encodeURI(request.term));
						ajax.sendAjax();
					}, minLength : 1, select : function(event, ui) {
						selfobj.config._successCallback(event, ui);
						// loadAddress(ui.item.order_user_id, true);
					}, focus : function(event, ui) {
						$("#order_user_id").val(ui.item.order_user_id);
						$("#order_user_mobile").val(ui.item.order_user_mobile);
						$("#order_user_name").val(ui.item.order_user_name);
					} });
	};

	this.boldColorTerm = function(str, term) {
		return str.replace(new RegExp(term, "g"), "<b style='color: red;'>" + term + "</b>");
	};
};