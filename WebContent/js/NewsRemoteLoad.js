/*
 * 需要jQuery1.5以上版本支持
 *
 */
var NewsLoad = function(option) {
	var $this = this;
	var url = "http://sw.qkjchina.com/qkjebiz/iInfo/json_ajax?callback=?";
	// var url = "http://erp.51qkj.com/QKJMS/iInfo/json_ajax?callback=?";
	var defaults = { uuid : '', /**/
	class_id : '', /* 当作为得到类别时,代表parent_id,可以用,隔开同时查询多个类别 */
	istop : '', /* 查询置顶的状态,istop数字越大,优先级越高 */
	istop_search_type : 1,/* 可以指定istop的查询方式0=,1>=,2<=3>,4< */
	isimgnews : '', /* 是否是图片新闻,0否 1是 */
	add_dept : '', /* %是通配符 */
	title : '', /* %是通配符 */
	top : 0, /* 列出前面几条数据 */
	keywords : "",/* %是通配符 */
	shortcontent : "",/* %是通配符 */
	content : "",/* %是通配符,如果此项非空,则忽略keywords和shortcontent,自动进行3项联合全文搜索 */
	order : '', /* 排序字符串,空代表用置顶状态和时间倒序排列,order1:时间倒序 order2:置顶倒序时间正序 */
	pageNum : 0, /**/
	pageSize : 30 };
	$.extend(defaults, option);

	/**
	 * 得到新闻类别列表
	 */
	this.getClassList = function() {
		var tp = '';
		tp = 'uuid=' + encodeURIComponent(defaults.uuid) + '&parent_id=' + encodeURIComponent(defaults.class_id);
		$.getJSON(url, { work : 'class', parameters : tp }, function(data) {
			$this.resultAction(data);
		});
	};

	/**
	 * 得到新闻列表
	 */
	this.getNewsList = function() {
		var tp = '';
		var tpc = '';
		if (defaults.class_id != '') {
			tp += '&class_id=' + encodeURIComponent(defaults.class_id);
		}
		if (defaults.top != 0) {
			tp += '&top=' + encodeURIComponent(defaults.top);
			tpc += ',top:integer';
		}

		if (defaults.pageNum != 0) {
			tp += '&pageNum=' + encodeURIComponent(defaults.pageNum);
			tpc += ',pageNum:integer';
			tp += '&pageSize=' + encodeURIComponent(defaults.pageSize);
			tpc += ',pageSize:integer';
		}

		if (defaults.istop != '') {
			tp += '&istop=' + encodeURIComponent(defaults.istop);
			tpc += ',istop:integer';
			tp += 'istop_search_type=' + +encodeURIComponent(defaults.istop_search_type);
			tpc += ',istop_search_type:integer';
		}

		if (defaults.add_dept != '' && defaults.add_dept != '%') {
			tp += '&add_dept=' + encodeURIComponent(defaults.add_dept);
		}

		if (defaults.title != '' && defaults.title != '%') {
			tp += '&title=' + encodeURIComponent(defaults.title);
		}

		if (defaults.isimgnews != '') {
			tp += '&isimgnews=' + encodeURIComponent(defaults.isimgnews);
			tpc += ',isimgnews:integer';
		}

		if (defaults.order != '') {
			tp += '&order=' + encodeURIComponent(defaults.order);
		}

		if (defaults.content != '' && defaults.content != '%') {
			tp += '&content=' + encodeURIComponent('%' + defaults.content + '%');
		} else {
			if (defaults.keywords != '' && defaults.keywords != '%') {
				tp += '&keywords=' + encodeURIComponent('%' + defaults.keywords + '%');
			}
			if (defaults.shortcontent != '' && defaults.shortcontent != '%') {
				tp += '&shortcontent=' + encodeURIComponent('%' + defaults.shortcontent + '%');
			}
		}

		if (tp.length > 0) {
			tp = tp.substring(1, tp.length);
			if (tpc.length > 0) {
				tpc = tpc.substring(1, tpc.length);
			}

			/* 一定要有条件才能查询 */
			$.getJSON(url, { work : 'news', parameters : tp, para_condition : tpc }, function(data) {
				$this.resultAction(data);
			});
		}

	};

	/**
	 * 得到新闻,uuid必须
	 */
	this.getNewsInfo = function() {
		var tp = '';
		if (defaults.uuid != '') {
			tp += 'uuid=' + encodeURIComponent(defaults.uuid);
			$.getJSON(url, { work : 'news', parameters : tp }, function(data) {
				$this.resultAction(data);
			});
		}
	};

	this.resultAction = function(data) {
		alert(data);
	};
};

/**
 * 工具类,把str截断为前N个字符
 */
var trun = function(str, n) {
	var sl = str.length;
	if (sl <= n) {
		return str;
	} else {
		return str.substring(0, n - 1) + '...';
	}
};

/**
 * 工具类,获取url后的参数值,getRequest('参数名称');
 */
function getRequest(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
	var r = window.location.search.substr(1).match(reg);
	if (r != null)
		return unescape(r[2]);
	return null;
}

/**
 * 工具类,把返回的date类型转换为字符串,yyyy-MM-dd HH:mm:ss
 */
function coventDate(p_date) {
	return (p_date.year + 1900) + '-' + (p_date.month + 1) + '-' + p_date.date + ' ' + p_date.hours + ':'
			+ p_date.minutes + ':' + p_date.seconds;
}

/**
 * 工具类,把返回的date类型转换为字符串,yyyy-MM-dd
 */
function coventDay(p_date) {
	return (p_date.year + 1900) + '-' + (p_date.month + 1) + '-' + p_date.date;
}

function showE(obj) {
	var str;
	for (i in obj) {
		str += " " + i;
	}
	return str;
}