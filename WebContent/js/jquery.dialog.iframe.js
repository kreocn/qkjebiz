/**
 * 使jquery可以支持iframe
 */
var DialogIFrame = function(config){
	var selfobj = this;
	this.defaultConfig = { src : '',
	width : 200,
	height : 400 };
	this.option = {};

	$.extend(this.option, this.defaultConfig, config);

	this.createRamdowConID = function(){
		return "idialog" + (Math.random() + '').substr(2);
	};

	var conid = this.createRamdowConID();
	var iframeid = conid + "iframe";

	this.create = function(){
		var h = '<div id="' + conid + '" title="' + selfobj.option.title + '"><iframe id="' + iframeid + '" scrolling="yes" frameborder="0"></iframe></div>';
		$("body").append(h);
		$("#" + conid).css({ width : selfobj.option.width + "px",
		height : selfobj.option.height + "px",
		overflow : "hidden",
		padding : "0" });
		$("#" + iframeid).css({ width : "100%",
		height : (selfobj.option.height - 55) + "px",
		background : "transparent" });
		$("#" + iframeid).attr("src", selfobj.option.src);

		var cwidth = $("#" + conid).width();
		var chight = $("#" + conid).height();

		$("#" + conid).dialog({ autoOpen : false,
		height : chight,
		width : cwidth,
		modal : true });
	};

	// 打开选择框
	this.open = function(){
		$("#" + conid).dialog("open");
	};

	// 关闭选择框
	this.close = function(){
		$("#" + conid).dialog("close");
	};

	this.selfAction = $.noop;

	this.getConid = function(){
		return conid;
	};
};

var sobj01;
var selectDept = function(dcode_id, dname_id, isLoad){
	sobj01 = new DialogIFrame({ src : '/sys/dept_permit_select?objname=sobj01',
	title : "选择部门",
	width : 200,
	height : 400 });
	sobj01.selfAction = function(val1, val2){
		$("#" + dcode_id).val(val1);
		$("#" + dname_id).val(val2);
		if (isLoad) {
			// loadManagers(val1);
		}
	};
	sobj01.create();
	sobj01.open();
};

// var loadMsg
