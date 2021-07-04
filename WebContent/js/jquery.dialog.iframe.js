/**
 * 使jquery可以支持iframe
 */
var DialogIFrame = function(config){
	var selfobj = this;
	this.defaultConfig = { src : '',
	width : 200,
	height : 400 };
	this.option = {};

	$.extend(this.option, this.defaultConfig, config);

	this.createRamdowConID = function(){
		return "idialog" + (Math.random() + '').substr(2);
	};

	var conid = this.createRamdowConID();
	var iframeid = conid + "iframe";

	this.create = function(){
		var h = '<div id="' + conid + '" title="' + selfobj.option.title + '"><iframe id="' + iframeid + '" scrolling="yes" frameborder="0"></iframe></div>';
		$("body").append(h);
		$("#" + conid).css({ width : selfobj.option.width + "px",
		height : selfobj.option.height + "px",
		overflow : "hidden",
		padding : "0" });
		$("#" + iframeid).css({ width : "100%",
		height : (selfobj.option.height - 55) + "px",
		background : "transparent" });
		$("#" + iframeid).attr("src", selfobj.option.src);

		var cwidth = $("#" + conid).width();
		var chight = $("#" + conid).height();

		$("#" + conid).dialog({ autoOpen : false,
		height : chight,
		width : cwidth,
		modal : true });
	};

	// 打开选择框
	this.open = function(){
		$("#" + conid).dialog("open");
	};

	// 关闭选择框
	this.close = function(){
		$("#" + conid).dialog("close");
	};

	this.selfAction = $.noop;

	this.getConid = function(){
		return conid;
	};
};

var sobj02;
var selectWarevar = function(dcode_id, dname_id,type){
	if(type!=null && type!="" && type==1){
		sobj02 = new DialogIFrame({ src : '/adm/asset_select?objname=sobj02',
			title : "选择资产类型",
			width : 200,
			height : 400 });
			sobj02.selfAction = function(val1, val2){
				$("#" + dcode_id).val(val1);
				$("#" + dname_id).val(val2);
			};
	}else{
		sobj02 = new DialogIFrame({ src : '/sysebiz/ware_select?objname=sobj02',
			title : "选择仓库",
			width : 200,
			height : 400 });
			sobj02.selfAction = function(val1, val2){
				$("#" + dcode_id).val(val1);
				$("#" + dname_id).val(val2);
			};
	}

	sobj02.create();
	sobj02.open();
};

var sobj01;
var selectDept = function(dcode_id, dname_id, isLoad, p_m,b_m,u_pid){
	if(u_pid!=null && u_pid!=""){
		if(u_pid=="sp" || u_pid=="asset"){
			$("#assetusername").val('');
			$("#assetuser").val('');
			if(u_pid=="sp"){
				sobj01 = new DialogIFrame({ src : '/sys/dept_permit_select02?objname=sobj01&special='+u_pid,
					title : "选择部门",
					width : 200,
					height : 400 });
					sobj01.selfAction = function(val1, val2){
						$("#" + dcode_id).val(val1);
						$("#" + dname_id).val(val2);
						if (isLoad) {
							if(b_m==1){
								loadManagers(val1, p_m,'1');
							}else{
								loadManagers(val1, p_m);
							}
							
						}
					};	
			}else{
				sobj01 = new DialogIFrame({ src : '/sys/dept_permit_select02?objname=sobj01&special='+u_pid,
					title : "选择部门",
					width : 200,
					height : 400 });
					sobj01.selfAction = function(val1, val2){
						$("#" + dcode_id).val(val1);
						$("#" + dname_id).val(val2);
						if (isLoad) {
							if(b_m==1){
								loadManagers2(val1, p_m,'1');
							}else{
								loadManagers2(val1, p_m);
							}
							
						}
					};	
			}
			
		}else{
			sobj01 = new DialogIFrame({ src : '/sys/dept_permit_select?objname=sobj01&user_pri='+u_pid,
				title : "选择部门",
				width : 200,
				height : 400 });
				sobj01.selfAction = function(val1, val2){
					$("#" + dcode_id).val(val1);
					$("#" + dname_id).val(val2);
					if (isLoad) {
						if(b_m==1){
							loadManagers(val1, p_m,'1');
						}else{
							loadManagers(val1, p_m);
						}
						
					}
				};	
		}
		
		
	}else{
		sobj01 = new DialogIFrame({ src : '/sys/dept_permit_select?objname=sobj01',
		title : "选择部门",
		width : 200,
		height : 400 });
		sobj01.selfAction = function(val1, val2){
			$("#" + dcode_id).val(val1);
			$("#" + dname_id).val(val2);
			if (isLoad) {
				if (b_m == 1) {
					loadManagers(val1, p_m, '1');
				} else {
					loadManagers(val1, p_m);
				}

			}
		};

	}

	sobj01.create();
	sobj01.open();
};

var loadManagers = function(dept_code, curr_apply_user, b_m){
	var ajax = new Common_Ajax('ajax_member_message');
	ajax.config.action_url = ajax_url;
	ajax.config._success = function(data, textStatus){
		var uc = $("#membermanagerid");
		if (uc.length > 0 && uc.get(0).tagName.toUpperCase() == 'SELECT') {
			uc.clearAllOption();
			uc.addOption("--请选择--", "");
			var l = $(data).length;
			if (l == 1) { // 如果只有一个结果,那么直接选中
				uc.addOption($(data)[0].user_name, $(data)[0].uuid);
				if (b_m == 1) {
					uc.setSelectedValue($(data)[0].uuid);
				} else {}

			} else if (l > 1) {
				$.each(data, function(i, n){
					uc.addOption(n.user_name, n.uuid);
				});
				if (curr_apply_user != '') {
					uc.val(curr_apply_user);
				}
			}
		}
	};
	ajax.addParameter("work", "AutoComplete");
	ajax.addParameter("parameters", "privilege_id=QKJCJ_SYS_AJAXLOAD_USER&dept_code=" + encodeURI(dept_code));
	ajax.sendAjax2();
};


var loadManagers2 = function(dept_code, curr_apply_user, b_m){
	
	var ajax = new Common_Ajax('ajax_member_message');
	ajax.config.action_url = ajax_url;
	ajax.config._success = function(data, textStatus){
		var uc=$("#asset");
		var l = $(data).length;
		uc.innerHTML="";
		 var checkBox="";
			$.each(data, function(i, n){
				checkBox+="<li><input id='"+n.uuid+"' type='checkbox' onclick='sureusers("+n.uuid+");' name='userst' username='"+n.user_name+"' value='"+n.uuid+"'>"+n.user_name+"</li>";
				
			});
		
		uc.html(checkBox);    
		uc.show();
	};
	ajax.addParameter("work", "AutoComplete");
	var d=encodeURI(dept_code);
	var newdept= d.split(",");   
	var ndept="";
	for(var i=0;i<newdept.length;i++){
		ndept+="'"+newdept[i]+"',";
	}
	ajax.addParameter("parameters", "privilege_id=QKJCJ_SYS_AJAXLOAD_USER&dept_codeds=" + ndept.substring(0, ndept.length-1));
	ajax.sendAjax2();
};

