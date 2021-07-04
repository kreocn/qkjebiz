<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>固定资产管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<style type="text/css">
.pricecss {
	display: inline-block; height: 26px; line-height: 26px;
}

.label_hang {
	clear: both;
}
</style>

<style type="text/css">
.asset {
	border-style: solid; border-width: 1px; border-color: pink; background-color: #fff; position: relative; width: 200px;  height: 200px;
	overflow: auto; display: none;
}
</style>
</head>
<body>
	<s:action name="nav" namespace="/manage" executeResult="true" />
	<div class="tab_right">
		<div class="tab_warp main">
			<div class="dq_step">
				${path} <span class="opb lb op-area"><a href="<s:url namespace="/adm" action="fixassets_list"><s:param name="viewFlag">relist</s:param></s:url>">订单列表</a></span>
			</div>
			<s:form id="formEdit" name="form1" cssClass="validForm" action="fixassets_add" namespace="/adm" onsubmit="return validator(this);" method="post" theme="simple">
				<div class="label_con">
					<div class="label_main">
						<s:if test="null != fixassets">
							<div class="label_hang">
								<div class="label_ltit">系统编号:</div>
								<div class="label_rwben">${fixassets.uuid}<s:hidden name="fixassets.uuid" title="系统编号" />
								</div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">修改时间:</div>
								<div class="label_rwbenx">${it:formatDate(fixassets.lm_time,'yyyy-MM-dd  HH:mm:ss')}</div>
							</div>
						</s:if>

						<div class="label_hang">
							<div class="label_ltit">资产分类:</div>
							<div class="label_rwben2">
								<span class="label_rwb"> <s:textfield title="资产名称" id="userasset_nameid" name="fixassets.type_title" readonly="true" /> <s:hidden title="资产编号" id="userasset_codeid" name="fixassets.typea" readonly="true" />
								</span> <span class="lb nw"> <img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectWarevar('userasset_codeid','userasset_nameid',1);" />
								</span>
							</div>
						</div>

						<%-- <div class="label_hang">
			       <div class="label_ltit">资产分类:</div>
			       <div class="label_rwbenx" id="mmtype">
			       		<div class="label_rwben" style="margin-right:5px;"><select name="assets.typea" title="资产种类" class="prov"></select></div>
						<div class="label_rwben" style="margin-right:5px;"><select name="assets.typeb" title="资产类别" class="city" disabled="disabled"></select></div>
						<div class="label_rwben"><select name="assets.typec" title="子类别" class="dist" disabled="disabled"></select></div>
			       </div>
				</div> --%>
						<div class="label_hang">
							<div class="label_ltit">资产名称:</div>
							<div class="label_rwben">
								<s:textfield name="fixassets.title" title="资产名称" cssClass="validate[required,maxSize[128]]" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">参考型号:</div>
							<div class="label_rwben">
								<s:textfield id="assets_model" name="fixassets.model" title="参考型号" cssClass="validate[maxSize[96]]" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">参考规格:</div>
							<div class="label_rwben">
								<s:textfield id="assets_spec" name="fixassets.spec" title="参考规格" cssClass="validate[maxSize[96]]" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">参考价格:</div>
							<div class="label_rwben">
								<s:textfield id="assets_price" name="fixassets.price" title="参考价格" cssStyle="width:80%;" cssClass="validate[custom[number],maxSize[10]]" />
								<span class="pricecss">&nbsp;元</span>
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">数量:</div>
							<div class="label_rwben">
								<s:textfield id="assets_num" name="fixassets.num" title="数量" cssClass="validate[required,custom[number],maxSize[10]]" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">总价:</div>
							<div class="label_rwben">
								<s:textfield id="assets_price_scope" name="fixassets.price_scope" title="总价" cssStyle="width:80%;" cssClass="validate[custom[number],maxSize[10]]" />
								<span class="pricecss">&nbsp;元</span>
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">所属公司:</div>
							<div class="label_rwbenx">
								<s:select name="fixassets.company" title="所属公司" headerKey="" headerValue="--请选择--" list="#{0:'北京互助天佑德青稞酒销售有限公司',1:'华实集团',2:'华奥地产',3:'青海互助青稞酒股份有限公司',4:'青海互助青稞酒销售有限公司',5:'北京互助天佑德青稞酒销售有限公司第二分公司'}" />
							</div>
						</div>

						<div class="label_hang">
							<div class="label_ltit">采购公司:</div>
							<div class="label_rwbenx">
								<s:textfield name="fixassets.p_company" title="采购公司" cssClass="validate[maxSize[128]]" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">采购公司电话:</div>
							<div class="label_rwbenx">
								<s:textfield id="fixassets.p_mobile" title="电话" name="fixassets.p_mobile" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">保修期限:</div>
							<div class="label_rwbenx">
								<s:textfield id="fixassets.warrantytime" title="保修期限" name="fixassets.warrantytime" />
							</div>
						</div>

						<div class="label_hang">
							<div class="label_ltit">采购时间:</div>
							<div class="label_rwben">
								<input class="datepicker validate[required,custom[date]]" type="text" name="fixassets.p_time" title="采购时间" value="${it:formatDate(fixassets.p_time,'yyyy-MM-dd')}" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">报废时限(月):</div>
							<div class="label_rwben">
								<s:textfield name="fixassets.p_scrap" title="报废时限(月)" cssClass="validate[custom[integer],maxSize[10]]" />
							</div>
						</div>

						<div class="label_hang">
							<div class="label_ltit">所在位置:</div>
							<div class="label_rwbenx">
								<%-- <s:textfield name="fixassets.position" title="所在位置" cssClass="validate[maxSize[32]]" /> --%>
								${fixassets.position }
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">领用人:</div>
							<div class="label_rwbenx">
								${fixassets.own_user_name }
							</div>
						</div>



						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">相关操作:</div>
								<div class="label_rwbenx">
									<c:if test="${null == fixassets && 'add' == viewFlag && it:checkPermit('QKJ_ADM_ASSETS_ADD',null)==true}">
										<s:submit id="add" name="add" value="确定" action="fixassets_add" cssClass="input-blue" />
									</c:if>
									<s:if test="null != fixassets && 'mdy' == viewFlag">
										<c:if test="${it:checkPermit('QKJ_ADM_ASSETS_MDY',null)==true}">
											<s:submit id="save" name="save" value="保存" action="fixassets_save" cssClass="input-blue" />
											<input type="button" value="领用人拆分" onclick="createMdyOwnDialog('${fixassets.uuid}');" />
											<input type="button" value="位置拆分" onclick="createMdyPosDialog('${fixassets.uuid}');" />
										</c:if>
										<c:if test="${it:checkPermit('QKJ_ADM_ASSETS_DEL',null)==true}">
											<s:submit id="delete" name="delete" value="删除" action="fixassets_del" onclick="return isDel();" cssClass="input-red" />
										</c:if>

										<%-- <c:if test="${it:checkPermit('QKJ_ADM_ASSETITEM_OWN',null)==true}">
											<input type="button" value="领用信息" onclick="createMdyOwnDialog('${fixassets.uuid}');" />
										</c:if> --%>
									</s:if>
									<input type="button" value="返回" onclick="linkurl('<s:url action="fixassetstype_relist" namespace="/adm" />');" /> <span id="message"><s:property value="message" /></span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</s:form>
		</div>
	<s:if test="null != fixassets && 'mdy' == viewFlag">
		<div id="mdyAssetItemsOwn" class="label_con idialog" title="修改领用信息">
			<s:form id="form_ownAssetItems" name="form_ownAssetItems" onSubmit="return num();" cssClass="validFormDialog" action="fixassets_split" namespace="/adm" method="post" theme="simple">
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">领用人:</div>
						<div class="label_rwbenx">
							<s:textfield id="assetusername" name="fixassets.own_user_name" readonly="true"  size="80px;"/>
							<span class="lb nw"> <img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true,null,null,'asset');" /> <span id="ajax_member_message"></span>
							</span>
							<s:hidden id="assetuser" name="fixassets.own_user"></s:hidden>
							<div id="asset" class="asset">
								<!-- <input type="checkbox" checked="checked" value=""> -->
							</div>

						</div>
					</div>
					
				</div>
				<div class="label_hang label_button tac">
						<s:hidden name="fixassets.uuid" value="%{fixassets.uuid}" />
							<s:submit  value="确定拆分" action="fixassets_usersplit"/>
					</div>
			</s:form>
		</div>
		
		<div id="mdyAssetItemsPos" class="label_con idialog" title="修改领用信息">
			<s:form id="form_ownAssetItems" name="form_ownAssetItems" onSubmit="return ponum();" cssClass="validFormDialog" action="fixassets_split" namespace="/adm" method="post" theme="simple">
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">所在位置:</div>
						<div class="label_rwbenx">
							<s:textfield id="assetposit" name="fixassets.position"  size="80px;"/>
						</div>
					</div>
					
				</div>
				<div class="label_hang label_button tac">
						<s:hidden name="fixassets.uuid" value="%{fixassets.uuid}" />
							<s:submit  value="确定拆分" action="fixassets_positionsplit"/>
					</div>
			</s:form>
		</div>
		</s:if>
	</div>
	<!-- 以下为dialog div内容 -->
	<s:action name="ref_foot" namespace="/manager" executeResult="true" />
	<script type="text/javascript" src="<s:url value="/js/jqueryPlugins/select3/jquery.cityselect.js" />"></script>
	<script type="text/javascript">
		$(function(){
			$("#mmtype").citySelect({ url : '<s:url value="/js/jqueryPlugins/select3/mm.js" />',
			prov : "${assets.typea}",
			city : "${assets.typeb}",
			dist : " ${assets.typec}",
			nodata : "none" });
			$("#assets_price").bind("keyup", function(){
				$("#assets_price_scope").val($("#assets_price").val() * $("#assets_num").val());
			});
			$("#assets_num").bind("keyup", function(){
				$("#assets_price_scope").val($("#assets_price").val() * $("#assets_num").val());
			});
		});
	</script>
	<script type="text/javascript">
		$(function(){
			$("#addAssetItems").dialog({ autoOpen : false,
			height : 220,
			width : 600,
			modal : true });
			$("#mdyAssetItemsOwn").dialog({ autoOpen : false,
			height : 350,
			width : 600,
			modal : true });
			$("#mdyAssetItemsPos").dialog({ autoOpen : false,
				height : 350,
				width : 600,
				modal : true });
		});

		function openAddAssetItems(){
			$("#assetItem_model").val($("#assets_model").val());
			$("#assetItem_spec").val($("#assets_spec").val());
			$("#assetItem_price").val($("#assets_price").val());
			$("#addAssetItems").dialog("open");
		}

		function createMdyOwnDialog(item_id){
			var tr_id = "assetItems_" + item_id;
			var td_objs = $("#" + tr_id + " td");
			var i_use = $(td_objs[4]).attr("data");
			var i_own = $(td_objs[5]).attr("data");
			var i_date = $(td_objs[6]).text();
			$("#assetItem_uuid_add_own").val(item_id);
			//alert(i_use + "---" + i_own + "---" + i_date); 
			//assetItem_is_use assetItem_own_user assetItem_use_time
			$("#assetItem_is_use").val(i_use);
			$("#assetItem_own_user").val(i_own);
			$("#assetItem_use_time").val(i_date);
			$("#mdyAssetItemsOwn").dialog("open");
		}
		
		function createMdyPosDialog(item_id){
			$("#mdyAssetItemsPos").dialog("open");
		}

		function sureuser(){
			var newindexflag = [];
			var username = [];
			$("input[name=userst]:checked").each(function(){
				newindexflag.push($(this).val());
				username.push($(this).attr("username"));
			});

			$("#assetuser").val($("#assetuser").val()+","+newindexflag);
			$("#assetusername").val($("#assetusername").val()+","+username);
			/* document.getElementById('asset').style.display = "none"; */
		}
		
		function sureusers(id){
			
				if(document.getElementById(id).checked) {
				     // do something
				     if($("#assetuser").val()!=null && $("#assetuser").val()!=''){
				    	 $("#assetuser").val($("#assetuser").val()+","+document.getElementById(id).value);
							$("#assetusername").val($("#assetusername").val()+","+$('#'+id).attr('username'));
				     }else{
				    	 $("#assetuser").val(document.getElementById(id).value);
							$("#assetusername").val($('#'+id).attr('username'));
				     }
					
				 }else{
					 var name=$("#assetusername").val();
					 var uuid=$("#assetuser").val();
					 var n=$('#'+id).attr('username')+",";
					 var u=id+",";
					 if(name.indexOf(n) >=0 ){
						 $("#assetusername").val( $("#assetusername").val().replace(n,''));
						}else{
							$("#assetusername").val( $("#assetusername").val().replace(","+$('#'+id).attr('username'),''));
						}
					 if(uuid.indexOf(u) >=0 ){
						 $("#assetuser").val($("#assetuser").val().replace(u,''));
					 }else{
						 $("#assetuser").val($("#assetuser").val().replace(","+id,''));
					 }
					
				 }
			
			
			/* document.getElementById('asset').style.display = "none"; */
		}
		function num(){
			var newdept= $("#assetuser").val().split(",");   
			var n=${fixassets.num};
			if((newdept.length)>n){
				alert("领用人数不能超过物品数量!");
				return false;
			}
		}
		
		function ponum(){
			var newdept= $("#assetposit").val().split(",");   
			var n=${fixassets.num};
			if((newdept.length)>n){
				alert("所在位置不能超过物品数量!");
				return false;
			}
		}
		function cancleuser(){
			document.getElementById('asset').style.display = "none";
		}
	</script>
</body>
</html>