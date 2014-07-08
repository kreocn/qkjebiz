var start_no_spinner;
var end_no_spinner;
$(function() {
	start_no_spinner = $("#AddForm :input[name='start_no']").spinner({ min : 1, max : 2500, step : 5 });
	end_no_spinner = $("#AddForm :input[name='end_no']").spinner({ min : 1, max : 2500, step : 5 });
});

// orderCellars
var submitIndex = 0;
var submitNum = 0;
var addCellarSubmit = function() {
	var submit_order_goods_id = $("#AddForm :input[name='order_goods_id']").val();
	var submit_start_no = start_no_spinner.spinner("value");
	var submit_end_no = end_no_spinner.spinner("value");
	var submit_cellar_num = $("#AddForm :input[name='cellar_num']").val();
	var submit_cellar_camera = $("#AddForm :input[name='cellar_camera']").val();
	var submit_ware_id = $("#" + con_id + submit_order_goods_id + " .cellar_goods_ware_value").attr("data");
	var submit_goods_id = $("#" + con_id + submit_order_goods_id + " .cellar_goods_name_value").attr("data");

	if (submit_start_no == null && submit_end_no != null) {
		submit_start_no = submit_end_no;
	} else if (submit_start_no != null && submit_end_no == null) {
		submit_end_no = submit_start_no;
	} else if (submit_start_no == null && submit_end_no == null) {
		alert('你没有填写任何藏酒编号!');
		return;
	} else if (submit_start_no != null && submit_end_no != null && submit_start_no > submit_end_no) {
		alert('藏酒结束编号必须大于开始编号!');
		return;
	}

	var goods_num = $("#" + con_id + submit_order_goods_id + " .cellar_goods_num_value").text();
	var goods_pnum = $("#" + con_id + submit_order_goods_id + " .cellar_goods_pnum_value").text();
	if ((goods_num - goods_pnum) < (submit_end_no - submit_start_no + 1)) {
		alert("配货超过数量!" + (goods_num - goods_pnum) + "<" + (submit_end_no - submit_start_no + 1));
		return;
	}

	var thtml = "";

	for (i = submit_start_no; i < submit_end_no + 1; i++) {
		if (!checkPnum(submit_order_goods_id, i)) {
			alert("所添加的编号有重复:(" + submit_order_goods_id + "-" + i + "),点击跳过添加此数据!");
			continue;
		}
		thtml += '<li id="cellarli_submit' + submitIndex + '" class="submit"><span class="cellar_no">' + i
				+ '</span><span class="cellar_stock">' + submit_cellar_num + '/' + submit_cellar_num
				+ '</span><span class="cellar_del_submit" onclick="delSubmitCellar(\'' + submitIndex + '\')">X</span>';
		thtml += '<input type="hidden" name="orderCellars[' + submitIndex + '].order_goods_id" value="'
				+ submit_order_goods_id + '" />';
		thtml += '<input type="hidden" name="orderCellars[' + submitIndex + '].cellar_no" value="' + i + '" />';
		thtml += '<input type="hidden" name="orderCellars[' + submitIndex + '].num" value="' + submit_cellar_num
				+ '" />';
		thtml += '<input type="hidden" name="orderCellars[' + submitIndex + '].stock" value="' + submit_cellar_num
				+ '" />';
		thtml += '<input type="hidden" name="orderCellars[' + submitIndex + '].camera" value="' + submit_cellar_camera
				+ '" />';
		thtml += '<input type="hidden" name="orderCellars[' + submitIndex + '].ware_id" value="' + submit_ware_id
				+ '" />';
		thtml += '<input type="hidden" name="orderCellars[' + submitIndex + '].goods_id" value="' + submit_goods_id
				+ '" />';
		thtml += '</li>';
		submitIndex++;
		submitNum++;
		setPnum(submit_order_goods_id, i);
	}

	$("#" + con_id + submit_order_goods_id + " ul").append(thtml);

	setPnumText();
};

// 添加时,检查是否当页重复 false有重复 true无重复
var checkPnum = function(p_order_goods_id, p_cellar_no) {
	if (pnums[p_order_goods_id] && pnums[p_order_goods_id].indexOf('|' + p_cellar_no + "|,") > -1) {
		return false;
	} else {
		return true;
	}
};

var delSubmitCellar = function(submit_index) {
	var order_goods_id = $(
			"#cellarli_submit" + submit_index + " input:hidden[name='orderCellars[" + submit_index
					+ "].order_goods_id']").val();
	var cellar_no = $(
			"#cellarli_submit" + submit_index + " input:hidden[name='orderCellars[" + submit_index + "].cellar_no']")
			.val();
	// cellar_no
	submitNum--;
	pnum[order_goods_id] -= 1;
	pnums[order_goods_id] = pnums[order_goods_id].replace('|' + cellar_no + "|,", "");
	setPnumText();
	$("#cellarli_submit" + submit_index).remove();
};

var submitForm = function() {
	if (submitNum == 0) {
		alert("没有可提交的内容!");
		return;
	}

	if (isOp("确定要提交表单吗?")) {
		$("#add_form").submit();
	}
};

var setError_message = function(msg) {
	// error_massage
	var error_msg = msg;
	if (error_msg == '') {
		$("#error_massage").hide();
	} else {
		$("#error_massage").text("您有以下项目没有添加成功(区域-添加号):" + toHTML.un(error_msg));
		$("#error_massage").show();
	}
};