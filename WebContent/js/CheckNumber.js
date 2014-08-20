function checkInputJQT(t) {

	var inputStr = t.value;
	// 如果第一位是负号，第二位禁止输入0
	if (inputStr == "-") {
		if (window.event.keyCode == 48)
			window.event.keyCode = 0;
	}

	// if(this.edtObj.isRectInteger=='true'){
	if (window.event.keyCode == 45)
		window.event.keyCode = 0;
	// }
	// 如果第一位输入负号，其他位不允许输入负号“-”
	if (inputStr.indexOf("-") > -1 || inputStr.length > 1) {
		if (window.event.keyCode == 45)
			window.event.keyCode = 0;
	}

	for ( var i = 0; i < inputStr.length; i++) {
		var oneChar = inputStr.charAt(i)
		// 第一位可以是“-”
		if (i == 0 && oneChar == "-") {
			continue;
		}

		if (oneChar < "0" || oneChar > "9") {
			event.returnValue = false;
			return false;
		}

	}
	return true;

}

function checkInput2(t) {
	var inputStr = t.value;

	// if(this.edtObj.isRectInteger=='true'){
	// if(window.event.keyCode == 45)
	// window.event.keyCode = 0 ;
	// }
	// 如果第一位输入负号，其他位不允许输入负号“-”
	// if(inputStr.indexOf("-")>-1 || inputStr.length>1){
	if (window.event.keyCode == 45)
		window.event.keyCode = 0;
	// }
	// 只能有一个小数点
	if (inputStr.length == 0 || inputStr.indexOf(".") > 0) {
		if (window.event.keyCode == 46)
			window.event.keyCode = 0;
	}
	// //限制小数点后面只有4位
	// if(inputStr.indexOf(".")!=-1&&inputStr.length>inputStr.indexOf(".")+4){
	// window.event.keyCode = 0 ;
	// }

	for ( var i = 0; i < inputStr.length; i++) {
		var oneChar = inputStr.charAt(i)
		// 第一位可以是“-”
		if (i == 0 && oneChar == "-") {
			continue;
		}
		// 可以有小数点
		if (oneChar == ".") {
			continue;
		}

		if (oneChar < "0" || oneChar > "9") {
			event.returnValue = false;
			return false;
		}

	}
	return true;

}

function jqtOnlyNumber(t) {

	checkInputJQT(t);

	if (!(((window.event.keyCode >= 48) && (window.event.keyCode <= 57)) || (window.event.keyCode == 13) || (window.event.keyCode == 45)))

	{
		window.event.keyCode = 0;
	}
}

function jqtOnlyFloat(t) {

	checkInput2(t);

	if (!(((window.event.keyCode >= 48) && (window.event.keyCode <= 57)) || (window.event.keyCode == 13) || (window.event.keyCode == 46)))

	{
		window.event.keyCode = 0;
	}
}
function jqtOnlyNumber2(t) {

	checkInput2(t);

	if (!(((window.event.keyCode >= 48) && (window.event.keyCode <= 57)) || (window.event.keyCode == 13) || (window.event.keyCode == 46)))

	{
		window.event.keyCode = 0;
	}
}
function checkLength(t) {
	var inputStr = t.value;

	if ((inputStr.indexOf(".") > -1) && (inputStr.length) - (inputStr.indexOf(".")) > 3) {

		window.event.keyCode = 0;
	}
	return true;
}

function show() {
	alert("ASCII代码是：" + window.event.keyCode);
}

// opt1 小数 opt2 负数
// 当opt2为1时检查num是否是负数
// 当opt1为1时检查num是否是小数
// 返回1是正确的，0是错误的
function chknbr(num, opt1, opt2) {
	var i = num.length;
	var staus;
	// staus用于记录.的个数
	status = 0;
	if ((opt2 != 1) && (num.charAt(0) == '-')) {
		// alert("You have enter a invalid number.");
		return 0;

	}
	// 当最后一位为.时出错
	if (num.charAt(i - 1) == '.') {
		// alert("You have enter a invalid number.");
		return 0;
	}
	for (j = 0; j < i; j++) {
		if (num.charAt(j) == '.') {
			status++;
		}
		if (status > 1) {
			// alert("You have enter a invalid number.");
			return 0;
		}
		if (num.charAt(j) < '0' || num.charAt(j) > '9') {
			if (((opt1 == 0) || (num.charAt(j) != '.')) && (j != 0)) {
				// alert("You have enter a invalid number.");
				return 0;
			}
		}
	}
	return 1;
}

function HtmlEncode(s, f) {
	var bln = true;
	var obj = s;
	if (obj.indexOf(".") > 0) {
		while (bln == true
				&& (obj.substring(obj.length - 1, obj.length) == "0" || obj.substring(obj.length - 1, obj.length) == ".")) {
			if (obj.substring(obj.length - 1, obj.length) != "0")
				bln = false;
			if (obj.substring(obj.length - 1, obj.length) == ".")
				bln = false;
			obj = obj.substring(0, obj.length - 1);
		}
	}
	obj = parseFloat(obj);
	if (isNaN(obj)) {
		obj = "";
	}
	if (f) {
		eval("document.form1." + f).value = obj;
	} else {
		document.write(obj);
	}
}
// 根据tableId取得制定行列的input；行列input从0开始算
// 参数，tableID，第几烈（从0开始算），td中的第几个input，若包含不检测的tr，在tr中加isNotCheckTr="true"
function jqtCheckNumberFormateMain(tabId, tdseq, inputSeq) {
	var tab = document.getElementById(tabId);

	var trs = tab.rows;

	for ( var i = 0; i < trs.length; i++) {
		var tr = trs[i];

		if (null != tr.isNotCheckTr && tr.isNotCheckTr == "true") {
			continue;
		}
		var td = tr.cells(tdseq);

		var inps = td.getElementsByTagName("input");
		var inp = inps[inputSeq];
		if (jqtCheckNumberFormate(inp) == false) {
			return false;
		}
	}
	return true;
}
function jqtCheckNumberFormate(a) {
	if (a.value == "") {
		return true;
	}
	if (isNaN(a.value)) {
		alert("请输入数字");
		a.focus();
		return false;
	}
	var i = a.value.indexOf(".");
	if (i == -1) {
		if (a.value.length > 16) {
			alert("整数部分最多16位");
			a.focus();
			return false;
		}
	} else {
		if (i > 17 || a.value.length - i > 5) {
			alert("请输入正确格式的数字,整数部分最多16位,小数部分最多4位");
			a.focus();
			return false;
		}
	}
	return true;
}
function jqtCheckHsCodeFormate(b) {
	if (b.value == "") {
		return true;
	}
	if (isNaN(b.value)) {

		alert("请输入正确的产品代码");
		b.focus();
		return false;
	}

	var i = b.value.indexOf(".");
	if (i == -1) {

		if (b.value.length > 8) {
			alert("请输入正确的产品代码");
			b.focus();
			return false;
		}
	} else {

		if (i != 8 || b.value.length - i != 3) {
			alert("请输入正确的产品代码");
			b.focus();
			return false;
		}
	}

	return true;
}