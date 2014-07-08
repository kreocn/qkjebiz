/**
 * 为div.js创建简单实例
 */

/*
 * 定义默认数据
 */
var default_width = 500;
var default_height = 280;
var default_title_html = "";
var default_bottom_html = "";
var default_use_height = 0;

var md;
var __html_temp;
var obj;

function createModelDivByObj(div_id, width, height, title_html, bottom_html) {
	// 设置原始数据
	width = width == null || width == '' ? default_width : width;
	height = height == null || height == '' ? default_height : height;
	title_html = title_html == null || title_html == '' ? default_title_html : title_html;
	bottom_html = bottom_html == null || bottom_html == '' ? default_bottom_html : bottom_html;
	// 得到obj
	obj = document.getElementById(div_id);
	// 读取原div内容
	__html_temp = obj.innerHTML;
	// 清空原div数据,避免form_name重复
	obj.innerHTML = "";

	md = new modelDiv();
	md.setTitle_HTML(title_html);
	md.setBottom_HTML(bottom_html);
	md.createModelDivByContent(width, height, __html_temp);
}

// use_height为title_html和bottom_html的高度之和
function createModelDivByUrl(url, width, height, title_html, bottom_html, use_height) {
	// 设置原始数据
	width = width == null || width == '' ? default_width : width;
	height = height == null || height == '' ? default_height : height;
	title_html = title_html == null || title_html == '' ? default_title_html : title_html;
	bottom_html = bottom_html == null || bottom_html == '' ? default_bottom_html : bottom_html;
	use_height = use_height == null || use_height == '' ? default_use_height : use_height;

	md = new modelDiv();
	md.setTitle_HTML(title_html);
	md.setBottom_HTML(bottom_html);
	md.createModelDivByUrl(width, height, url, use_height);
	
	if (window.ActiveXObject){
		setTimeout("document.frames('modeldiv_iframe_name').location.reload()",300);
	}
}

function closeModelDiv() {
	// 还原obj
	if (obj) {
		obj.innerHTML = __html_temp;
	}
	md.dropModelDiv();
}

var obj1, obj2;

// 选择客户(全部):/erp/crm/customer_select_all
// 选择部门(全部):/erp/sys/dept_select_all
// 选择部门(限制):/erp/sys/dept_select_limit
function createSelectDiv(p_obj1, p_obj2, p_url, width, height) {
	obj1 = p_obj1;
	obj2 = p_obj2;
	createModelDivByUrl(p_url, width == null ? 220 : width, height == null ? 400 : height);
}

function closeSelectDiv(p_obj1_value, p_obj2_value) {
	// alert(p_obj1_value + ":" + p_obj2_value);
	if ($(obj1)) {
		if ($(obj1).val)
			$(obj1).val(p_obj1_value);
		else
			$(obj1).html(p_obj1_value);
	} else
		obj1.innerHTML = p_obj1_value;
	if ($(obj2)) {
		if (obj2.val)
			obj2.val(p_obj2_value);
		else
			$(obj2).html(p_obj2_value);
	} else
		obj2.innerHTML = p_obj2_value;
	closeModelDiv();	
	if (typeof close_complete == "function") {
		close_complete();
	}
}

/**
 * 创建选择部门的DIV
 * 
 * @param dept_code_obj
 *            需写入code的对象
 * @param dept_name_obj
 *            需写入name的对象
 */
var dept_code_obj;
var dept_name_obj;
function createDeptAllSelectDiv(p_dept_code_obj, p_dept_name_obj) {
	dept_code_obj = p_dept_code_obj;
	dept_name_obj = p_dept_name_obj;
	createModelDivByUrl('/qkjebiz/sys/dept_select_all', 220, 400);
}

function closeDeptAllSelectDiv(dept_code_value, dept_name_value) {
	dept_code_obj.value = dept_code_value;
	dept_name_obj.value = dept_name_value;
	closeModelDiv();
}

function createDeptLimitSelectDiv(p_dept_code_obj, p_dept_name_obj) {
	dept_code_obj = p_dept_code_obj;
	dept_name_obj = p_dept_name_obj;
	createModelDivByUrl('/qkjebiz/sys/dept_select_limit', 220, 400);
}

function closeDeptLimitSelectDiv(dept_code_value, dept_name_value) {
	dept_code_obj.value = dept_code_value;
	dept_name_obj.value = dept_name_value;
	closeModelDiv();
}