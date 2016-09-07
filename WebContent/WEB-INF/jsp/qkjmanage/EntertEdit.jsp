<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>

<body>
	<s:action name="nav" namespace="/manage" executeResult="true" />
	<div class="tab_right">
		<div class="tab_warp main">
			<div class="dq_step">
				${path}
				<div class="opb lb op-area noprint">
					<p class="more_j">更多操作</p>
					<div class="mcz_list subHide">
						<a class="input-gray"
							href="<s:url namespace="/qkjmanage" action="entert_list"><s:param name="viewFlag">relist</s:param></s:url>">返回列表</a>
					</div>
				</div>
			</div>
			<s:form id="editForm" name="editForm" cssClass="validForm"
				action="entert_load" namespace="/qkjmanage" method="post"
				theme="simple">
				<div class="label_con">
					<s:if test="'mdy' == viewFlag">
						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">申请编号:</div>
								<div class="label_rwben">${entert.uuid}<s:hidden
										name="entert.uuid" />
								</div>
							</div>
						</div>
					</s:if>
					<div class="label_hang">
			            <div class="label_ltit">状态:</div>
			            <div class="label_rwben label_rwb"><s:select  name="entert.state" cssClass="selectKick"  list="#{0:'未出库',1:'已出库'}" /></div>
			        </div>
					<div class="label_hang">
						<div class="label_ltit">申请部门:</div>
						<div class="label_rwben2">
							<span class="label_rwb"> <s:textfield title="部门名称"
									id="userdept_nameid" name="entert.apply_dept_name"
									readonly="true" /> <s:hidden title="部门代码" id="userdept_codeid"
									name="entert.apply_dept" readonly="true" />
							</span> <span class="lb nw"> <img class="detail vatop"
								src='<s:url value="/images/open2.gif" />'
								onclick="selectDept('userdept_codeid','userdept_nameid',true);"  />
								<s:checkbox id="apply_is_sub_dept" name="entert.is_sub_dept"
									cssClass="regular-checkbox" /> <label for="apply_is_sub_dept"></label>包含子部门<span
								id="ajax_member_message"></span>
							</span>
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">申请人:</div>
						<div class="label_rwben label_rwb">
							<s:select id="membermanagerid" cssClass="selectKick"
								name="entert.apply_user" list="#{}" headerKey=""
								headerValue="--请选择--" />
						</div>
					</div>
					
					<div class="label_hang">
							<div class="label_ltit">申请日期:</div>
							<div class="label_rwben2">
								<span class="label_rwb nw"> <input
									class="datepicker iI iI-f validate[required,custom[date]]"
									type="text" name="entert.apply_date" title="从"
									value="${it:formatDate(entert.apply_date,'yyyy-MM-dd')}" />
								</span> 
							</div>
					</div>

					<s:if test="'mdy' == viewFlag">
						<div class="label_main">
							<div class="lb_xxsm">
								<div class="lb_lgsfy">
									<p class="lb_yjtit">
										
										<c:if
											test="${it:checkPermit('QKJ_QKJMANAGE_ENTERTAI',null)==true}">
											
											<s:url id="ladingAddProductsUrl" action="qkjm_addProducts" namespace="qkjmanage">
												<s:param name="uuidKey">entert.uuid</s:param>
												<s:param name="uuidValue" value="entert.uuid" />
												<s:param name="backUrl">/qkjmanage/entert_load?viewFlag=mdy&</s:param>
												<s:param name="actionUrl">/qkjmanage/entertProduct_add</s:param>
												<s:param name="keyName">entertProduct.enter_id</s:param>
												<s:param name="prodName">entertProduct.product_id</s:param>
												<s:param name="perName">entertProduct.per_price</s:param>
												<s:param name="numName">entertProduct.num</s:param>
												<s:param name="totalName">entertProduct.total_price</s:param>
											</s:url>
											<input type="button" id="product" onclick="window.location.href='${ladingAddProductsUrl}';" value="添加酒品" />
										</c:if>
										
									</p>
									
									<div class="lb_lgsfy" style="width: 100%;border: none;">	
									<div class="lb_yjcon">
										<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
											<tr>
												<th>品名</th>
												<th>单价</th>
												<th>数量(瓶)</th>
												<th>合计</th>
												<th>操作</th>
											</tr>
											<s:iterator value="entertProducts" status="sta">
												<tr>
													<td class="nw">${product_name}</td>
													<td class="nw">￥${per_price}</td>
													<td class="nw">${num}/${num/case_spec}件</td>
													<td class="nw">￥${total_price}</td>
													<td>
													<a href="<s:url action="entertProduct_del"><s:param name="entertProduct.uuid" value="%{uuid}" /><s:param name="entertProduct.enter_id" value="%{entert.uuid}" /></s:url>" onclick="return isDel();">[删除]</a>
													</td>
												</tr>
											</s:iterator>
										</table>
									
									</div>
								</div>
								</div>
								<div class="lb_gsfy">
									<p class="lb_yjtit">
										<c:if test="${it:checkPermit('QKJ_QKJMANAGE_ENTERTAI_ADD',null)==true}">
											<input type="button" id="addMember" value="添加客户" />
										</c:if>
									</p>
									<div class="lb_yjcon">
										<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
											<tr>
												<th>客户</th>
												<th>说明</th>
												<th>操作</th>
											</tr>
											<s:iterator value="entertMems" status="sta">
												<tr>
													<td><a href="javascript:;">${member_name}</a></td>
													<td>${title}</td>
													<td class="nw">
															<a href="<s:url action="entertMem_del"><s:param name="entertMem.uuid" value="%{uuid}" /><s:param name="entertMem.enter_id" value="%{entert.uuid}" /></s:url>" onclick="return isDel();">[删除]</a>
													</td>
												</tr>
											</s:iterator>
										</table>
									</div>
								</div>
							</div>
						</div>

					</s:if>
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">方案说明:</div>
							<div class="label_rwbenx"></div>
						</div>
					</div>
					<div class="label_main">
						<div class="note_area">
							<s:textarea name="entert.remark" title="说明"
								cssClass="xheditorArea validate[maxSize[65535]]" />
							<div class="clear"></div>
						</div>
					</div>
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">相关操作:</div>
							<div class="label_rwbenx">
								<font color="red"><span id="messages"></span></font>
								<c:if
									test="${'add' == viewFlag && it:checkPermit('QKJ_QKJMANAGE_ENTERTAI_ADD',null)==true}">
									<s:submit id="add" name="add" value="下一步&填写酒品"
										action="entert_add" cssClass="input-blue" />
								</c:if>
								<s:if
									test="'mdy' == viewFlag">
									<c:if
										test="${it:checkPermit('QKJ_QKJMANAGE_ENTERTAI_MDY',null)==true}">
										<s:submit name="save" value="保存" action="entert_save"
											cssClass="input-blue" />
									</c:if>
									<c:if
										test="${it:checkPermit('QKJ_QKJMANAGE_ENTERTAI_DEL',null)==true}">
										<s:submit id="delete" name="delete" value="删除"
											action="entert_del" onclick="return isDel();"
											cssClass="input-red" />
									</c:if>
								</s:if>
							</div>
						</div>
					</div>

				</div>
			</s:form>
		</div>
	</div>
	<!-- HIDDEN AREA BEGIN -->
	<div class="dn">
		<!-- 添加酒品 -->
		<div id="addProductForm" class="label_con idialog" title="添加酒品">
			<s:form id="form_addProductForm" name="form_addProductForm"
				cssClass="validFormDialog" action="activeProduct_add"
				namespace="/qkjmanage" method="post" theme="simple">
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">产品:</div>
						<div class="label_rwben label_rwb">
							<select name="activeProduct.product_id" title="产品">
								<s:iterator value="products" status="sta">
									<option
										data='<s:property value="market_price" />#<s:property value="group_price" />#<s:property value="dealer_price" />#<s:property value="agree_price_1" />#<s:property value="agree_price_2" />#<s:property value="agree_price_3" />'
										data_case='<s:property value="case_spec" />'
										value='<s:property value="uuid" />'>
										<s:property value="title" />
									</option>
								</s:iterator>
							</select>
						</div>
						<!-- <div class="label_rwben">
	    	<s:textfield name="activeProduct.product_id"   id="citySel" onclick="showMenu(); return false;"  />
	    	<div id="menuContent" class="menuContent">
		        <ul id="treeDemo" class="ztree"></ul>
		    </div>
	    </div> -->
					</div>
					<div class="label_hang">
						<div class="label_ltit">单价:</div>
						<div class="label_rwben">
							<span class="label_rwb"><s:textfield
									name="activeProduct.per_price"
									cssClass="validate[required,custom[number],maxSize[11]]" /></span>
							<div id="per_price_select_area" class="label_rwb">
								<select id="per_price_select"></select>
							</div>
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">数量:</div>
						<div class="label_rwben">
							<div class="nw">
								<s:textfield name="activeProduct.num"
									cssClass="validate[required,custom[integer],maxSize[11]]" />
								瓶
							</div>
							<span id="ladingItemnumCase nw"></span>
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">合计:</div>
						<div class="label_rwben nw">
							<s:textfield name="activeProduct.total_price" title="合计"
								cssClass="validate[required,custom[number],maxSize[11]]" />
							元
						</div>
					</div>
					<div class="label_hang label_button tac">
						<s:hidden name="activeProduct.active_id" value="%{entert.uuid}" />
						<c:if
							test="${it:checkPermit('QKJ_QKJMANAGE_ACTIVEPRODUCT_ADD',null)==true}">
							<s:submit id="activeProduct_add" name="activeProduct_add"
								value="确定" action="activeProduct_add" />
						</c:if>
					</div>
				</div>
			</s:form>
		</div>


		<!-- 添加销售物料(公司) -->
		<div id="addPosmForm" class="label_con idialog" title="添加销售物料(公司)">
			<s:form name="form_addPosmForm" cssClass="validFormDialog"
				action="activePosm_add" namespace="/qkjmanage" method="post"
				theme="simple">
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">名目:</div>
						<div class="label_rwben label_rwb">
							<s:textfield name="activePosm.title" title="名目"
								cssClass="validate[required,maxSize[32]]" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">名目说明:</div>
						<div class="label_rwben label_rwb">
							<s:textfield name="activePosm.note" title="名目说明"
								cssClass="validate[required,maxSize[255]]" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">金额:</div>
						<div class="label_rwben label_rwb nw">
							<s:textfield name="activePosm.total_price" title="名目"
								cssClass="validate[required,custom[number],maxSize[11]]" />
							元
						</div>
					</div>
					<div class="label_hang label_button tac">
						<s:hidden name="activePosm.active_id" value="%{entert.uuid}" />
						<c:if
							test="${it:checkPermit('QKJ_QKJMANAGE_ACTIVEPOSM_ADD',null)==true}">
							<s:submit id="add" name="add" value="确定" action="activePosm_add" />
						</c:if>
					</div>
				</div>
			</s:form>
		</div>

		<div id="addMemberForm" class="label_con idialog" title="添加参与客户">
			<s:form id="addMemberFormTag" name="form_addMemberForm"
				cssClass="validFormDialog" action="entertMem_add"
				namespace="/qkjmanage" method="post" theme="simple">
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">客户名称:</div>
						<div class="label_rwben label_rwb">
							<s:textfield id="order_user_name"
								name="entertMem.member_name" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">说明:</div>
						<div class="label_rwben label_rwb">
							<s:textfield id="activeMemcost_title" name="entertMem.title"
								/>
						</div>
					</div>
					
					<div class="label_hang label_button tac">
						<s:hidden name="entertMem.enter_id" value="%{entert.uuid}" />
							<s:submit id="add" name="add" value="确定" action="entertMem_add" />
					</div>
				</div>
			</s:form>
		</div>

		<!-- 添加随量信息 -->

		<div id="viewMember" class="label_con idialog" title="客户实时信息">
			<div class="label_main">
				<div class="label_hang">
					<div class="label_ltit">会员编号:</div>
					<div id="view_member_uuid" class="label_rwben label_rwb"></div>
				</div>
				<div class="label_hang">
					<div class="label_ltit">会员手机:</div>
					<div id="view_member_mobile" class="label_rwben label_rwb"></div>
				</div>
				<div class="label_hang">
					<div class="label_ltit">会员名称:</div>
					<div id="view_member_name" class="label_rwben label_rwb"></div>
				</div>
				<div class="label_hang">
					<div class="label_ltit">随量积分:</div>
					<div id="view_member_with_score" class="label_rwben label_rwb"></div>
				</div>
			</div>
		</div>

		<div id="approveFrom" class="label_con idialog" title="审阅信息">
			<s:form name="form1" action="active_approve" cssClass="validForm"
				namespace="/qkjmanage" method="post" theme="simple">
				<input type="hidden" name="entert.uuid" value="${active['uuid']}" />
				<input type="hidden" id="add_approve_flag" name="approve.flag" />
				<div class="label_main">
					<textarea name="approve.advice" rows="3"></textarea>
				</div>
				<div class="label_main tac" style="padding: 5px 0;">
					<c:if
						test="${it:checkPermit('QKJ_QKJMANAGE_ACTIVE_APPROVE',null)==true}">
						<input type="submit" name="approve_pass" value="审阅通过"
							onclick="return addApproveCheck(10);" />
						<input type="submit" name="approve_fail" value="审阅不通过"
							onclick="return addApproveCheck(5);" />
					</c:if>
					<c:if
						test="${'true'==isApprover && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_APPROVEDELLAST',null)==true}">
						<s:submit name="active_approveDel" value="撤销最后一次审阅"
							action="active_approveDel" onclick="return isOp('确定进行此操作?');" />
					</c:if>
				</div>
			</s:form>
		</div>

		<s:action name="ref_foot" namespace="/manager" executeResult="true" />
		<script type="text/javascript">
		var curr_apply_dept = '${entert.apply_dept}';
			function check() {
				var n = $
				{
					nextUuid
				}
				;
				if (n != 0) {
					if (confirm("操作成功,是否跳转下一条？")) {
						location.href = "/qkjmanage/active_nextList?befUid="
								+ $
						{
							entert.uuid
						}
						+"&viewFlag='relist'";
					}
				}
			};
			$(function() {
				$("#editForm :input").change(function() {
					//if()cellarOrder_check0 10 15 20
					//$("#rebates_mdyRebatesStatus0").attr("disabled","disabled");
					if ($("#mdyStatus0").length > 0) {
						$("#mdyStatus0").attr("disabled", "disabled");
					}

					$("#messages").text("请先保存后才能做其他操作!");
				});
			});
		</script>
		<script type="text/javascript">
			var add_per_price_input = $("#form_addProductForm :input[name='activeProduct.per_price']");
			var add_num_input = $("#form_addProductForm :input[name='activeProduct.num']");
			var add_total_price_input = $("#form_addProductForm :input[name='activeProduct.total_price']");
			var add_product_id = $("#form_addProductForm :input[name='activeProduct.product_id']");

			$(function() {
				if(curr_apply_dept!='') {
					loadManagers(curr_apply_dept,'${entert.apply_user}');
				}
				add_per_price_input.bind("keyup", function() {
					add_total_price_input.val($(this).val()
							* add_num_input.val());

				});
				add_num_input.bind("keyup", function() {
					add_total_price_input.val($(this).val()
							* add_per_price_input.val());
					setDataCase();
				});
				$("#per_price_select_area").hide();
				add_product_id.bind("change", function() {
					add_per_price_input.val("");
					$("#per_price_select").clearAllOption();
					if ($(this).getSelectedAttr("data") == null
							|| $(this).getSelectedAttr("data") == '') {
						$("#per_price_select_area").hide();
					} else {
						var ps = $(this).getSelectedAttr("data").split("#");
						if (ps.length >= 3) {
							$("#per_price_select").addOption("自定义", "");
							$("#per_price_select").addOption(
									"市场价(" + ps[0] + ")", ps[0]);
							$("#per_price_select").addOption(
									"团购价(" + ps[1] + ")", ps[1]);
							$("#per_price_select").addOption(
									"出厂价(" + ps[2] + ")", ps[2]);
							if (ps[3] != '')
								$("#per_price_select").addOption(
										"协议价1(" + ps[3] + ")", ps[3]);
							if (ps[4] != '')
								$("#per_price_select").addOption(
										"协议价2(" + ps[4] + ")", ps[4]);
							if (ps[5] != '')
								$("#per_price_select").addOption(
										"协议价3(" + ps[5] + ")", ps[5]);
							$("#per_price_select_area").fadeIn(1000);
						}
					}
				});
				$("#per_price_select").bind(
						"change",
						function() {
							add_per_price_input.val($(this).val());
							add_total_price_input.val($(this).val()
									* add_num_input.val());
							setDataCase();
						});
			});

			function setDataCase() {
				var data_case = add_product_id.getSelectedAttr("data_case");
				var num_value = add_num_input.val();
				if (!(data_case == null || data_case == '' || num_value == null || num_value == '')) {
					$("#ladingItemnumCase").text((num_value / data_case) + '件');
				}
			}
		</script>
		<script type="text/javascript">
			$("#addMe")
					.click(
							function() {
								$
										.ajax({
											type : 'POST',
											url : '/sysvip/getMember',
											data : "params="
													+ $("#order_user_id").val(),
											beforeSend : function() {
												$("#addMemcost")
														.text("正在验证...");
											},
											success : function(data) {
												if (data == "false") {
													alert("此客户不存在\n请到[会员管理>添加会员]处添加会员信息后再继续填写.");
												} else if ($(
														"#activeMemcost_title")
														.val() == '') {
													alert("【名目】不许为空!");
													$("#activeMemcost_title")
															.focus();
												} else if ($(
														"#activeMemcost_note")
														.val() == '') {
													alert("【名目说明】不许为空!");
													$("#activeMemcost_note")
															.focus();
												} else if ($(
														"#activeMemcost_total_price")
														.val() == '') {
													alert("【金额】不许为空!");
													$(
															"#activeMemcost_total_price")
															.focus();
												} else {
													$("#addMemberFormTag")
															.submit();
												}
											},
											complete : function() {
												$("#addMemcost").text("");
											}
										});
							});

			$("#upprice").bind("change", function() {
				$("#bprice").val($("#upprice").val() - $("#price").val());
			});
		</script>
		<script type="text/javascript">
			$("#price").bind("change", function() {
				$("#bprice").val($("#upprice").val() - $("#price").val());
			});
		</script>

		<!-- 添加市场基金信息 -->

		<script type="text/javascript">
			$("#fupprice").bind("change", function() {
				$("#fbprice").val($("#fupprice").val() - $("#fprice").val());
			});
		</script>


		<script type="text/javascript">
			$("#fprice").bind("change", function() {
				$("#fbprice").val($("#fupprice").val() - $("#fprice").val());
			});
		</script>

		<script type="text/javascript">
			$(function() {
				$("#approveFrom").dialog({
					autoOpen : false,
					modal : true
				});
			});

			function openApprove() {
				$("#approveFrom").dialog("open");
			}

			//add_approve_flag
			function addApproveCheck(flag) {
				if (window.confirm("确定要审阅吗?")) {
					//alert(flag);
					$("#add_approve_flag").val(flag);
					return true;
				} else {
					return false;
				}
			}
		</script>
		<script type="text/javascript">
			var infoeditor01;
			$(function() {
				$("#addProductForm").dialog({
					autoOpen : false,
					modal : true
				});
				$("#addProduct").click(function() {
					$("#addProductForm").dialog("open");
				});
				$("#addPosmForm").dialog({
					autoOpen : false,
					modal : true
				});
				$("#addMpriceForm").dialog({
					autoOpen : false,
					modal : true
				});

				$("#addFpriceForm").dialog({
					autoOpen : false,
					modal : true
				});
				$("#addPosm").click(function() {
					$("#addPosmForm").dialog("open");
				});

				$("#addFprice").click(function() {
					$("#addFpriceForm").dialog("open");
				});

				$("#addMprice").click(function() {
					$("#addMpriceForm").dialog("open");
				});

				$("#addMemberForm").dialog({
					autoOpen : false,
					modal : true
				});
				$("#addMember").click(function() {
					$("#addMemberForm").dialog("open");
				});

				$("#viewMember").dialog({
					autoOpen : false,
					modal : true
				});
				SimpleLoadMember(ajax_url, $.noop);
			});

			function loadMemberInfo(member_id) {
				$("#view_member_uuid").text("正在加载...");
				$("#view_member_mobile").empty();
				$("#view_member_name").empty();
				$("#view_member_with_score").empty();
				var ajax = new Common_Ajax();
				ajax.config.action_url = ajax_url;
				ajax.config._success = function(data, textStatus) {
					var m = data[0];
					$("#view_member_uuid").text(m.uuid);
					$("#view_member_mobile").text(m.mobile);
					$("#view_member_name").text(m.member_name);
					$("#view_member_with_score").text(m.with_score);
					$("#viewMember").dialog("open");
				};
				ajax.addParameter("work", "AutoComplete");
				ajax.addParameter("parameters",
						"privilege_id=QKJ_QKJMANAGER_AJAXLOAD_MEMBER&uuid="
								+ member_id);
				ajax.sendAjax();
			}
		</script>
		<script type="text/javascript"
			src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
		
	</div>
	<!-- HIDDEN AREA END -->
</body>
</html>