<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>出库提货单管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.select.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/func/select_member.js" />"></script>
<style type="text/css">
.confirm_td{text-align:center;padding:5px 0 0!important;}
.confirm_button{display:block;border:#333 solid 1px;border-radius:3px;font-size:28px;color:#333;margin:auto auto 5px;}
a.confirm_button{width:100px;text-decoration:none;cursor:pointer;}
a.confirm_button:hover{background-color:#333;color:#FFF;}
.confirm_ok{line-height:50px;}
.confirm_cancel{line-height:35px;}
.confirmd{display:block;width:50px;line-height:50px;margin:auto;}
.fd_button{width:50px;height:50px;font-size:14px;border:#333 solid 1px;border-radius:5px;cursor:pointer;}
.confirmd_ok,.confirmd_cancel{font-size:40px;}
#out_flag_no{cursor: pointer;}
.dialog_button{text-align: center;line-height: 80px;}
</style>
<script type="text/javascript">
$(function(){
	/*<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_OUTFLAG1')">*/
	$("#out_flag_no").bind("click",function(){
		$("#OUT_Operation #lading_out").unbind().bind("click",function(){
			if(isOp('是否确定已出货?\n出货操作不能更改!')) 
				location.href='<s:url namespace="/qkjmanage" action="lading_out"><s:param name="lading.uuid" value="lading.uuid" /></s:url>';
		});
		$("#OUT_Operation").dialog("open");
	});
	$("#OUT_Operation").dialog({
	      autoOpen: false,
	      width: 200,
	      height: 80,
	      modal: true
	});
	/*</s:if>*/
});
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">出货单(No.<s:property value="lading.uuid" />)</span>
	</div>
<s:form name="form1" action="lading_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != lading">
		<tr>
		<td class='firstRow'>申请编号:</td>
		<td class='secRow'>
			<s:property value="lading.uuid" />
			<s:hidden name="lading.uuid" />
		</td>
		<td class='firstRow'>状态:</td>
		<td class='secRow'>
			<s:if test='0==lading.status'>新单</s:if>
			<s:if test='1==lading.status'>待批</s:if>
			<s:if test='2==lading.status'>结案-<s:date name="lading.close_time" format="yyyy-MM-dd HH:mm:ss" /></s:if>
			<s:if test='0==lading.out_flag'><span id="out_flag_no" class="message_error">未出货</span></s:if><s:if test='1==lading.out_flag'>已出货</s:if>
		</td>
		</tr>
		</s:if>
		<s:if test="null!=lading && 1<=lading.status">
		<tr>
			<td class='firstRow'>确认表单:</td>
			<td class="tablearea" colspan="3">
			<table class="ilisttable" width="100%">
			<tr>
				<th style="width: 20%;">渠道/运营经理确认</th>
				<th style="width: 20%;">销售部经理确认</th>
				<th style="width: 20%;">市场部经理确认</th>
				<th style="width: 20%;">财务确认</th>
				<th style="width: 20%;">运营总监确认</th>
			</tr>
			<tr>
			<td class="confirm_td">
				<s:if test="0==lading.manager_check">
				<span class="confirmd confirmd_cancel">-</span>
				</s:if>
				<s:if test="1==lading.manager_check">
				<span class="confirmd confirmd_ok" title='<s:property value="lading.manager_check_user_name" /> <s:date name="lading.manager_check_time" format="yyyy-MM-dd HH:mm:ss" />'>√</span>
				<div></div>
				</s:if>
			</td>
			<td class="confirm_td">
				<s:if test="0==lading.sd_check">
				<span class="confirmd confirmd_cancel">-</span>
				</s:if>
				<s:if test="1==lading.sd_check">
				<span class="confirmd confirmd_ok" title='<s:property value="lading.sd_check_user_name" /> <s:date name="lading.sd_check_time" format="yyyy-MM-dd HH:mm:ss" />'>√</span>
				</s:if>
			</td>
			<td class="confirm_td">
				<s:if test="0==lading.md_check">
				<span class="confirmd confirmd_cancel">-</span>
				</s:if>
				<s:if test="1==lading.md_check">
				<span class="confirmd confirmd_ok" title='<s:property value="lading.md_check_user_name" /> <s:date name="lading.md_check_time" format="yyyy-MM-dd HH:mm:ss" />'>√</span>
				</s:if>
			</td>
			<td class="confirm_td">
				<s:if test="2>lading.fd_check">
				<span class="confirmd confirmd_cancel">-</span>
				</s:if>
				<s:if test="2==lading.fd_check">
				<span class="confirmd confirmd_ok" title='<s:property value="lading.fd_check_user_name" /> <s:date name="lading.md_check_time" format="yyyy-MM-dd HH:mm:ss" />'>√</span>
				</s:if>
			</td>
			<td class="confirm_td">
				<s:if test="0==lading.coo_check">
				<span class="confirmd confirmd_cancel">-</span>
				</s:if>
				<s:if test="1==lading.coo_check">
				<span class="confirmd confirmd_ok" title='<s:property value="lading.coo_check_user_name" /> <s:date name="lading.coo_check_time" format="yyyy-MM-dd HH:mm:ss" />'>√</span>
				</s:if>
			</td>
			</tr>
			</table>
			</td>
		</tr>
		<tr>
		<td class='firstRow'>申请人/销售人:</td>
		<td class='secRow'>
			<s:property value="lading.applicant_name" />
		</td>
		<td class='firstRow'>申请时间:</td>
		<td class='secRow'><s:date name="lading.apply_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
		</s:if>
		<tr>
		<td class='firstRow'>客户信息:</td>
		<td class='secRow' colspan="3">
			<s:property value="lading.member_id" /> <s:property value="lading.member_name" /> 
		</td>
		</tr>
		<tr>
		<td class='firstRow'>内容:</td>
		<td class='secRow' colspan="3">
			<s:property value="lading.content" /> 
		</tr>
		<tr>
		<td class='firstRow'>配送地点:</td>
		<td class='secRow' colspan="3"><s:property value="lading.address" /></td>
		</tr>
		<tr>
		<td class='firstRow'>其他说明:</td>
		<td class='secRow' colspan="3"><s:property value="lading.note" /></td>
		</tr>
		<s:if test="null != lading">
<!-- ------------------------------------------------------------- -->
<tr>
<td class='firstRow'>提货单明细:
	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADINGITEM_ADD') && lading.status==0">
	<br />
	<a id="addItem" href="javascript:;">[添加明细]</a>&nbsp;
	</s:if>
</td>
<td class='secRow' colspan="3">
<table class="ilisttable" id="table_item" width="100%">
  <tr>
    <th>主键编号</th>
	<th>产品名称</th>
	<th>提货数量</th>
  </tr>
<s:iterator value="ladingItems" status="sta">
  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>">
    <td align="center"><s:property value="uuid" /></td>
	<td><s:property value="product_name" /></td>
	<td align="center">
		<s:property value="num" />(<s:property value="num/(case_spec*1.0)" /> 件)
	</td>
  </tr>
</s:iterator>	
</table>
</td>
</tr>
<!-- ------------------------------------------------------------- -->
		<tr>
		<td class='firstRow'>添加人:</td>
		<td class='secRow'><s:property value="lading.add_user_name" /></td>
		<td class='firstRow'>添加时间:</td>
		<td class='secRow'><s:date name="lading.add_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
		<tr>
		<td class='firstRow'>最后修改人:</td>
		<td class='secRow'><s:property value="lading.lm_user_name" /></td>
		<td class='firstRow'>最后修改时间:</td>
		<td class='secRow'><s:date name="lading.lm_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
		<tr>
		</tr>
		</s:if>
	</table>
</s:form>
	</div>
</div>
</div>
<div class="printarea"><input type="button" onclick="window.print();" value="打印本页"/></div>
<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_OUTFLAG1')">
<div id="OUT_Operation" title="出货操作">
<div class="dialog_button"><span id="lading_out" class="ui_button_100x24_shallow">确定出货完成</span></div>
</div>
</s:if>
</body>
</html>