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