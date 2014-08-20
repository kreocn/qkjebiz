<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>我的留言 -- ${it:i18n("HTML_NAME")}</title>
<link rel="stylesheet" href="<c:url value="/css/h/css.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/menu.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/center.css" />" />
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/show_page.js" />"></script>
</head>
<body>
<c:import url="/jsp/member/top.jsp" />
<div id="content" class="content_m">
<c:import url="/jsp/m_c/left_menu.jsp?at=message" />
<div id="right_content">
	<div class="right_top">
		<div class="right_title">我的留言</div>
		<div class="right_search">
			<c:forEach var="item" items="${infos}" varStatus="sta">
			<div class="msg_a">
				<div class="msg_c">${it:formatDate(item.add_time,"yyyy-MM-dd HH:mm:ss")}<br />${item.content}</div>
				<c:if test="${!((empty item.title)||item.title=='MSG')}">
				<div class="msg_r">管理员回复:${item.title}</div>
				</c:if>
			</div>
			</c:forEach>
		</div>
		<div class="page_area">
		<c:if test="${recCount>pageSize}">
			<script type="text/javascript">
			var spage = new ShowPage();
			spage.show2(${recCount},${pageSize},2);
			</script>
		</c:if>
		</div>
	</div>
	<div class="sep15"></div>
	<div class="right_top">
		<div class="right_title">给我们留言</div>
		<div class="right_form">
			<form id="form_mdy" name="form_mdy" action="/member/addMsg" onsubmit="return validator(this);" method="post">
			<p>
				<label for="TYD_addressStreet" class="inlineblock"><span class="rt" >*</span> 留言内容:</label>
				<textarea  id="TYD_addressStreet" name="info.content" class="input_text input3" require="required" controlName="街道地址">${info.content}</textarea>
			</p>
			<p>
				<label class="inlineblock"></label>
				<input type="submit" id="add" name="action:addMsg" value="添加留言" class="search_input1" />
				<span class="text_note">${message}</span>
			</p>
			</form>
		</div>
	</div>
</div>
<div class="clear"></div>
</div>
<c:import url="/jsp/fore/footer.jsp" />
</body>
</html>