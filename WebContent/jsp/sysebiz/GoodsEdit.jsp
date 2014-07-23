<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>藏酒管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_lite.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="/ckframe/include/widget.js"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript">
var infoeditor01;
var wb_smallImg,wb_bigImg;
$(function(){
	$("#itableformid").tabs();
	
	$("#goodstypeinfo :input[name='goods.goods_type']").bind("change",function(){
		showInfoColumn();
	});
	var showInfoColumn = function() {
		var gtype = $("#goodstypeinfo :input[name='goods.goods_type']").val();
		if(gtype==1) {
			$("#goodsInfocolumns").show();
		} else {
			$("#goodsInfocolumns").hide();
		}
	};	
	showInfoColumn();
	infoeditor01 = new widget_textarea();
	infoeditor01.init("goodsdescriptionid");
	BrowseServer(0);
	wb_smallImg = new widget_button({ inputid :"goods_small_img", objname : "wb_smallImg" });
	wb_smallImg.init(); 
	wb_bigImg = new widget_button({ inputid :"goods_big_img", objname : "wb_bigImg" });
	wb_bigImg.init(); 
});

function BrowseServer(idindex) {
	var objname = 'window.wb_goodsImgs'+idindex;
	var objname2 = 'wb_goodsImgs'+idindex;
	//先判断有没有此对象
	if(typeof(eval(objname))=='undefined') {
		var sstr = objname+'=new widget_button({ inputid:"goodsImgsurl'+idindex+'",objname:"'+objname2+'"});'+objname+'.init();';
		eval(sstr);
	}
}

var fileindex = 1;
function addMore() {
	var s = '<div id="addImg'+fileindex+'" class="addImg">';
	s+= '<a href="javascript:;" onclick="rmAdd('+fileindex+');">[-]</a> ';
	s+= '图片描述:<input type="text" name="goodsImgs['+fileindex+'].title" /> ';
	s+= '上传图片:<input type="text" id="goodsImgsurl'+fileindex+'" class="longtext01" name="goodsImgs['+fileindex+'].url" /> ';
	s+='<input type="radio" name="goodsImgs['+fileindex+'].index_flag" id="goodsImgs'+fileindex+'_index_flag0" value="0"/><label for="goodsImgs'+fileindex+'_index_flag0">普通</label> ';
	s+='<input type="radio" name="goodsImgs['+fileindex+'].index_flag" id="goodsImgs'+fileindex+'_index_flag1" value="1"/><label for="goodsImgs'+fileindex+'_index_flag1">展示</label> ';
	s+='<input type="radio" name="goodsImgs['+fileindex+'].index_flag" id="goodsImgs'+fileindex+'_index_flag2" value="2"/><label for="goodsImgs'+fileindex+'_index_flag2">主图</label> ';
   	
	s+= '</div> ';				
	$("#GoodsImgArea").append(s);
	BrowseServer(fileindex);
	fileindex++;
}

function rmAdd(n) {
	$("#addImg"+n).remove();
}

function mdyImg(uuid) {
	var newtitle = $("#imgtitle"+uuid).val();
	var newindexflag = $("input:radio[name=index_flag"+uuid+"]:checked").val();
	var ajax = new Common_Ajax('message');
	ajax.config.action_url = '<s:url value="/common_ajax/json_ajax" />';
	ajax.config._success = function(data, textStatus) {
		//alert(data);
		if(data==0) {
			alert("没有数据被修改!");
		} else if(data==1) {
			alert("修改成功!");
		} else {
			alert("功能异常,请联系管理员!");
		}
		$("#message").empty();
	};
	ajax.addParameter("privilege_id","SYS_EBIZ_GOODS_IMGMDY_AJAX");
	ajax.addParameter("work","update");
	ajax.addParameter("parameters","uuid="+uuid+"&title="+newtitle+"&index_flag="+newindexflag);
	ajax.sendAjax();
}

