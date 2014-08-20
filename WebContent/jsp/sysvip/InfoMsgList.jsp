<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>留言交流列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript">
$(function(){
	CommonUtil.pickrow('table1');
	CommonUtil.pickrowAll('table1','uuidcheck');
	
	$("#Reply_Msg").dialog({
	      autoOpen: false,
	      width: 330,
	      height: 240,
	      modal: true
	});
 });
 
function s_r_msg(uuid) {
	$("#infouuid").val(uuid);
	$("#infotitle").val($("#reply_"+uuid).text());
	openReply_Msg();
}
 
function openReply_Msg() {
	$("#Reply_Msg").dialog("open");
}
function closeReply_Msg() {
	$("#Reply_Msg").dialog("close");
}
</script>
<style type="text/css">
.reply_fp {
}
.reply_fp label {
display: inline-block;width: 60px;vertical-align: top;padding-top: 5px;
}

.reply_fp textarea {
display: inline-block;vertical-align: middle;width: 200px;height: 100px;
}
</style>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">留言交流列表</span>
		<span class="extra1">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('VIP_SYSVIP_INFO_ADD')">
			<a href="<s:url namespace="/sysvip" action="info_load"><s:param name="viewFlag">add</s:param></s:url>" >添加留言交流</a>
			</s:if>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="info_listMsgs"  method="get" namespace="/sysvip" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
			<td class='firstRow'>标题:</td>
			<td class='secRow'><s:textfield name="info.title" title="标题" dataLength="0,85" controlName="标题" /></td>
			<td class='firstRow'>信息内容:</td>
			<td class='secRow'><s:textfield name="info.content" title="信息内容" dataLength="0,21845" controlName="信息内容" /></td>
			</tr>
			<tr>
			<td colspan="4" class="buttonarea">
				<s:submit value="搜索" />
				<s:reset value="重置" />
			</td>
			</tr>
		</table>
</s:form>
	</div>
<s:form name="form1" theme="simple">
	<table class="ilisttable" id="table1" width="100%">
	<col width="30" />
	<col width="160" />
	  <tr>
	    <th><input name="uuidcheck" type="checkbox" /></th>
	    <th>留言时间</th>
	    <th>留言人</th>
		<th>留言内容</th>
		<th>状态</th>
		<th>回复内容</th>
	  </tr>
<s:iterator value="infos" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:date name="add_time" format="yyyy-MM-dd HH:mm:ss" /></td>
	    <td><s:property value="add_member" /></td>
		<td><s:property value="content" /></td>
		<td align="center">
			<s:if test="0==checked">
				<span style="color:red;">未回复</span>
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('VIP_SYSVIP_INFO_MDY')">
		    	[<a href="javascript:;" onclick="s_r_msg('${uuid}');">回复</a>]
		    	</s:if>
			</s:if>
			<s:if test="1==checked">
				已回复
				[<a href="javascript:;" onclick="s_r_msg('${uuid}');">修改</a>]
			</s:if>
		</td>
		<td><span id="reply_${uuid}"><s:property value="title" /></span></td>
	  </tr>
</s:iterator>
	  <tr>
	    <td colspan="20" class="buttonarea">
		<script type="text/javascript">
		var spage = new ShowPage();
		spage.show2(<s:property value="recCount" />,<s:property value="pageSize" />,2);
		</script>
		</td>	    
	  </tr>
	</table>
</s:form>
	</div>
</div>
</div>

<div id="Reply_Msg" title="回复留言" style="display: none;">
<s:form name="form_reply" action="info_MsgReply" namespace="/sysvip" onsubmit="return validator(this);" method="post" theme="simple">
<p class="reply_fp">
<label for="infotitle">回复内容:</label>
<textarea  id="infotitle" name="info.title" require="required" dataLength="0,85" controlName="回复内容"></textarea><br />
<label for="infotitle"></label><span class="message_prompt">MSG代表空回复</span>
</p>
<p align="center">
<input type="submit" value="确定回复" />
<input type="hidden" id="infouuid" name="info.uuid" />
</p>
</s:form>
</div>
</body>
</html>