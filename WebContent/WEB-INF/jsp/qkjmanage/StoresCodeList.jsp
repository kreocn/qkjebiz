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
<style type="text/css">


</style>
</head>
<body>
	<!-- 顶部和左侧菜单导航 -->
	<s:action name="nav" namespace="/manage" executeResult="true" />
	<div class="tab_right input-a">
		<div class="dq_step">
			<a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;条码打印
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
		<s:form id="serachForm" name="serachForm" action="insert_sotres_order" method="get" namespace="/qkjmanage" theme="simple">
			<div class="tab_warp" id="printdiv">
				<div >
					<table id="qkj_list">
						<tr>
							<th class="td1" >   条码</th>
							<th class="td1">名称</th>
							<th class="td1" name="printre">操作</th>
						</tr>
					</table>
					<div style="margin: 10px 0;">
							<s:textfield  type="hidden"  name="is_li" value="stores"/>
					<input type="hidden" name="member.uuid" id="order_user_id" value="">
					<input type="hidden" name="sotresorder.member_id" id="order_user_id_2" value="">
					<input type="hidden" name="sotresorder.member_name" id="order_user_name_2" value="">
					<input type="hidden" name="sotresorder.member_mobile" id="order_user_mobile" value="">
					
					<font id="addMemcost" color="red"></font>
					</div>
				</div>
			</div>
			<input type="button" value="打印"  onClick="printdiv('div_print');" value=" Print "cssClass="input-blue" />
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
				
					var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
					var ajax = new Common_Ajax();
					ajax.config.action_url = ajax_url_action;
					ajax.config._success = function(data, textStatus){
						if (data) {
						 if (data.length == 0) {
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
	function ondeltr(data){
		$("#" + data.id).parents("tr").remove();
	}
	function fortr(list){
		var code = $(".tiaomainput").val();
		var casenum = 1;
		var barcode = list[0].bar_code;
		
		if (firstnum == true) {
			var host=window.location.host;
			var product_id = list[0].uuid;
			var procode = list[0].prod_code;
			var title = list[0].title;
			var spec = list[0].spec;
			var brand = list[0].brand;
			var marketprice = list[0].market_price;
			show.push('<tr style="height:90px">');
			
			show.push('<input type="hidden" name="storesorderitem['+num+'].product_id" value="'+product_id+'"/>')
				show.push('<td class="td1" style="width:500px;  text-align:center; "><img src="http://'+host+'/qkjmanage/stores_code_image?codeStr='+barcode+' " /></td>');
			show.push('<td class="td1" ><input type="hidden" name="storesorderitem['+num+'].title"  value="'+title+'"/>' + title + '</td>');
		
			show.push(' <td class="td1 op-area"  name="printre"><a id="rmtr' + num + '" onclick="javascript:ondeltr(this)" href="javascript:void(0)" class="input-red">删除</a></td>');
			show.push('</tr>');
	
			$("#qkj_list").append(show.join(""));
			show = new Array();
		}
	}


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
	

	function down(){
		$("#storessubmit").click();
	}

	
	
	
	
</script>



<script language="javascript">  

function printdiv(printpage)  
{  
	$("[name=printre]").remove();

var headstr = "<html><head><title></title></head><body>";  
var footstr = "</body>";  
var printData = document.getElementById("printdiv").innerHTML; 
var oldstr = document.body.innerHTML;  

document.body.innerHTML = headstr+printData+footstr;  
window.print();  
document.body.innerHTML = oldstr;  
return false;  
}  
</script>  


</html>