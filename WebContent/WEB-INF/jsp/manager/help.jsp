<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>帮助信息</title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<iframe id="myframe" src="http://d.qkjchina.com/qkjzn/index.html?v=0.01" width="100%" height="500px"  onload="SetWinHeight(this)" style="border: none;">
	</iframe> 
	</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript">
function SetWinHeight(obj)
{
    var win=obj;
    if (document.getElementById)
    {
    if (win && !window.opera)
    {
       if (win.contentDocument && win.contentDocument.body.offsetHeight) 
         win.height = win.contentDocument.body.offsetHeight; 
       else if(win.Document && win.Document.body.scrollHeight)
         win.height = win.Document.body.scrollHeight;
    }
   }
}
</script>
</body>
</html>