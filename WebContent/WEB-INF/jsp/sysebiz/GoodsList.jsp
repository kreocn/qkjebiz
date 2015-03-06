<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
 <s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<div class="dq_step">
		${path}
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('SYS_EBIZ_GOODS_ADDLOAD')">
			<span class="opb lb op-area"><a href="<s:url namespace="/sysebiz" action="goods_addload"><s:param name="viewFlag">add</s:param></s:url>" >添加新商品</a></span>
		</s:if>
	</div>
	<s:form id="serachForm" name="serachForm" action="goods_list"  method="get" namespace="/sysebiz" theme="simple">
		<div class="label_con">
 			<div class="label_main">
				<div class="label_hang">
				       <div class="label_ltit">商品名称(%):</div>
				       <div class="label_rwbenx"><s:textfield name="goods.goods_name"  title="商品名称"/></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">是否上架:</div>
				       <div class="label_rwben"><s:select name="goods.goods_sales" list="#{1:'下架',0:'上架'}" headerKey="" headerValue="--请选择--" /></div>
				</div>
				<div class="label_hang label_button tac">
		        	<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
					<label for="search_mcondition"></label>更多条件
		            <s:submit value="搜索" /> <s:reset value="重置" />
		        </div>
			</div>
		</div>
	</s:form>
	<div class="tab_warp">
 		<table id="table1">
 			<tr id="coltr">
              <th  class="td1">编号</th>
              <th  class="td1">货号</th>
              <th  class="td2">商品名称</th>
              <th  class="td2">售价</th>
              <th  class="td2">初始库存</th>
              <th  class="td2">剩余库存</th>
              <th  class="td3">已冻结</th>
              <th  class="td3">实际可用</th>
              <th  class="td3">上架</th>
              <th  class="td4">操作</th>
              <th  class="td0">查看</th>
            </tr>
            <s:iterator value="goodx" status="sta">
            	<tr  id="showtr${uuid}">
		              <td  class="td1">${uuid}</td>
		              <td  class="td1">${goods_code}</td>
		              <td  class="td2">${goods_name}</td>
		              <td  class="td2">${goods_price}/${goods_unit}</td>
		              <td  class="td2">${goods_num}${goods_unit}</td>
		              <td  class="td2">${stock_num}${goods_unit}</td>
		              <td  class="td3">${froze_num}${goods_unit}</td>
		              <td  class="td3">${stock_num-froze_num}${goods_unit}</td>
		              <td  class="td3">
		              		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('SYS_EBIZ_GOODS_SALESDOWN')"><s:url id="op_salesdown" namespace="/sysebiz" action="goods_salesdown"><s:param name="goods.uuid" value="uuid" /></s:url></s:if>
							<s:else><s:url id="op_salesdown" value="javascript:alert('您没有商品下架的权限!');" /></s:else>		
							<s:if test="@org.iweb.sys.ContextHelper@checkPermit('SYS_EBIZ_GOODS_SALESUP')"><s:url id="op_salesup" namespace="/sysebiz" action="goods_salesup"><s:param name="goods.uuid" value="uuid" /></s:url></s:if>
							<s:else><s:url id="op_salesup" value="javascript:alert('您没有商品上架的权限!');" /></s:else>
							<s:if test="0==goods_sales"><a  class="yesarea" href="${op_salesdown}"></a></s:if>
							<s:elseif test="1==goods_sales"><a  class="noarea" href="${op_salesup}"></a></s:elseif>
		              </td>
		              <td  class="td4 op-area">
		              		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('SYS_EBIZ_GOODS_SAVELOAD')">
					    	<a class="input-blue" href="<s:url namespace="/sysebiz" action="goods_load"><s:param name="viewFlag">mdy</s:param><s:param name="goods.uuid" value="uuid"></s:param></s:url>">修改</a>
					    	</s:if>
					    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('SYS_EBIZ_GOODS_SAVEINSTOCK')">
					    	<a class="input-yellow" href="javascript:;" onclick="openSaveInStockArea('<s:property value="uuid" />');">补库存</a>
					    	</s:if>
		              </td>
		              <td  class="td0 op-area"><a onclick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
            	</tr>
            </s:iterator>
          </table>
    </div>
    <div id="listpage" class="pagination"></div>
	<div class="tab_warp">
		<span id="message"><s:property value="message" /></span>
	</div>
</div>
</div>

<div id="SaveInStockArea" title="添加商品库存">
<s:form name="form_saveInStock" action="goods_saveInStock" namespace="/sysebiz" cssClass="validForm" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		  <tr>
				<td align="right">添加库存数量:</td>
				<td>
				<s:textfield name="stockNum" title="库存数量" cssClass="validate[required,custom[integer]]" />
				</td>
			</tr>
					<tr>
						<td>&nbsp;</td>
					    <td class="buttonarea">
							<s:hidden name="goods.uuid" />
							<s:submit id="add" name="add" value="确定" action="goods_saveInStock" />
							<s:reset value="重置" />
						</td>
				    </tr>
	</table>
</s:form>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />

<script type="text/javascript">
$(function(){
	setStyle("table1");
	$("#SaveInStockArea").dialog({
	      autoOpen: false,
	      height: 130,
	      width: 400,
	      modal: true
	});
	printPagination("listpage",'${currPage}','${recCount}','${pageSize}');
});
function openSaveInStockArea(goods_id) {
	$("#SaveInStockArea :input[name='goods.uuid']").val(goods_id);
	$("#SaveInStockArea").dialog("open");
}
</script>
</body>
</html>