function delImg(uuid) {
	var ajax = new Common_Ajax('message');
	ajax.config.action_url = '<s:url value="/common_ajax/json_ajax" />';
	ajax.config._success = function(data, textStatus) {
		//alert(data);
		if(data==1) {
			$("#imgs"+uuid).fadeOut('slow',function(){
				$(this).remove();
			});
		} else {
			alert("删除失败,请联系管理员!");
		}
		$("#message").empty();
	};
	ajax.addParameter("privilege_id","SYS_EBIZ_GOODS_IMGDEL_AJAX");
	ajax.addParameter("work","update");
	ajax.addParameter("parameters","uuid="+uuid);
	ajax.sendAjax();
}

function view(obj) {
	var str = "";
	for(var i in obj) {
		str += i+"\t";
	}
	$('#message').html(str);
}
</script>
<style type="text/css">
.longtext01 {width: 300px;}
.notetxt {color:#888;}
.GoodsImgArea {padding: 30px 0;}
.GoodsImgArea .addImgInfo {padding: 5px 0;text-align: center;}
.showImg {margin: 5px;}
.showImg ul.showImgList {list-style: none;padding: 0;margin: 0;}
ul.showImgList li {width:170px;height:250px;padding: 10px;margin: 10px;float: left;border: #999 solid 1px;}
ul.showImgList .leftimg {border: #999 solid 1px;padding: 1px;display: inline-block;}
ul.showImgList .leftimg img {width: 160px; height: 160px;border: none;}
ul.showImgList .rightinfo {display: block;clear: both;margin-top: 5px;}
</style>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<s:if test="null == goods && 'add' == viewFlag">增加</s:if><s:elseif test="null != goods && 'mdy' == viewFlag">修改</s:elseif>藏酒
	</div>
<s:form name="form1" namespace="/sysebiz" onsubmit="return validator(this);" method="post" theme="simple">
	<div id="itableformid">
	<ul>
		<li><a href="#goodsbaseinfo">通用信息</a></li>
		<li><a href="#goodsdetailedinfo">详细描述</a></li>
		<li><a href="#goodstypeinfo">商品类型</a></li>
		<li><a href="#goodsimginfo">商品相册</a></li>
	</ul>
	<!-- 通用信息 -->   
	<div  id="goodsbaseinfo">
	<table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
		<s:if test="'add' != viewFlag">	
		  <tr>
		    <td class="firstRow">编号:</td>
		    <td class="secRow">
			    <s:property value="goods.uuid" />
				<s:hidden id="goods.uuid" name="goods.uuid" />
			</td>
		  </tr>
		</s:if>
		  <tr>
		    <td class="firstRow">商品货号:</td>
		    <td class="secRow">
		    	<s:textfield id="goods.goods_code" name="goods.goods_code" title="商品货号" />
		    </td>
		  </tr>
		  <tr>
		    <td class="firstRow"><span style="color:red;">*</span>商品名称:</td>
		    <td class="secRow">
		    	<s:textfield id="goods.goods_name" name="goods.goods_name" title="商品名称" require="required" controlName="商品名称" />
		    </td>
		  </tr>
		  <tr>
		    <td class="firstRow"><span style="color:red;">*</span>产品售价:</td>
		    <td class="secRow">
		    	<s:textfield id="goods.goods_price" name="goods.goods_price" title="本店售价" require="required" controlName="本店售价" />
		    </td>
		  </tr>
		  <tr>
		    <td class="firstRow"><span style="color:red;">*</span>商品规格:</td>
		    <td class="secRow">		    
		    	<s:textfield id="goods.goods_spec" name="goods.goods_spec" title="商品规格" require="required" controlName="商品规格" />
		    	<s:textfield id="goods.goods_spec_unit" name="goods.goods_spec_unit" title="商品规格单位" require="required" controlName="商品规格单位" cssStyle="width:30px;text-align: center;" />
		    </td>
		  </tr>
		  <tr>
		    <td class="firstRow"><span style="color:red;">*</span>商品库存:</td>
		    <td class="secRow">		    
		    	<s:textfield id="goods.goods_num" name="goods.goods_num" title="商品库存" require="required" controlName="商品库存" />
		    	<s:textfield id="goods.goods_unit" name="goods.goods_unit" title="商品单位" require="required" controlName="商品单位" cssStyle="width:30px;text-align: center;" />
		    	<s:hidden name="goods.goods_sales" />
		    </td>
		  </tr>
		  <tr>
		    <td class="firstRow"><span style="color:red;">*</span>产品小图:</td>
		    <td class="secRow">
		    	<s:textfield id="goods_small_img" name="goods.small_img" title="产品小图" require="required" controlName="产品小图" cssStyle="width:400px;" />
		    	<span class="message_prompt">图片规格100x100</span>
		    	<div><img src="<s:property value="goods.small_img" />" /></div>
		    </td>
		  </tr>
		  <tr>
		    <td class="firstRow">产品大图:</td>
		    <td class="secRow">
		    	<s:textfield id="goods_big_img" name="goods.big_img" title="产品大图" cssStyle="width:400px;" />
		    </td>
		  </tr>
		  <tr>
		  	<td class="secRow" colspan="2">
		  		<img src="<s:property value="goods.big_img" />" style="max-width: 100%;"  />
		  	</td>
		  </tr>
		<s:if test="'add' != viewFlag">
		  <tr>
		    <td class="firstRow">添加人:</td>
		    <td class="secRow">
		    	<s:property value="goods.add_user" />
				<s:hidden name="goods.add_user" />
			</td>		    
		  </tr>
		  <tr>
		  	<td class="firstRow">添加时间:</td>
		    <td class="secRow"><s:date name="goods.add_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		  </tr>	
		  <tr>
		    <td class="firstRow">修改人:</td>
		    <td class="secRow">
		    	<s:property value="goods.lm_user" />
				<s:hidden name="goods.lm_user" />
			</td>		    
		  </tr>
		  <tr>
		  	<td class="firstRow">修改时间:</td>
		    <td class="secRow"><s:date name="goods.lm_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		  </tr>
		</s:if>		
	</table>
	</div>
	<!-- 详细描述 -->
	<div  id="goodsdetailedinfo">
	<table id="goodsdetailedinfo_table" class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
		  <tr>
		    <td>
<textarea cols="100" id="goodsdescriptionid" name="goods.goods_description" rows="10"><s:property value="goods.goods_description" /></textarea>
		    </td>
		  </tr>		 
	</table>
	</div>

	<!-- 商品类型 -->
	<div  id="goodstypeinfo">
	<table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
	  <tr>
	    <td class="firstRow"><span style="color:red;">*</span>商品类型:</td>
	    <td class="secRow">
	    	<s:select title="商品类型" 
				name="goods.goods_type"
				list="#{1:'藏酒'}"
				headerKey=""
				headerValue="--请选择--"
				require="required" controlName="商品类型" />
	    </td>
	  </tr>
	  <tbody id="goodsInfocolumns" style="display: none;">
	  <tr>
	    <td class="firstRow"><span style="color:red;">*</span>所在仓库:</td>
	    <td class="secRow">
	    	<s:select name="goodsInfo.column_1" list="column_1list" headerKey="" headerValue="--请选择--"
	    		listKey="key" listValue="value"
	    		require="required" controlName="所在仓库" />
	    	<s:hidden name="goodsInfo.goods_id" value="%{goods.uuid}" />
	    	<s:hidden name="goodsInfo.uuid" />
	    </td>
	  </tr>
	  <tr>
	    <td class="firstRow"><span style="color:red;">*</span>酒坛位置编号前缀:</td>
	    <td class="secRow">
	    	<s:if test="'add' == viewFlag">
				<s:textfield name="goodsInfo.column_2" title="酒坛位置编号前缀" require="required" controlName="酒坛位置编号前缀" /><br />
				<span class="message_prompt">添加藏酒时,自动生成藏酒编号,此项目不能修改,请慎重填写!</span>
			</s:if>
			<s:elseif test="null != goods && 'mdy' == viewFlag">
				<s:property value="goodsInfo.column_2" /><s:hidden name="goodsInfo.column_2" />
			</s:elseif>
	    </td>
	  </tr>
	  <tr>
	    <td class="firstRow">默认摄像头链接:</td>
	    <td class="secRow">
	    	<s:textfield name="goodsInfo.column_3" title="默认摄像头链接" />
	    	<span class="message_prompt">前面需要有协议内容,类似http://</span>
	    </td>
	  </tr>
	  </tbody>
	</table>
	</div>
	
	<!-- 商品相册 -->
	<div  id="goodsimginfo">
	<table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
	  <tr>
	    <td align="center">
	    <div id="GoodsImgArea">
	    	<div class="showImg">
    		<ul class="showImgList">
    		<s:iterator value="goodsImgs" status="sta">
    			<li id="imgs<s:property value="uuid" />">
    				<span class="leftimg"><img src='<s:property value="url" />' /></span>
    				<span class="rightinfo"><input type='text' id='imgtitle<s:property value="uuid" />' value='<s:property value="title" />' /></span>
    				<span class="rightinfo">
    					<input type="radio" name="index_flag<s:property value="uuid" />" id="index_flag0_<s:property value="uuid" />" value="0" <s:if test="0==index_flag">checked='checked'</s:if> /><label for="index_flag0_<s:property value="uuid" />">普通</label>
						<input type="radio" name="index_flag<s:property value="uuid" />" id="index_flag1_<s:property value="uuid" />" value="1" <s:if test="1==index_flag">checked='checked'</s:if> /><label for="index_flag1_<s:property value="uuid" />">展示</label>
						<input type="radio" name="index_flag<s:property value="uuid" />" id="index_flag2_<s:property value="uuid" />" value="2" <s:if test="2==index_flag">checked='checked'</s:if> /><label for="index_flag2_<s:property value="uuid" />">主图</label>
					</span>
					<span class="rightinfo"><input type="button" value="修改" onclick="mdyImg('<s:property value="uuid" />');" /> <input type="button" value="删除" onclick="delImg('<s:property value="uuid" />');" /></span>
    			</li>
    		</s:iterator>
    		</ul>
	    	</div>
	    	<div class="clear"></div>
	    	<div class="addImgInfo"><span class="notetxt">可以在上传图片框中直接输入外部链接图片地址(http://...)</span></div>
	    	<div id="addImg0" class="addImg">
	    	<a href="javascript:;" onclick="addMore();" title="追加上传文件">[+]</a>
	    	图片描述:<input type="text" name="goodsImgs[0].title" />
	    	上传图片:<input type="text" id="goodsImgsurl0" class="longtext01" name="goodsImgs[0].url" />
	    	<input type="radio" name="goodsImgs[0].index_flag" id="goodsImgs0_index_flag0" value="0"/><label for="goodsImgs0_index_flag0">普通</label>
			<input type="radio" name="goodsImgs[0].index_flag" id="goodsImgs0_index_flag1" value="1"/><label for="goodsImgs0_index_flag1">展示</label>
			<input type="radio" name="goodsImgs[0].index_flag" id="goodsImgs0_index_flag2" value="2"/><label for="goodsImgs0_index_flag2">主图</label>
	    	</div>	    	
	    </div>
	    
	    </td>
	  </tr>
	</table>
	</div>
	
	<table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
	<tr>
	    <td colspan="4" class="buttonarea"><span id="message"><s:property value="message" /></span>
			<s:if test="'add' == viewFlag">
				<s:submit id="add" name="add" value="增加" action="goods_addsave" />
			</s:if>
			<s:elseif test="null != goods && 'mdy' == viewFlag">
				<s:submit id="save" name="save" value="保存" action="goods_save" />
			</s:elseif>
			<input type="button" value="返回" onclick="linkurl('<s:url action="goods_list" namespace="/sysebiz" />');" />
		</td>
    </tr>
	</table>
	
	</div>
</s:form>
	</div>
</div>
</div>
</body>
</html>