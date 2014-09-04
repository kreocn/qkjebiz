// JavaScript Document
$(document).ready(function(){
	//点击tr 选中tr
	$(".tab_warp tr").click(function(){
		$(this).toggleClass("trbg");
		if($(this).hasClass("trbg")){
			$(this).find("[type='checkbox']").attr("checked",true);
		}else{
			$(this).find("[type='checkbox']").attr("checked",false);
		}
	});
	//table隔行变色and鼠标经过样式
	$(".tab_warp tr:even").addClass("even");  
    $(".tab_warp tr:odd").addClass("odd");
	$(".tab_warp tr").mouseover(function(){
		$(this).addClass("trhover");
	}).mouseout(function(){
		$(this).removeClass("trhover");
	});
	//查看详情
	$(".detail").click(function(){ 
		var t=$(this).index('.detail');
		var le=$('tr:eq(0)').children().length;
		var str='';
		for(var i=0; i<le-2; i++){
			var n=i+1; 
			var th=$('tr:eq(0) th:eq('+n+')').text(); 
			var m=t+1;
			if(i==le-3){
				var td=$('tr:eq('+m+') td:eq('+n+')').html();	
			}else{
				var td=$('tr:eq('+m+') td:eq('+n+')').text();	
			}
			str+='<tr><td align="right" width="40%"><b>'+th+'：</b></td><td width="60%">'+td+'</td></tr>';
		}
		document.getElementById('innertabel').innerHTML=str;
	});
})