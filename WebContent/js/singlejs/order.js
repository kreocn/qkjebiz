var c_data; // 保存当前用户联系人的所有信息

function loadAddress(memberid, initflag) {
	var ajax = new Common_Ajax('ajax_member_message');
	ajax.config.action_url = ajax_url_action;
	ajax.config._success = function(data, textStatus) {
		c_data = data;
		createSelectRadio(data, initflag);
	};
	ajax.addParameter("privilege_id", "QKJCJ_SYSEBIZ_AJAXLOAD_ADDRESS");
	ajax.addParameter("parameters", "member_id=" + memberid);
	ajax.sendAjax();
}

function createSelectRadio(p_data, initflag) {
	var sid = $("#orderconsigneid");
	var sh = "";
	for ( var i = 0; i < p_data.length; i++) {
		sh += '<div class="orderconsigneshow">';
		sh += '<input id="orderconsigneid' + p_data[i].uuid + '" name="order.consigne" type="radio" value="'
				+ p_data[i].uuid + '" ';
		sh += ' onclick="setConsignebyIndex(' + i + ')" /> <label for="orderconsigneid' + p_data[i].uuid + '">';
		sh += p_data[i].province + ' ' + p_data[i].city + ' ' + p_data[i].area + ' ' + p_data[i].street + '('
				+ p_data[i].post + ') ';
		sh += p_data[i].con_name + ' 收 ' + p_data[i].mobile + '</label>';
		sh += '</div>';

		if (p_data[i].defaultaddress == 1 && initflag) {
			setConsigne(p_data[i]);
		}
	}
	sid.html(sh);
}

function setConsigne(obj) {
	sa.init(toHTML.un(obj.province), toHTML.un(obj.city), toHTML.un(obj.area));
	$(":input[name='order.con_post']").val(obj.post);
	$(":input[name='order.con_street']").val(obj.street);
	$(":input[name='order.con_name']").val(obj.con_name);
	$(":input[name='order.con_mobile']").val(obj.mobile);
}

function setConsignebyIndex(idx) {
	setConsigne(c_data[idx]);
}

function showMoreAddress() {
	if ($("#orderconsigneid_p").is(":visible")) {
		$("#orderconsigneid_p").hide();
		$("#moreaddresstext").text("显示更多地址");
	} else {
		$("#orderconsigneid_p").show();
		$("#moreaddresstext").text("隐藏地址");
	}
}