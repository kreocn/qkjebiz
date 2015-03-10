<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统参数--<s:text name="APP_NAME" /></title>
</head>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<div class="dq_step">
		系统参数
	</div>
	<s:form id="editForm" name="editForm" cssClass="validForm" action="sys_param_save" namespace="/sys" method="post" theme="simple">
	<div class="label_con">
		<div class="label_main">
        	<div class="note_area">
				<s:textarea  id="sysParamInfo" name="sysParamInfo"  rows="15" cssClass="validate[maxSize[65535]]" />
				<div class="clear"></div>
        	</div>
        </div>
      </div>
      <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">相关操作:</div>
            <div class="label_rwbenx">
            <s:submit id="save" name="save" value="保存" action="sys_param_save" />
            </div>
		</div>
		</div>
      </s:form>
<s:if test="@org.iweb.sys.ContextHelper@checkPermit('SYS_MANAGER_SYS_PARAM_CACHE')">
      <div class="label_main op-area">
       <div class="label_hang">
           <div class="label_ltit">其他操作:</div>
           <div class="label_rwbenx">
			<a href="javascript:;" onclick="reCache('sys');">重新缓存系统参数</a>
			<a href="javascript:;" onclick="reCache('role');">重新缓存角色数据</a>
           	<a href="javascript:;" onclick="reCache('dept');">重新缓存部门数据</a>
           	<a href="javascript:;" onclick="reCache('menu');">重新缓存菜单数据</a>
           	<a href="javascript:;" onclick="reCache('prod-tree');">重新缓存产品树数据</a>
           	<a href="javascript:;" onclick="reCache('all');">重置所有缓存</a>
           </div>
	</div>
	</div>
	<div class="label_main">
		 <div class="label_hang">
           <div class="label_ltit">&nbsp;</div>
           <div id="info_message" class="label_rwbenx cr"></div>
	</div>
	</div>
	</s:if>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript">
var reCache = function(CacheMode){
	var cacheInfo = '';
	if(CacheMode=='sys') cacheInfo='【系统参数】';
	else if(CacheMode=='role') cacheInfo='【角色数据】';
	else if(CacheMode=='dept') cacheInfo='【部门数据】';
	else if(CacheMode=='menu') cacheInfo='【菜单数据】';
	else if(CacheMode=='prod-tree') cacheInfo='【产品树数据】';
	else if(CacheMode=='all') cacheInfo='【全部数据】';
	var ajax = new Common_Ajax();
	ajax.config.action_url = ajax_url;
	ajax.addParameter("work", "ReCache");
	ajax.addParameter("parameters", "CacheMode=" + CacheMode);
	ajax.config._beforeSend = function(xmlhttp) {
		$("#info_message").html($("#info_message").html() + "开始重新缓存"+cacheInfo+"数据."  + "<br />");
	};
	ajax.config._success = function(data, textStatus){
		$("#info_message").html($("#info_message").html() + "重新缓存"+cacheInfo+"数据成功!"  + "<br />");
	};
	ajax.sendAjax();
};
</script>
</body>
</html>