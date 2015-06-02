<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>门店支付首页<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
	<!-- 顶部和左侧菜单导航 -->
	<s:action name="nav" namespace="/manage" executeResult="true" />
	<div class="tab_right input-a">
		<div class="dq_step">
			<a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;门店支付
		</div>
		<div class="label_main">
			<div class="label_hang">
				<div class="label_ltit">品名:</div>
				<div class="label_rwbenx">
					<s:textfield id="auto_prod_name" name="prodname" cssClass="selectAll iI iI-s" />
					<input id="auto_prod_id" type="hidden" name="prodid" />
				</div>
			</div>
			<div class="label_hang">
				<div class="label_ltit">条形码:</div>
				<div class="label_rwbenx">
					<s:textfield class="tiaomainput" name="customer.uuid" id="tiaomainput" onkeydown= "if(event.keyCode==13)down()"/>
		
					&nbsp;<input type="reset" value="添加" id="storessubmit" >
				</div>
			</div>
			<div class="label_hang" id="svipname" style="display: none">
						<div class="label_ltit">会员名称:</div>
						<div class="label_rwben label_rwb">
							<s:textfield id="order_user_name" name="activeMemcost.member_name" />
						</div>
					</div>
					<div class="label_hang label_button tac">
					<div class="label_ltit">是否是会员:</div>
						<s:radio onclick="qianzai(this);"  name="member.is_customers" title="是否是会员"  list="#{0:'否',1:'是'}" value="0" cssClass="regular-radio" />
						</div>
							<div class="label_hang">
			
				<div class="label_rwbenx">
					<input type="button" value="扫货模式" id="saohuo" >
				</div>
						
		</div>
		<!-- <div class="tiaoma_hang">
	       <div class="tiaoma_ltit">条形码：<input class="tiaomainput"  name="customer.uuid"  title="客户编号" />				       
		      <input class="tiaomareset" type="reset" value="添加" id="storessubmit"> 				      
		      <s:textfield id="auto_prod_name" name="prodname" cssClass="selectAll iI iI-s" />
	             <input id="auto_prod_id" type="hidden" name="prodid" />				    
	      </div>
	       <span><a class="tiaomareset" style="float: right;margin-top: 10px;" href="/qkjmanage/stores_order_update.action">修改订单</a></span>
	</div>
	<s:form id="serachForm" name="serachForm" action="insert_sotres_order"  method="get" namespace="/qkjmanage" theme="simple">
		<div class="tab_warp" >
			<table id="qkj_list">
				<tr id="coltr" >
			    <th class="td1">统一编码</th>
				<th class="td2">条形码</th>
				<th class="td3">系列</th>
				<th class="td4">品名</th>
				<th class="td5">规格</th>
				<th class="td6">单价</th>
				<th class="td6">总价</th>
				<th class="td7">数量</th>
				<th class="td8">操作</th>
			 	</tr>
			</table>
		</div>
	    <s:submit class="tiaomareset" type="reset" value="提交订单" id="sumbit_order"/> 
	</s:form> -->
		<s:form id="serachForm" name="serachForm" action="insert_sotres_order" method="get" namespace="/qkjmanage" theme="simple">
			<div class="tab_warp">
				<div class="tab_txm">
					<table id="qkj_list">
						<tr>
							<th class="td1">品名</th>
							<th class="td1">单价</th>
							<th class="td1">数量</th>
							<th class="td1">总价</th>
							<th class="td1">操作</th>
						</tr>
					</table>
					<div style="margin: 10px 0;">
					<input type="hidden" name="member.uuid" id="order_user_id" value="">
					<input type="hidden" name="sotresorder.member_id" id="order_user_id_2" value="">
					<input type="hidden" name="sotresorder.member_name" id="order_user_name_2" value="">
					<input type="hidden" name="sotresorder.member_mobile" id="order_user_mobile" value="">
					<s:submit type="reset" value="提交订单" onclick="return nonull();" id="sumbit_order" cssClass="input-blue" />
					<font id="addMemcost" color="red"></font>
					</div>
				</div>
				<div class="tab_txm2">
					<table>
						<tr>
							<th class="td1">订单时间</th>
							<th class="td1">订单总价</th>

							<th class="td1">操作</th>
						</tr>
						<s:iterator value="storesorderlist" status="sta">
							<tr>
								<td class="td1">${add_time}</td>
								<td class="td1">${total_price}</td>
								<td class="td1 op-area"><a class="input-blue" href="/qkjmanage/stores_order_update_details.action?id=${id}">查看详情</a></td>
							</tr>
						</s:iterator>
					</table>
				</div>

			</div>
		</s:form>
	</div>
	<s:action name="ref_foot" namespace="/manager" executeResult="true" />
	<script type="text/javascript" src="<c:url value="/js/func/select_products.js" />"></script>
	<div id="dialog" title="重复条码选择" style="display: none">
		
	</div>
