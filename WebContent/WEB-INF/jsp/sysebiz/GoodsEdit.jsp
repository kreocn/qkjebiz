<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>藏酒管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<script type="text/javascript" src="<s:url value="/js/common_lite.js" />"></script>
<script type="text/javascript" src="/ckframe/include/widget.js"></script>
</head>
<style type="text/css">
#itableformid{font-size:14px; font-family:"微软雅黑";}
#itableformid ul li{font-weight:bold;}
.danwei {text-align: center;}
.filearea{margin-left:5px; width:90px;}
.label_ltit{width:115px;}
.addImg{margin:5px 0;}
.addImgInfo{padding:5px 0;}
.yswd{display:inline-block; width:30px;}
.showImg ul.showImgList {list-style: none;padding: 0;margin: 0;}
ul.showImgList li {width:170px;height:250px;padding: 10px;margin: 17px;float: left;border: #999 solid 1px;}
ul.showImgList .leftimg {border: #999 solid 1px;padding: 1px;display: inline-block;}
ul.showImgList .leftimg img {width: 160px; height: 160px;border: none; overflow:hidden;}
ul.showImgList .rightinfo {display: block;clear: both;margin-top: 5px;}
</style>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<div class="dq_step">
		${path}
		<span class="opb lb op-area"><a href="<s:url namespace="/sysebiz" action="goods_list"><s:param name="viewFlag">relist</s:param></s:url>">商品列表</a></span>
	</div>
	<s:form name="form1" namespace="/sysebiz" onsubmit="return validator(this);" method="post" theme="simple" cssClass="validForm">
		<div class="label_con">
			<fieldset class="clear">
				<legend>通用信息</legend>
				<div class="label_main">
					<s:if test="'add' != viewFlag">	
						<div class="label_hang">
					       <div class="label_ltit">编号:</div>
					       <div class="label_rwben">${goods.uuid}<s:hidden name="goods.uuid" id="goods.uuid"  title="编号"/></div>
						</div>
					</s:if>
					<div class="label_hang">
				       <div class="label_ltit">商品货号:</div>
				       <div class="label_rwben"><s:textfield id="goods.goods_code" name="goods.goods_code" title="商品货号" /></div>
					</div>
					<div class="label_hang">
				       <div class="label_ltit">商品名称:</div>
				       <div class="label_rwben"><s:textfield id="goods.goods_name" name="goods.goods_name" title="商品名称"  cssClass="validate[required]"/></div>
					</div>
					<div class="label_hang">
				       <div class="label_ltit">产品售价:</div>
				       <div class="label_rwben"><s:textfield id="goods.goods_price" name="goods.goods_price" title="产品售价"  cssClass="validate[required,custom[number]]"/></div>
					</div>
					<div class="label_hang">
				       <div class="label_ltit">商品规格:</div>
				       <div class="label_rwbenx">
				       		<s:textfield id="goods.goods_spec" name="goods.goods_spec" title="商品规格"  cssClass="validate[required]"/>
				       		<s:textfield id="goods.goods_spec_unit" name="goods.goods_spec_unit" title="商品规格单位"  cssClass="danwei validate[required]" style="width:35px; text-indent:inherit;"/>
				       </div>
					</div>
					<div class="label_hang">
				       <div class="label_ltit">商品库存:</div>
				       <div class="label_rwbenx">
				       		<s:textfield id="goods.goods_num" name="goods.goods_num" title="商品库存"  cssClass="validate[required]"/>
				       		<s:textfield id="goods.goods_unit" name="goods.goods_unit" title="商品单位"  cssClass="danwei validate[required]" style="width:35px; text-indent:inherit;"/>
				       </div>
					</div>
					<div class="label_hang">
				       <div class="label_ltit">产品小图:</div>
				       <div class="label_rwbenx">
				       		<s:textfield id="goods_small_img" name="goods.small_img" title="产品小图"  cssClass="validate[required]" style="min-width:193px;"/>
				       		<span class="message_prompt">图片规格100x100</span>
				       		<!--<img src="${goods.small_img}" />-->
				       </div>
					</div>
					<div class="label_hang">
				       <div class="label_ltit">产品大图:</div>
				       <div class="label_rwbenx">
				       		<s:textfield id="goods_big_img" name="goods.big_img" title="产品大图" style="min-width:193px;"/>
				       		<!--<img src="${goods.big_img}" />-->
				       </div>
					</div>
					<s:if test="'add' != viewFlag">
						<div class="label_hang clear">
					       <div class="label_ltit">添加人:</div>
					       <div class="label_rwbenx">${goods.add_user_name}<s:hidden name="goods.add_user" /></div>
						</div>
						<div class="label_hang">
					       <div class="label_ltit">添加时间:</div>
					       <div class="label_rwbenx"><s:date name="goods.add_time" format="yyyy-MM-dd HH:mm:ss" /></div>
						</div>
						<div class="label_hang">
					       <div class="label_ltit">修改人:</div>
					       <div class="label_rwbenx">${goods.lm_user_name}<s:hidden name="goods.lm_user" /></div>
						</div>
						<div class="label_hang">
					       <div class="label_ltit">修改时间:</div>
					       <div class="label_rwbenx"><s:date name="goods.lm_time" format="yyyy-MM-dd HH:mm:ss" /></div>
						</div>
					</s:if>
				</div>
			</fieldset>
			<div style="height:10px;"></div>
			<fieldset class="clear">
				<legend>详细描述</legend>
				<div class="label_main">
					<div class="note_area clear">
						<s:textarea name="goods.goods_description"  cssClass="xheditorArea validate[maxSize[65535]]" id="goodsdescriptionid" />
					</div>
				</div>
			</fieldset>
			<div style="height:10px;"></div>
			<fieldset class="clear">
				<legend>商品类型</legend>
				<div class="label_main" id="goodstypeinfo">
					<div class="label_hang">
				       <div class="label_ltit">商品类型:</div>
				       <div class="label_rwbenx">
				       		<s:select title="商品类型" name="goods.goods_type" list="#{1:'藏酒'}"  headerKey=""	headerValue="--请选择--" cssClass="validate[required]"/>
				       </div>
					</div>
					<div id="goodsInfocolumns" style="display: none;">
						<div class="label_hang">
							<div class="label_ltit">所在仓库:</div>
					       	<div class="label_rwbenx">
					       		<s:select name="goodsInfo.column_1" list="column_1list" headerKey="" headerValue="--请选择--" listKey="key" listValue="value" cssClass="validate[required]"/>
						    	<s:hidden name="goodsInfo.goods_id" value="%{goods.uuid}" />
						    	<s:hidden name="goodsInfo.uuid" />
					       	</div>
						</div>
						<div class="label_hang clear">
							<div class="label_ltit">酒坛位置编号前缀:</div>
					       	<div class="label_rwbenx">
					       		<s:if test="'add' == viewFlag">
									<s:textfield name="goodsInfo.column_2" title="酒坛位置编号前缀" cssClass="validate[required]" />
									<span class="message_prompt">添加藏酒时,自动生成藏酒编号,此项目不能修改,请慎重填写!</span>
								</s:if>
								<s:elseif test="null != goods && 'mdy' == viewFlag">
									${goodsInfo.column_2}<s:hidden name="goodsInfo.column_2" />
								</s:elseif>
					       	</div>
						</div>
						<div class="label_hang clear">
							<div class="label_ltit">默认摄像头链接:</div>
					       	<div class="label_rwbenx">
					       		<s:textfield name="goodsInfo.column_3" title="默认摄像头链接" />
	    						<span class="message_prompt">前面需要有协议内容,类似http://</span>
					       	</div>
					    </div>
					</div>
				</div>
			</fieldset>
			<div style="height:10px;"></div>
			<fieldset class="clear">
				<legend>商品相册</legend>
				<div class="label_main">
					<table class="ilisttable" width="100%" border="0" cellspacing="0" cellpadding="0" >
					  	<tr>
						    <td align="center">
							    <div id="GoodsImgArea">
							    	<div class="showImg op-area">
							    		<ul class="showImgList">
							    		<s:iterator value="goodsImgs" status="sta">
							    			<li id="imgs<s:property value="uuid" />">
							    				<span class="leftimg"><img src='<s:property value="url" />' /></span>
							    				<span class="rightinfo">
							    					<input type="radio" name="index_flag<s:property value="uuid" />" id="index_flag0_<s:property value="uuid" />" value="0" <s:if test="0==index_flag">checked='checked'</s:if> /><label for="index_flag0_<s:property value="uuid" />">普通</label>
													<input type="radio" name="index_flag<s:property value="uuid" />" id="index_flag1_<s:property value="uuid" />" value="1" <s:if test="1==index_flag">checked='checked'</s:if> /><label for="index_flag1_<s:property value="uuid" />">展示</label>
													<input type="radio" name="index_flag<s:property value="uuid" />" id="index_flag2_<s:property value="uuid" />" value="2" <s:if test="2==index_flag">checked='checked'</s:if> /><label for="index_flag2_<s:property value="uuid" />">主图</label>
												</span>
												<span class="rightinfo"><input type="button" value="修改" onclick="mdyImg('<s:property value="uuid" />');" class="input-blue" /> <input type="button" value="删除" onclick="delImg('<s:property value="uuid" />');" class="input-red"/></span>
							    			</li>
							    		</s:iterator>
							    		</ul>
							    	</div>
							    	<div class="clear"></div>
							    	<div class="addImgInfo"><span class="notetxt">可以在上传图片框中直接输入外部链接图片地址(http://...)</span></div>
							    	<div id="addImg0" class="addImg">
								    	<a href="javascript:;" onclick="addMore();" title="追加上传文件" class="yswd">[+]</a>
								    	图片描述：<input type="text" name="goodsImgs[0].title" style="width:200px;"/>
								    	上传图片：<input type="text" id="goodsImgsurl0" class="longtext01" name="goodsImgs[0].url" style="width:200px;"/>
								    	<input type="radio" name="goodsImgs[0].index_flag" id="goodsImgs0_index_flag0" value="0"/><label for="goodsImgs0_index_flag0">普通</label>
										<input type="radio" name="goodsImgs[0].index_flag" id="goodsImgs0_index_flag1" value="1"/><label for="goodsImgs0_index_flag1">展示</label>
										<input type="radio" name="goodsImgs[0].index_flag" id="goodsImgs0_index_flag2" value="2"/><label for="goodsImgs0_index_flag2">主图</label>
							    	</div>	    	
							    </div>				    
						    	</td>
					  		</tr>
						</table>
				</div>
			</fieldset>
			<div style="height:10px;"></div>
			<div class="label_hang">
		       <div class="label_ltit" style="width:129px;">相关操作:</div>
		       <div class="label_rwbenx op-area">
		       		<s:if test="'add' == viewFlag">
						<s:submit id="add" name="add" value="增加" action="goods_addsave" cssClass="input-blue"/>
					</s:if>
					<s:elseif test="null != goods && 'mdy' == viewFlag">
						<s:submit id="save" name="save" value="保存" action="goods_save" cssClass="input-blue"/>
					</s:elseif>
					<input type="button" class="input-gray" value="返回" onclick="linkurl('<s:url action="goods_list" namespace="/sysebiz" />');"/>
		       		<span id="message"><s:property value="message" /></span>
		       </div>
			</div>
		</div>
	</s:form>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
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
	createHtmlEditor("#goodsdescriptionid");
	
	BrowseServer(0);
	//wb_smallImg = new widget_button({ inputid :"goods_small_img", objname : "wb_smallImg" });
	//wb_smallImg.init(); 
	//wb_bigImg = new widget_button({ inputid :"goods_big_img", objname : "wb_bigImg" });
	//wb_bigImg.init(); 
	$.fn.xhuploadinit();
	$("#goods_small_img").xhupload();
	$("#goods_big_img").xhupload();
});

function BrowseServer(idindex) {
	$("#goodsImgsurl"+idindex).xhupload();
}

var fileindex = 1;
function addMore() {
	var s = '<div id="addImg'+fileindex+'" class="addImg">';
	s+= '<a href="javascript:;" onclick="rmAdd('+fileindex+');" class="yswd">[-]</a> ';
	s+= '图片描述：<input type="text" name="goodsImgs['+fileindex+'].title" style="width:200px;"/> ';
	s+= '上传图片：<input type="text" id="goodsImgsurl'+fileindex+'" class="longtext01" name="goodsImgs['+fileindex+'].url" style="width:200px;"/> ';
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
</body>
</html>