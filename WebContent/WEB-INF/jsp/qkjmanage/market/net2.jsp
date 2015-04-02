<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>营销网络-北京互助天佑德青稞酒销售有限公司欢迎您！</title>
<meta name="description" content="青稞,青稞酒,白酒,互助,天佑德,八大作坊,海拔" />
<meta name="keywords" content="青稞,青稞酒,白酒,互助,天佑德,八大作坊,海拔" />
<meta name="google-site-verification" content="" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<script src="../js/cn_head.js" type="text/javascript"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.5&ak=397d27f02c1751010c9b08e3dc625cd3"></script>
<style type="text/css">
</style>
<body>
<div id="netmain">
<div style="clear:both;">
<input type="text" id="serach" name="search" />
<input type="button" value="搜索" onClick="searchmap();" />
</div>
<div id="r-result" style="float:right; width:200px;"></div>
		<div id="allmap" style="width: 950px;height: 580px;"></div>
	</div>
	
<script type="text/javascript">
var map = new BMap.Map("allmap");            // 创建Map实例
var point = new BMap.Point(116.404, 39.915);    // 创建点坐标
map.centerAndZoom(point,12);                     // 初始化地图,设置中心点坐标和地图级别。
map.enableScrollWheelZoom();                            //启用滚轮放大缩小

//添加缩放尺
map.addControl(new BMap.NavigationControl());  //添加默认缩放平移控件
map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_RIGHT, type: BMAP_NAVIGATION_CONTROL_SMALL}));  //右上角，仅包含平移和缩放按钮
map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_BOTTOM_LEFT, type: BMAP_NAVIGATION_CONTROL_PAN}));  //左下角，仅包含平移按钮
map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_BOTTOM_RIGHT, type: BMAP_NAVIGATION_CONTROL_ZOOM}));  //右下角，仅包含缩放按钮

//setTimeout(function(){
//    map.setCenter("北京");   //设置地图中心点。center除了可以为坐标点以外，还支持城市名
//    map.setZoom(12);  //将视图切换到指定的缩放等级，中心点坐标不变    
//}, 1500);
var local = new BMap.LocalSearch("全国", {
  renderOptions: {
    map: map,
    panel : "r-result",
    autoViewport: true,
    selectFirstResult: false
  }
});

var geolocation = new BMap.Geolocation();
geolocation.getCurrentPosition(function(r){
    if(this.getStatus() == BMAP_STATUS_SUCCESS){
        //var mk = new BMap.Marker(r.point);
        //map.addOverlay(mk);
        map.panTo(r.point);
       // alert('您的位置：'+r.point.lng+','+r.point.lat);
    }
    else {
        //alert('failed'+this.getStatus());
    }        
})

function searchmap() {
	var v = document.getElementById("serach").value;
	if(v!=null && v!='') {
	  local.search(v);
	}
}

function showInfo(e){
 if(confirm("确定获取："+e.point.lng+","+e.point.lat+"此坐标？")){
	location.href="/qkjmanage/market_saveay?market.uuid="+${market.uuid}+"& market.abs="+e.point.lng+"& market.yaxis="+e.point.lat;
 }else{
     return false;
 }
}

map.addEventListener("ondblclick", showInfo);
</script>
</body>
</html>