</body>
<script>
	var num = 0;
	var firstnum = true;
	var show = new Array();
	$("#storessubmit")
			.click(function(){
				var code = $(".tiaomainput").val();
				var puuid = $("#auto_prod_id").val();
				if (code != "" && code != null || puuid != null && puuid != "") {
					/* $.ajax({
					type:"post",
					url:"/qkjebiz/qkjmanage/add_sotres_list",
					data:{code:code},
					//async: false,
					cache: false,
					success:function(data){
					}
					});  */
					var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
					var ajax = new Common_Ajax();
					ajax.config.action_url = ajax_url_action;
					ajax.config._success = function(data, textStatus){
						if (data) {
							if (data.length > 1) {
								$('#dialog').css('display', 'block');
								$("#dialog").dialog();
								$("#dialog").empty();
								keyOff();
								keyOn();
								var tiaomainput=$("#tiaomainput").val();
								for (var i = 0; i < data.length; i++) {
									var repeatshow = new Array();
									var product_id = data[i].uuid;
									var procode = data[i].prod_code;
									var barcode = data[i].bar_code;
									var bar_code_box = data[i].bar_code_box;
									var bar_code_tibet = data[i].bar_code_tibet;
									var bar_code_tibet_box = data[i].bar_code_tibet_box;
									var title = data[i].title;
									var t_title=(i+1)+" "+title;
									var spec = data[i].spec;
									var brand = data[i].brand;
									var marketprice = data[i].market_price;
									var case_spec = data[i].case_spec;
									repeatshow
											.push('<p><a wiid="'+i+'" id="' + product_id + ',' + procode + ',' + barcode + ',' + title + ',' + spec + ',' + marketprice + ',' + brand + ',' + bar_code_box + ',' + bar_code_tibet + ',' + bar_code_tibet_box + ',' + case_spec + ','+tiaomainput+'" name="' + barcode + '"  href="javascript:void(0)" onclick="javascript:mylist(this)" value="' + marketprice + ',' + spec + ',' + title + '">' +t_title+ '</a></p>');
									$("#dialog").append(repeatshow.join(""));
								}
								$("#tiaomainput").val('');
							} else if (data.length == 0) {
								alert("请输入正确的条码");
							} else {
								fortr(data);
							}
						} else {
							alert("请输入正确的条码")
						}
						firstnum = true;
						$("#tiaomainput").val('');
					};

					ajax.addParameter("parameters", "code=" + code + "&puuid=" + puuid);
					ajax.addParameter("work", "StoresOrder");
					ajax.sendAjax();

				} else {
					alert("请输入正确的条码")
				}

			});
	function mylist(list){
		var msg = list.id.split(",");
		var bar_code = msg[2];
		var bar_code_box = msg[7];
		var bar_code_tibet = msg[8];
		var bar_code_tibet_box = msg[9];
		var barcode = null;
		var casenum = 1;
		var code = $(".tiaomainput").val();
		var case_spec = msg[10];
		barcode = bar_code;
		if (bar_code_box == msg[11]) {
			casenum = case_spec;
		} else if (bar_code_tibet == msg[11]) {} else if (bar_code_tibet_box == msg[11]) {
			casenum = case_spec;
		}
		$("#qkj_list").find("tr").each(function(){

			$(this).find("td").each(function(){

				if (barcode.trim() == $(this).text().trim()) {

					if (msg[3] == $(this).next().next().text().trim()) {

						var numplus = $(this).next().next().next().next().next().find("input[type=text]").val();
						var price = $(this).next().next().next().next().find("input[type=hidden]").val();
						var totlprice = $(this).next().next().next().next().next().next().find("input[type=hidden]").val();
						totlprice = (parseFloat(totlprice) + parseFloat(price * casenum)).toFixed(2);
						var totalName = $(this).next().next().next().next().next().next().find("input").attr("name");
						$(this).next().next().next().next().next().next().find("input[type=hidden]").val(totlprice);
						$(this).next().next().next().next().next().next().find("input[type=text]").val(totlprice)
						var ordernumName = $(this).next().next().next().next().next().find("input").attr("name");
						var ordernumcount = (Number(numplus) * 1) + casenum;
						$(this).next().next().next().next().next().find("input[type=text]").val(ordernumcount)
						$("#dialog").dialog('close');
						firstnum = false;
					}
				}
			})
		})
		if (firstnum == true) {
			var msg = list.id.split(",");
			show.push('<tr>');
			show
					.push('<td class="td1" style="display:none"><input type="hidden" name="storesorderitem['+num+'].product_id" value="'+msg[0]+'"/><input type="hidden" name=storesorderitem['+num+'].prod_code value="'+msg[1]+'"/>' + msg[1] + '</td>');
			show.push('<td class="td1" style="display:none"> <input type="hidden" name="storesorderitem['+num+'].bar_code" value="'+msg[2]+'"/>' + msg[2] + '</td>');
			show.push('<td class="td1" style="display:none"><input type="hidden" name="storesorderitem['+num+'].brand"   value="'+msg[6]+'"/>' + msg[6] + '</td>');
			show.push('<td class="td1"><input type="hidden" name="storesorderitem['+num+'].title" value="'+msg[3]+'"/>' + msg[3] + '</td>');
			show.push('<td class="td1" style="display:none"><input type="hidden"  name="storesorderitem['+num+'].spec"  value="'+msg[4]+'"/>' + msg[4] + '</td>');
			show
					.push('<td class="td1" ><input  type="hidden" id="price'+msg[0]+'" name="storesorderitem['+num+'].product_price"  value="'+msg[5]+'"/><input type="text" onkeyup="update_price(' + msg[0] + ')" value="' + msg[5] + '" style="width:50px" ></td>');
			show
					.push('<td class="td1"><input type="button" id="jisuanjian'+msg[0]+'" value="-" /> <input type="text" style="width:40px" id="jisuannum'+msg[0]+'" name="storesorderitem['+num+'].order_num" value="'+casenum+'"  readonly="readonly"/><input type="button" id="jisuanadd'+msg[0]+'" value="+" /> </td>');
			show
					.push('<td class="td1" id="jisuanprice'+msg[0]+'"><input id="total_price'+msg[0]+'" type="hidden" name="storesorderitem['+num+'].order_total_price"  value="'+msg[5]*casenum+'"/><input type="text"    onkeyup="up_total_price(' + msg[0] + ')" value="' + msg[5] * casenum + '"  style="width:50px"></td>');
			show.push(' <td class="td1 op-area"><a id="rmtr' + num + '" onclick="javascript:ondeltr(this)" href="javascript:void(0)" class="input-red">删除</a></td>');
			show.push('</tr>');
			$("#qkj_list").append(show.join(""));
			$("#dialog").dialog('close');
			show = new Array();
			var iNum = num;
			$("#jisuanadd" + msg[0])
					.click(function(){
						var n = $("#jisuannum" + msg[0]).val();
						var jinum = parseInt(n) + 1;
						$("#jisuanprice" + msg[0]).empty();
						$("#jisuanprice" + msg[0])
								.append('<input type="hidden" id="total_price' + msg[0] + '" name="storesorderitem[' + iNum + '].order_total_price"  value="' + $("#price" + msg[0])
										.val() * jinum + '"/>' + '<input type="text"  value="' + $("#price" + msg[0]).val() * jinum + '" onkeyup="up_total_price(' + msg[0] + ')"  style="width:50px">');
						$("#jisuannum" + msg[0]).val(jinum);
					});
			$("#jisuanjian" + msg[0])
					.click(function(){

						var n = $("#jisuannum" + msg[0]).val();
						var jinum = parseInt(n) - 1;
						if (jinum != 0) {
							$("#jisuanprice" + msg[0]).empty();
							$("#jisuanprice" + msg[0])
									.append('<input type="hidden" id="total_price' + msg[0] + '" name="storesorderitem[' + iNum + '].order_total_price"  value="' + $("#price" + msg[0])
											.val() * jinum + '"/>' + '<input type="text"  value="' + $("#price" + msg[0]).val() * jinum + '"  onkeyup="up_total_price(' + msg[0] + ')" style="width:50px">');
						}
						if (jinum == 0) {
							alert("不能为0!");
							return
						}
						$("#jisuannum" + msg[0]).val(jinum);
					});
		}
		firstnum = true;
		num++;
		$("#dialog").empty();
	};
	function ondeltr(data){
		$("#" + data.id).parents("tr").remove();
	}
	function fortr(list){
		var code = $(".tiaomainput").val();
		var casenum = 1;
		var barcode = list[0].bar_code;
		if (list[0].bar_code_box == code) {
			casenum = list[0].case_spec;
		} else if (list[0].bar_code_tibet == code) {} else if (list[0].bar_code_tibet_box == code) {
			casenum = list[0].case_spec;
		}
		$("#qkj_list").find("tr").each(function(){
			$(this).find("td").each(function(){
				if ($(this).text().trim() == barcode.trim()) {
					if (list[0].title.trim() == $(this).next().next().text().trim()) {
						var numplus = $(this).next().next().next().next().next().find("input[type=text]").val();
						var price = $(this).next().next().next().next().find("input[type=hidden]").val();
						var totlprice = $(this).next().next().next().next().next().next().find("input[type=hidden]").val();
						totlprice = (parseFloat(totlprice) + parseFloat(price * casenum)).toFixed(2);
						var totalName = $(this).next().next().next().next().next().next().find("input").attr("name");
						$(this).next().next().next().next().next().next().find("input[type=hidden]").val(totlprice);
						$(this).next().next().next().next().next().next().find("input[type=text]").val(totlprice)
						var ordernumName = $(this).next().next().next().next().next().find("input").attr("name");
						var ordernumcount = (Number(numplus) * 1) + casenum;
						$(this).next().next().next().next().next().find("input[type=text]").val(ordernumcount)
						firstnum = false;
					}
				}
			})
		})
		if (firstnum == true) {
			var product_id = list[0].uuid;
			var procode = list[0].prod_code;
			var title = list[0].title;
			var spec = list[0].spec;
			var brand = list[0].brand;
			var marketprice = list[0].market_price;
			show.push('<tr>');
			show.push('<input type="hidden" name="storesorderitem['+num+'].product_id" value="'+product_id+'"/>')
			show.push('<td class="td1" style="display:none"><input type="hidden" name="storesorderitem['+num+'].prod_code" value="'+procode+'"/>' + procode + '</td>');
			show.push('<td class="td1" style="display:none"><input type="hidden" name="storesorderitem['+num+'].bar_code" value="'+barcode+'"/>' + barcode + '</td>');
			show.push('<td class="td1" style="display:none" ><input type="hidden"name="storesorderitem['+num+'].brand"  value="'+brand+'"/></td>');
			show.push('<td class="td1" ><input type="hidden" name="storesorderitem['+num+'].title"  value="'+title+'"/>' + title + '</td>');
			show.push('<td class="td1" style="display:none"><input type="hidden" name="storesorderitem['+num+'].spec"  value="'+spec+'"/>' + spec + '</td>');
			show
					.push('<td class="td1" ><input type="hidden" id="price'+product_id+'" name="storesorderitem['+num+'].product_price"  value="'+marketprice+'"/><input type="text"    onkeyup="update_price(' + product_id + ')" value="' + marketprice + '"  style="width:50px"></td>');
			show
					.push('<td class="td1"><input type="button" id="jisuanjian'+product_id+'" value="-" /> <input type="text" style="width:40px" id="jisuannum'+product_id+'" name="storesorderitem['+num+'].order_num" value="'+casenum+'"   readonly="readonly"/><input type="button" id="jisuanadd'+product_id+'" value="+" /> </td>');
			show
					.push('<td class="td1" id="jisuanprice'+product_id+'"><input id="total_price'+product_id+'" type="hidden"  name="storesorderitem['+num+'].order_total_price"  value="'+marketprice*casenum+'"/><input type="text"    onkeyup="up_total_price(' + product_id + ')" value="' + marketprice * casenum + '"  style="width:50px"></td>');
			show.push(' <td class="td1 op-area"><a id="rmtr' + num + '" onclick="javascript:ondeltr(this)" href="javascript:void(0)" class="input-red">删除</a></td>');
			show.push('</tr>');
			$("#qkj_list").append(show.join(""));
			show = new Array();
			var iNum = num;
			$("#jisuanadd" + product_id)
					.click(function(){

						var n = $("#jisuannum" + product_id).val();
						var jinum = parseInt(n) + 1;
						$("#jisuanprice" + product_id).empty();
						$("#jisuanprice" + product_id)
								.append('<input type="hidden" id="total_price' + product_id + '" name="storesorderitem[' + iNum + '].order_total_price"  value="' + $("#price" + product_id)
										.val() * jinum + '"/>' + '<input type="text" onkeyup="up_total_price(' + product_id + ')"  value="' + $("#price" + product_id).val() * jinum + '" style="width:50px">');

						$("#jisuannum" + product_id).val(jinum);
					});
			$("#jisuanjian" + product_id)
					.click(function(){

						var n = $("#jisuannum" + product_id).val();
						var jinum = parseInt(n) - 1;
						if (jinum != 0) {
							$("#jisuanprice" + product_id).empty();
							$("#jisuanprice" + product_id)
									.append('<input type="hidden" id="total_price' + product_id + '" name="storesorderitem[' + iNum + '].order_total_price"  value="' + $("#price" + product_id)
											.val() * jinum + '"/>' + '<input type="text" onkeyup="up_total_price(' + product_id + ')"   value="' + $("#price" + product_id).val() * jinum + '" style="width:50px">');
						}
						if (jinum == 0) {
							alert("不能为0!");
							return
						}
						$("#jisuannum" + product_id).val(jinum);
					});
			num++;
		}
	}
	/* $("#sumbit_order").click(function(){
	 var data = '{"persons":[	';
	 var num=1;
	 $("#qkj_list").find("tr").each(function(){
	 var tdArr = $(this).children();
	 var procode = tdArr.eq(0).text();
	 var barcode=tdArr.eq(1).text();
	 var title = tdArr.eq(2).text();
	 var spec =tdArr.eq(3).text();
	 var dealerprice = tdArr.eq(4).text();
	 if(num==2){
	 data += '{"procode":"'+procode+'","barcode":"'+barcode+'","title":"'+title+'","spec":"'+spec+'","dealerprice":"'+dealerprice+'"}';    
	 }else if(num!=1){
	 data += ',{"procode":"'+procode+'","barcode":"'+barcode+'","title":"'+title+'","spec":"'+spec+'","dealerprice":"'+dealerprice+'"}';
	 data = data + "{\\\"procode\\\":\\\""+procode+"\\\",\\\"barcode\\\":\\\""+barcode+"\\\",\\\"title\\\":\\\""+title+"\\\,\\\"spec\\\":\\\""+spec+"\\\,\\\"dealerprice\\\":\\\""+dealerprice+"\\\"},";

	 }
	 num++;
	 }) 
	 data += ']}';
	 }); */

	$(function(){
		SimpleLoadProducts(function(){}, "noparam=true");
	});
	$(function(){

		SimpleLoadMember(ajax_url, $.noop);
	});
	function nonull(){
		$("#order_user_id_2").val($("#order_user_id").val())
		$("#order_user_name_2").val($("#order_user_name").val())
		var status = true;
		if (getRadio("member.is_customers") == 1) {
			$.ajax({ type : 'POST',
			url : '/sysvip/getMember',
			async : false,
			data : "params=" + $("#order_user_id").val(),
			beforeSend : function(){
				$("#addMemcost").text("正在验证...");
			},
			success : function(data){
				if (data == "false") {
					alert("此客户不存在\n请到[会员管理>添加会员]处添加会员信息后再继续填写.");
					status = false;
				}
			},
			complete : function(){
				$("#addMemcost").text("");
			} })
		}
		if (getRadio("member.is_customers") == 1) {
			if (document.getElementById("order_user_name").value == "" && status != false) {
				alert("请添加会员！")
				status = false;
			}
		}
		var flgnull = 0;

		$("#qkj_list").find("tr").each(function(){
			flgnull++;
		})

		if (flgnull <= 1 && status != false) {
			alert("请添加商品后再提交！")
			status = false;
		}
		if (status == false) { return false; }
	}

	var qianzai = function(obj){
		if (getRadio("member.is_customers") == 1) {
			document.getElementById("svipname").style.display = "";
			document.getElementById("order_user_id").value = "";
			document.getElementById("order_user_name").value = "";

		} else {
			document.getElementById("svipname").style.display = "none";
			document.getElementById("order_user_id").value = "0";
		}
	}
	function update_price(a){
		var price = $("#price" + a).parent().find("input[type=text]").val();

		if (isNaN(price)) {
			var count = price.length;
			if (count == "1") {
				$("#price" + a).parent().find("input[type=text]").val("0");
				update_price(a)
			} else {
				$("#price" + a).parent().find("input[type=text]").val(parseInt(price))
				update_price(a)
			}

		} else {
			$("#price" + a).parent().find("input[type=hidden]").val(parseInt(price))
			var num = $("#jisuannum" + a).val()
			var total_price = $("#jisuanprice" + a).find("input[type=hidden]").val(price * num)
			$("#jisuanprice" + a).find("input[type=text]").val(price * num)
		}

	}
	function up_total_price(a){
		var total_price = $("#total_price" + a).parent().find("input[type=text]").val();
		$("#total_price" + a).parent().find("input[type=text]").val(parseInt(total_price));
		$("#total_price" + a).parent().find("input[type=hidden]").val(parseInt(total_price));
	}

	function down(){
		$("#storessubmit").click();
	}
