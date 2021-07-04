<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
<style type="text/css">
.pagination {text-align: center; padding: 3px 0; background-color: #EFEFEF; margin: 1px 0; color: #059c77;}
.pagination a {display: inline-block; background-color: #EFEFEF; margin: 0 1px; font-size: 14px; height: 25px; line-height: 25px; color: #059c77; min-width: 25px;border: #059c77 solid 1px; font-weight: bold; border: #059c77 solid 1px;}
.pagination a:hover {background-color: #059c77; color: #FFF;}
.pagination a.current {background-color: #059c77; color: #FFF;}
.pagination a.disabled {color: #999; background-color: #EFEFEF; border-color: #999;}
</style>
<script type="text/javascript" src="<c:url value="/js/v0.1/jquery.paging.min.js" />"></script>
<script type="text/javascript">
$(function(){
	$(".pagination").each(function(i){
		var $this = $(this);
		var opt = eval("(" + $(this).attr("data") + ")");
		$(this).paging(opt['count'], { format : "<(qq-)nncnn(-pp)>",
		perpage : opt['size'],
		lapping : 0,
		page :opt['cur'],
		onSelect : function(page){
			// alert(page);
			// var data = this.slice;
			// alert(data[0]);
			// alert(data[1]);
			// location.href = urlAddParam(window.location.href, "Page", page);
			$("#message").text($("#message").text() + "-" + page);
		},
		onFormat : function(type){
			switch (type) {
			case 'block':
				if (!this.active) return '<a class="disabled">' + this.value + '</a>';
				else if (this.value != this.page) return '<a href="#' + this.value + '">' + this.value + '</a>';
				return '<a class="current">' + this.value + '</a>';
			case 'right':
			case 'left':
				if (!this.active) { return ''; }
				return '<a href="#' + this.value + '">' + this.value + '</a>';
			case 'next':
				if (this.active) return '<a href="#' + this.value + '" class="next">&gt;</a>';
				return '<a class="disabled">&gt;</span>';
			case 'prev':
				if (this.active) return '<a href="#' + this.value + '" class="prev">&lt;</a>';
				return '<a class="disabled">&lt;</span>';
			case 'first':
				if (this.active) return '<a href="#' + this.value + '" class="first">First</a>';
				return '<a class="disabled">首页</span>';
			case 'last':
				if (this.active) return '<a href="#' + this.value + '" class="last">Last</a>';
				return '<a class="disabled">末页</span>';
			case "leap":
				if (this.active) return "   ";
				return "";
			case 'fill':
				if (this.active) return "..";
				return "";
			}
		} });
	});
});
</script>
</head>
<body>
<div class="pagination" data='{count:${recCount},size:${pageSize},cur:${currPage},formid:"serachForm"}'></div>
<div class="pagination" data='{count:100000,size:15,cur:6,formid:"serachForm"}'></div>
</body>
</html>