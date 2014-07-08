/**
 * 需要jquery,测试版本为jquery1.8, 为struts2中的optiontransferselect增加事件和提交值BUG的解决
 */
var addTransferSelect = function(leftName, rightName) {
	var $left = $("select[name='" + leftName + "']:eq(0)");
	var $right = $("select[name='" + rightName + "']:eq(0)");

	$left.dblclick(function() {
		moveSelectedOptions($left[0], $right[0], false, '', '');
	});

	$right.dblclick(function() {
		moveSelectedOptions($right[0], $left[0], false, '', '');
	});

	var $form = $right.parents("form:eq(0)");
	$form.submit(function() {
		// 选中所有右边的选项(解决后台获得值的问题)
		selectAllOptionsExceptSome($right[0], 'key', '');
		// alert("阻止提交!");
		return true;
	});
};