function keyOn() {
	$(document).on("keypress",function(e) {
		var key=e.which;
		 if(!$("#dialog").html()==""){
			 if(e.which==49){
			 $("a[wiid=0]").click();
				keyOff();
				$("#dialog").empty();
		 }
		 else if(e.which==50){
			 $("a[wiid=1]").click();
				keyOff();
				$("#dialog").empty();
		 }
		 else if(e.which==51){
			 $("a[wiid=2]").click();
				keyOff();
				$("#dialog").empty();
		 } else if(e.which==52){
			 $("a[wiid=3]").click();
				keyOff();
				$("#dialog").empty();
		 } else if(e.which==53){
			 $("a[wiid=4]").click();
				keyOff();
				$("#dialog").empty();
		 }else if(e.which==54){
			 $("a[wiid=5]").click();
				keyOff();
				$("#dialog").empty();
		 }
		 else if(e.which==55){
			 $("a[wiid=6]").click();
				keyOff();
				$("#dialog").empty();
		 }else if(e.which==56){
			 $("a[wiid=7]").click();
				keyOff();
				$("#dialog").empty();
		 }else if(e.which==57){
			 $("a[wiid=8]").click();
				keyOff();
				$("#dialog").empty();
		 }else if(e.which==58){
			 $("a[wiid=9]").click();
				keyOff();
				$("#dialog").empty();
		 }
			 
		 }
	}) ;
}
function keyOff() {
	$(document).off("keypress");
}
 $("#saohuo").click(function(){
	    if( $("#saohuo").val()=="扫货模式"){
	    	$("#saohuo").val("关闭扫货")
		$(document).on("mouseover",function(e) {
			$("#tiaomainput").select();
		})
			$(document).on("click",function(e) {
			$("#tiaomainput").select();
		})
	    }else if($("#saohuo").val()=="关闭扫货"){
	    	$("#saohuo").val("扫货模式")
	    	$(document).off("mouseover")
				$(document).off("click")
	    }
 })
</script>






</html>