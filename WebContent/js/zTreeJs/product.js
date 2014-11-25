$(document).ready(function(){
	$.fn.zTree.init($("#treeDemo"), setting, zNodes);
});
/*添加酒品---分类*/
var setting = {
    view: {
        dblClickExpand: false
    },
    data: {
        simpleData: {
            enable: true
        }
    },
    callback: {
        beforeClick: beforeClick,
        onClick: onClick
    }
};
var zNodes =[
      {id:1, pId:0, name:"天佑德", open:false},
      {id:11, pId:1, name:"德天下天佑德"},
      {id:12, pId:1, name:"天之德天佑德"},
      {id:13, pId:1, name:"国之德天佑德"},
      {id:14, pId:1, name:"家之德天佑德"},
      {id:2, pId:0, name:"八大作坊", open:false},
      {id:21, pId:2, name:"八大作坊3000青稞酒"},
      {id:22, pId:2, name:"八大作坊2000青稞酒"},
      {id:23, pId:2, name:"八大作坊1500青稞酒"},
      {id:24, pId:2, name:"八大作坊1200青稞酒"},
      {id:3, pId:0, name:"高原海拔", open:false},
      {id:31, pId:3, name:"海拔2600天佑德"},
      {id:32, pId:3, name:"海拔2800天佑德"},
      {id:33, pId:3, name:"海拔3000天佑德"},
      {id:38, pId:3, name:"海拔4600天佑德(4盒装)"}
   ];
function beforeClick(treeId, treeNode) {
      var check = (treeNode && !treeNode.isParent);
      if (!check) alert("只能选择产品名称...");
      return check;
}
function onClick(e, treeId, treeNode) {
      var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
      nodes = zTree.getSelectedNodes(),
      v = "";
      nodes.sort(function compare(a,b){return a.id-b.id;});
      for (var i=0, l=nodes.length; i<l; i++) {
          v += nodes[i].name + ",";
      }
      if (v.length > 0 ) v = v.substring(0, v.length-1);
      var cityObj = $("#citySel");
      cityObj.attr("value", v);
	  hideMenu();
}
function showMenu() {
      var cityObj = $("#citySel");
      var cityOffset = $("#citySel").offset();
      $("#menuContent").slideDown("fast");
}
function hideMenu() {
      $("#menuContent").fadeOut("fast");
}