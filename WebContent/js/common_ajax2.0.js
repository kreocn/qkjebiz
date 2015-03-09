/**
 * 扩展jQuery的AJAX功能
 * 
 * @param result_div_id
 *            显示结果的div.id
 */
function Common_Ajax(result_div_id){
	var selfobj = this;
	// 传递参数的key和value
	this.keys = new Array();
	this.values = new Array();
	this.keyCount = -1;
	// 加入http head的参数
	this.hKeys = new Array();
	this.hValues = new Array();
	this.hKeyCount = -1;
	// 可以是binary
	this.rType = "text";
	this.config = { action_url : "/common_ajax/json_ajax",
	action_data_type : "json",
	_loading_start : function(){
		if (typeof (SpinStart) == 'function') {
			SpinStart();
		} else if (result_div_id) {
			$('#' + result_div_id).append('<span id="ajax_load_message">正在获取数据...</span>');
			$('#' + result_div_id).addClass('common_ajax_loading');
		}
	},
	_loading_end : function(){
		if (typeof (SpinStop) == 'function') {
			SpinStop();
		} else if (result_div_id) {
			$('#' + result_div_id + " #ajax_load_message").remove();
			$('#' + result_div_id).removeClass('common_ajax_loading');
		}
	},
	_beforeSend : function(xmlhttp){
		if (selfobj.hKeyCount != -1) { // 发送用户自行设定的请求头
			for (var i = 0; i <= selfobj.hKeyCount; i++) {
				xmlhttp.setRequestHeader(selfobj.hKeys[i], selfobj.hValues[i]);
			}
		}
		if (selfobj.rType == 'binary') {
			xmlhttp.setRequestHeader("Content-Type", "multipart/form-data");
		} else {
			xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		}
		selfobj.config._loading_start();
	},
	_success : function(data, textStatus){},
	_checkData : function(data){
		if (typeof (data) == "undefined") {
			alert("获取数据异常!");
			return false;
		} else if (typeof (data.value) != "undefined") {
			var datavalue = data.value;
			if (datavalue == 'NOLOGIN') alert("登录超时.");
			else if (datavalue == 'NODATA') alert("没有数据");
			else if (datavalue == 'NOPERMIT') alert('权限不足');
			else if (datavalue.substr(0, 6) == 'ERROR:') alert(datavalue);
		}
		return true;
	},
	__success : function(data, textStatus){
		if (selfobj.config._checkData(data)) selfobj.config._success(data, textStatus);
	},
	_error : function(jqXHR, textStatus, errorThrown){
		// if (showmsg) $('#' + result_div_id + " #ajax_load_message").text("获取数据异常!" + textStatus + ":" + errorThrown);
		alert("获取数据错误!" + textStatus + ":" + errorThrown);
	},
	_complete : function(){
		selfobj.config._loading_end();
	} };
	// 设置传递参数的键值对
	this.addParameter = function(p_key, p_value){
		this.keyCount++;
		this.keys[this.keyCount] = p_key;
		this.values[this.keyCount] = escape(p_value);
	};
	// 设置加入HTTP Head的键值对
	this.addHead = function(p_key, p_value){
		this.hKeyCount++;
		this.hKeys[this.hKeyCount] = p_key;
		this.hValues[this.hKeyCount] = escape(p_value);
	};
	var parameter = "";
	this.setParameter = function(){
		if (selfobj.keyCount != -1) { // post数据
			for (var i = 0; i <= selfobj.keyCount; i++) {
				if (parameter == "") parameter = selfobj.keys[i] + '=' + selfobj.values[i];
				else parameter += "&" + selfobj.keys[i] + '=' + selfobj.values[i];
			}
		}
		return parameter;
	};
	this.sendAjax = function(){
		this.setParameter();
		$.ajax({ type : 'post',
		url : this.config.action_url,
		data : parameter,
		beforeSend : this.config._beforeSend,
		dataType : this.config.action_data_type,
		success : this.config._success,
		error : this.config._error,
		complete : this.config._complete });
	};
	/* 增加数据校验 */
	this.sendAjax2 = function(){
		this.setParameter();
		$.ajax({ type : 'post',
		url : this.config.action_url,
		data : parameter,
		beforeSend : this.config._beforeSend,
		dataType : this.config.action_data_type,
		success : this.config.__success,
		error : this.config._error,
		complete : this.config._complete });
	};
}