var pnum = new Object();
var pnums = new Object();
var con_id = "cellar_list_exists";
var thtml = "";
// var cellars = new Object();
var addOrderGoodses = function(p_order_goods_id, p_goods_name, p_ware_id, p_ware_name, p_order_num) {
	var list_con_id = con_id + p_order_goods_id;
	thtml = "<div  id='" + list_con_id + "' class='cellar_list'>";
	thtml += '<div class="cellar_title">';
	thtml += '<span class="cellar_goods_area">区域:</span>';
	thtml += '<span class="cellar_area_name">' + p_order_goods_id + '</span> | ';
	thtml += '<span class="cellar_goods_name">商品名称:</span>';
	thtml += '<span class="cellar_goods_name_value">' + p_goods_name + '</span> | ';
	thtml += '<span class="cellar_goods_ware">所在仓库:</span>';
	thtml += '<span class="cellar_goods_ware_value" data="' + p_ware_id + '">' + p_ware_name + '</span> | ';
	thtml += '<span class="cellar_goods_num">订单数量:</span>';
	thtml += '<span class="cellar_goods_num_value">' + p_order_num + '</span> | ';
	thtml += '<span class="cellar_goods_pnum">已配货:</span>';
	thtml += '<span class="cellar_goods_pnum_value">0</span>';
	thtml += '</div>';
	thtml += '<ul></ul>';
	thtml += '</div>';
	$("#" + con_id).append(thtml);
};

var addCellar = function(p_uuid, p_order_goods_id, p_cellar_no, p_num, p_stock, p_camera, p_order_id, p_goods_id,
		p_goods_name, p_order_num, p_ware_id, p_ware_name) {
	var list_con_id = con_id + p_order_goods_id;
	// 如果不存在,就创建,专门为列出用户藏酒和设定,配货时,使用addOrderGoodses来提前设定
	if($("#" + list_con_id).length==0) {
		thtml = "<div  id='" + list_con_id + "' class='cellar_list'>";
		thtml += '<div class="cellar_title">';
		thtml += '<span class="cellar_goods_area">区域:</span>';
		thtml += '<span class="cellar_area_name">' + p_order_goods_id + '</span> | ';
		thtml += '<span class="cellar_goods_name">商品名称:</span>';
		thtml += '<span class="cellar_goods_name_value">' + p_goods_name + '</span> | ';
		thtml += '<span class="cellar_goods_ware">所在仓库:</span>';
		thtml += '<span class="cellar_goods_ware_value" data="' + p_ware_id + '">' + p_ware_name + '</span> | ';
		thtml += '<span class="cellar_goods_num">订单数量:</span>';
		thtml += '<span class="cellar_goods_num_value">' + p_order_num + '</span> | ';
		thtml += '<span class="cellar_goods_pnum">已配货:</span>';
		thtml += '<span class="cellar_goods_pnum_value">0</span>';
		thtml += '</div>';
		thtml += '<ul></ul>';
		thtml += '</div>';
		$("#" + con_id).append(thtml);
	}
	
	thtml = '<li id="cellarli_' + p_uuid + '" data="' + p_uuid + '"><span class="cellar_no">' + p_cellar_no
			+ '</span><span class="cellar_stock">' + p_stock + '/' + p_num
			+ '</span><span class="cellar_del" onclick="delCellar(\'' + p_uuid + '\')">X</span></li>';
	$("#" + list_con_id + " ul").append(thtml);

	setPnum(p_order_goods_id, p_cellar_no);
};

// 设置已配货的数量和具体配货ID
var setPnum = function(p_order_goods_id, p_cellar_no) {
	if (pnum[p_order_goods_id]) {
		pnum[p_order_goods_id] += 1;
		pnums[p_order_goods_id] += ('|' + p_cellar_no + "|,");
	} else {
		pnum[p_order_goods_id] = 1;
		pnums[p_order_goods_id] = '|' + p_cellar_no + "|,";
	}
};

// 显示已配货的数量
var setPnumText = function() {
	$.each(pnum, function(i, n) {
		// alert( "Item #" + i + ": " + n );
		$("#" + con_id + i + " .cellar_goods_pnum_value").text(n);
	});
};

var delCellar = function(cellar_li_uuid) {
	if (!isOp("确定要删除此项吗?\n此操作不可恢复!")) {
		return;
	}
	var cellar_uuid = $("#" + cellar_li_uuid).attr("data");
	var ajax = new Common_Ajax();
	ajax.config.action_url = ajax_current_url;
	ajax.config._success = function(data, textStatus) {
		if (data == 1) {
			location.reload();
		} else {
			alert("删除失败,请联系管理员!");
		}
		$("#message").empty();
	};
	ajax.addParameter("privilege_id", "QKJCJ_SYSEBIZ_ORDERCELLAR_DEL");
	ajax.addParameter("work", "update");
	ajax.addParameter("parameters", "uuid=" + cellar_uuid);
	ajax.sendAjax();
};

var addMouseEvent = function() {
	$(".cellar_list li").live({ mouseenter : function() {
		$(this).addClass("active");
	}, mouseleave : function() {
		$(this).removeClass("active");
	} });
	$(".cellar_list li").bind({ click : function() {
		delCellar($(this).attr("id"));
	} });
};
