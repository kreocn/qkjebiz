<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><s:text name="APP_NAME" /></title>
<script>
if(window.top!=window) {
	window.top.location.href= window.location.href;
}
</script>
</head>
<frameset rows="45,*" frameborder="no" border="0" framespacing="0">
  <frame src="<s:url value="top" />" name="topFrame" scrolling="No" noresize="noresize" id="topFrame" title="topFrame" />
  <frameset rows="*" cols="160,*" frameborder="no" border="0" framespacing="0">
	<frameset rows="*,59" cols="*" framespacing="0" frameborder="no" border="0">    
		<frame src="<s:url value="menu" />" name="leftFrame" scrolling="No" noresize="noresize" id="leftFrame" title="leftFrame" />
		<frame src="<s:url value="bottom" />" name="bottomFrame" scrolling="No" noresize="noresize" id="bottomFrame" title="bottomFrame" />
    </frameset>    
      <frame src="<s:url value="default" />" name="mainFrame" id="mainFrame" title="mainFrame" /> 
  </frameset>  
</frameset>
<noframes>
<body>
</body>
</noframes>
</html>