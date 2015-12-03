<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>出库详情--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
	<s:action name="nav" namespace="/manage" executeResult="true" />
	<div class="tab_right">
		<div class="tab_warp main">
			<div class="dq_step">
				${path}<span class="opb lb op-area"> <a href="<s:url action="outStock_list" namespace="/outStock" />">出库列表</a>
				</span>
			</div>

			<s:form id="serachForm" name="serachForm" action="outDetail_listTwo" method="get" namespace="/outStock" theme="simple">
				<div class="label_con">
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">编号:</div>
							<div class="label_rwben">
								<s:textfield name="outDetail.uuid" title="编号" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">单据号:</div>
							<div class="label_rwben">
								<s:textfield name="outDetail.ordernum" title="单据号" />
							</div>
						</div>
						
						<div class="label_hang">
				            <div class="label_ltit">出库日期:</div>
				            <div class="label_rwben2">
				            	<span class="label_rwb nw">
								<input  class="datepicker iI iI-f" type="text" name="outDetail.out_time_start" title="从" value="${it:formatDate(outDetail.out_time_start,'yyyy-MM-dd')}" />
								</span>
								<span class="label_rwb nw">
								<input  class="datepicker iI iI-t" type="text" name="outDetail.out_time_end" title="到" value="${it:formatDate(outDetail.out_time_end,'yyyy-MM-dd')}" />
				            	</span>
				            </div>
				        </div>
				        
				        <div class="label_hang">
				            <div class="label_ltit">来源:</div><!-- 来源：0手动1调货入库2销售订单3:至事由4:提货提案5:门店管理 -->
				            <div class="label_rwben label_rwb">
				            <s:select name="outDetail.goreason" cssClass="selectKick" headerKey="" headerValue="---请选择---" list="#{0:'手动填加',1:'调货入库',2:'销售订单',3:'至事由',4:'提货结案单',5:'门店管理' }"/>
				            </div>
				        </div>
				        
				        <div class="label_hang">
				            <div class="label_ltit">出库仓库:</div>
				            <div class="label_rwben label_rwb">
				            	<s:select id="membermanagerid" cssClass="selectKick" name="outDetail.store_id" title="出库仓库" headerKey="" headerValue="--请选择--" list="wares" listKey="uuid" listValue="ware_name" />
				            </div>
				        </div>
				        
				        <div class="label_hang">
							<div class="label_ltit">品名:</div>
							<div class="label_rwben">
								
								<s:textfield id="auto_prod_name" name="outDetail.product_name" cssClass="selectAll iI iI-s" />
							</div>
						</div>


						<div class="label_hang  tac">
							<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
							<label for="search_mcondition"></label>更多条件
							<s:submit value="搜索" />
							<s:reset value="重置" />
							<s:submit value="导出excel"  action="outDetail_excel"/>
						</div>

					</div>
				</div>
			</s:form>

			<div class="tab_warp">
				<table>
					<tr id="coltr">
						<th class="td1">编号</th>
						<th class="td2">单号</th>
						<th class="td2">日期</th>
						<th class="td1">品名</th>
						<th class="td1">订单数量</th>
						<th class="td1">来源</th>
						<th class="td1">仓库</th>
						<th class="td5">备注</th>
						<th class="td4">操作</th>
						<th class="td0">查看</th>
					</tr>
					<s:iterator value="outDetails" status="sta">
						<tr id="showtr${uuid}">
				  			<td class="td1 nw"><s:property value="uuid" /></td>
							<td class="td2 nw"><s:property value="ordernum" /></td>
							<td class="td2 nw">${it:formatDate(datea,'yyyy-MM-dd')}</td>
							<td class="td1 nw"><s:property value="product_name" /></td>
							<td class="td1 nw"><s:property value="num" />(<s:property value="%{(num/(case_spec*1.0)).toString().substring(0,3)}" />件)</td>
							<td class="td1 nw">
							<s:if test="goreason==0">
							手动填加
							</s:if>
							<s:elseif test="goreason==1">
							调货入库,编号为${goldUuid }
							</s:elseif>
							<s:elseif test="goreason==2">
							销售订单,编号为${goldUuid }
							</s:elseif>
							<s:elseif test="goreason==3">
							至事由,编号为${goldUuid }
							</s:elseif>
							<s:elseif test="goreason==4">
							提货结案单,编号为${goldUuid }
							</s:elseif>
							<s:elseif test="goreason==5">
							门店管理,编号为${goldUuid }
							</s:elseif>
							</td>
							<td>${ware_name }</td>
							<td class="td5 longnote" title="${remark}">${it:subString(remark,18)}</td>
							<td class="td4 op-area">
								<a  onclick="getStoPro('${store_id}','${product_id }');" class="input-blue"  href="javascript:;">查看当前库存</a>
					    	</td>
					    	<td class="td0 op-area"><a href="javascript:;" onClick="showDetail('showtr${uuid}');" class="input-nostyle">查看</a></td>
				  		</tr>
					</s:iterator>
				</table>
			</div>
			<div id="listpage" class="pagination"></div>
		</div>
	</div>
	<s:action name="ref_foot" namespace="/manager" executeResult="true" />
	<script type="text/javascript" src="<c:url value="/js/func/select_products.js" />"></script>
	<script type="text/javascript">
$(function(){
	printPagination("listpage",'${currPage}','${recCount}','${pageSize}');
 });
 
 function getStoPro(storid,proid){
	 $.ajax({
		 type:'POST',
		 url:"/stock/stock_getProSto",
		 data:"store_id="+storid+"&pro_id="+proid,
		 success: function(data){
			 alert(data);
		 }
		 
	 } );
 };
 
 $(function(){
		SimpleLoadProducts(function(){}, "noparam=true");
	});

</script>
</body>
</html>