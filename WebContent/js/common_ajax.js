//Author:Kreo

//div_id 是保存下载完成的内容的容器
//isShowErr 是否提示错误信息
//isShowWait 是否提示等待信息
//mErrCon 服务器返回什么字符串视为错误
//mErr 发生错误时显示的信息
//mWait 等待时提示信息
//p_mDiv 显示 错误/等待 信息的div_id,留空则默认为div_id
//var ajax = new Ajax_Init("showX",false,false,'','','');
//ajax.addParameter("SQL_NAME","Part Used Last Time");	
//ajax.addParameter("param0","SN00322%");
//ajax.SendGet("http://10.1.10.16:2222/rpts/servlet/sExcel");
function Ajax_Init(div_id, p_isShowErr, p_isShowWait, p_mErrCon, p_mErr,
		p_mWait, p_mDiv) {
	var isShowErr, isShowWait, mErrCon, mErr, mWait, mCon;
	// function Ajax_Init() {
	if (p_isShowErr == null || p_isShowErr == "")
		isShowErr = false;
	else
		isShowErr = p_isShowErr;
	if (p_isShowWait == null || p_isShowWait == "")
		isShowWait = false;
	else
		isShowWait = p_isShowWait;
	if (p_mErrCon == null || p_mErrCon == "")
		mErrCon = "";
	else
		mErrCon = p_mErrCon;
	if (p_mErr == null || p_mErr == "")
		mErr = "读取数据失败";
	else
		mErr = p_mErr;
	if (p_mWait == null || p_mWait == "")
		mWait = "正在读取数据...";
	else
		mWait = p_mWait;

	// 设置div的容器对象
	var aCon = document.getElementById(div_id);
	if (p_mDiv == null || p_mDiv == "")
		mCon = aCon;
	else
		mCon = document.getElementById(p_mDiv);

	var xmlhttp;

	// 初始化xmlhttp

	if (window.XMLHttpRequest) {// IE7, Mozilla ,Firefox 等浏览器内置该对象
		xmlhttp = new XMLHttpRequest();
	} else if (window.ActiveXObject) {// IE6、IE5
		try {
			xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
		}
		if (xmlhttp == null) {
			try {
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {
			}
		}
	}

	// 传递参数的key和value
	this.keys = new Array();
	this.values = new Array();
	this.keyCount = -1;
	// 加入http head的参数
	this.hKeys = new Array();
	this.hValues = new Array();
	this.hKeyCount = -1;
	// 请求类型,可以有binary和text,默认为text
	this.rType = "text";
	// 设置传递参数的键值对

	this.addParameter = function(p_key, p_value) {
		this.keyCount++;
		this.keys[this.keyCount] = p_key;
		this.values[this.keyCount] = escape(p_value);
	};

	// 设置加入HTTP Head的键值对
	this.addHead = function(p_key, p_value) {
		this.hKeyCount++;
		this.hKeys[this.hKeyCount] = p_key;
		this.hValues[this.hKeyCount] = escape(p_value);
	};

	// 清除所有设置的键值对
	this.ClearSet = function() {
		this.keyCount = -1;
		this.keys = new Array();
		this.values = new Array();
		this.hKeyCount = -1;
		this.hKeys = new Array();
		this.hValues = new Array();
	};

	// 设置Http请求头
	this.setHead = function() {
		if (this.hKeyCount != -1) { // 发送用户自行设定的请求头
			for (i = 0; i <= this.hKeyCount; i++) {
				xmlhttp.setRequestHeader(this.hKeys[i], this.hValues[i]);
			}
		}
		if (this.rType == 'binary') {
			xmlhttp.setRequestHeader("Content-Type", "multipart/form-data");
		} else {
			xmlhttp.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
		}
	};
	// 用Post方式发送数据
	this.SendPost = function(purl) {
		var pdata = "";
		var i = 0;
		this.state = 0;
		xmlhttp.open("POST", purl, true);
		this.setHead();
		if (this.keyCount != -1) { // post数据
			for (; i <= this.keyCount; i++) {
				if (pdata == "")
					pdata = this.keys[i] + '=' + this.values[i];
				else
					pdata += "&" + this.keys[i] + '=' + this.values[i];
			}
		}
		xmlhttp.send(pdata);
	};

	// 用GET方式发送数据
	this.SendGet = function(purl) {
		var gkey = "";
		var i = 0;
		this.state = 0;
		if (this.keyCount != -1) { // get参数
			for (; i <= this.keyCount; i++) {
				if (gkey == "")
					gkey = this.keys[i] + '=' + this.values[i];
				else
					gkey += "&" + this.keys[i] + '=' + this.values[i];
			}
			if (purl.indexOf('?') == -1)
				purl = purl + '?' + gkey;
			else
				purl = purl + '&' + gkey;
		}
		xmlhttp.open("GET", purl, true);
		this.setHead();
		xmlhttp.send(null);
	};

	// 用GET方式发送数据，阻塞模式
	this.SendGet2 = function(purl) {
		var gkey = "";
		var i = 0;
		this.state = 0;
		if (this.keyCount != -1) { // get参数
			for (; i <= this.keyCount; i++) {
				if (gkey == "")
					gkey = this.keys[i] + '=' + this.values[i];
				else
					gkey += "&" + this.keys[i] + '=' + this.values[i];
			}
			if (purl.indexOf('?') == -1)
				purl = purl + '?' + gkey;
			else
				purl = purl + '&' + gkey;
		}
		xmlhttp.open("GET", purl, false);
		this.setHead();
		xmlhttp.send(null);
	};
	
	this.setInfoFunction;

	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				if (xmlhttp.responseText != mErrCon
						&& xmlhttp.responseText != '') {
					// 可以自定义setAjaxInfo(str)函数处理数据,如检测不到此函数,则直接写入预定义的id容器中
					if (typeof setAjaxInfo == "function")
						setAjaxInfo(xmlhttp.responseText);
					else if(typeof this.setInfoFunction == "function") {
						alert('setInfoFunction');
						this.__setInfo(xmlhttp.responseText);
					} else
						aCon.innerHTML = xmlhttp.responseText;
					mCon.innerHTML = '&nbsp;';
				} else {
					if (isShowErr)
						mCon.innerHTML = mErr;
				}
				xmlhttp = null;
			} else {
				if (isShowErr)
					mCon.innerHTML = mErr;
			}
		} else {
			if (isShowWait)
				mCon.innerHTML = mWait;
		}
	};	

	this.formatForm = function(oForm) {
		var s1 = "", s2 = "", e = null, s3 = "";
		for ( var i = 0; i < oForm.length; i++) {
			e = oForm[i];
			if (e.name) {
				if (e.type == 'select-one') {
					s3 = e.length > 0 ? e.options[e.selectedIndex].value : "";
				} else if (e.type == 'select-multiple') {
					for ( var n = 0; n < e.length; n++) {
						var op = e.options[n];
						if (op.selected) {
							s1 += s2 + e.name + '='
									+ encodeURIComponent(op.value);
							s2 = "&"
						}
					}
					continue;
				} else if (e.type == 'checkbox' || e.type == 'radio') {
					if (e.checked == false) {
						continue;
					}
					s3 = e.value;
				} else if (typeof e.value != 'undefined') {
					s3 = e.value;
				} else {
					continue;
				}
				s1 += s2 + e.name + '=' + encodeURIComponent(s3);
				s2 = "&";
			}
		}
		return s1;
	};

	this.formatCallBack = function(f) {
		var fType = typeof (f);
		var dataType = this.type;
		if (fType == "function") {
			return f;
		}
		if (fType == "string" || fType == "object") {
			f = document.getElementById(f);
			if (f.tagName == "INPUT" || f.tagName == "TEXTAREA") {
				return function(s) {
					f.value = s;
				};
			} else {
				return function(s) {
					f.innerHTML = s;
				};
			}
		} else {
			return function() {
			}
		}
	};
}


function iferror(str,e) {
	if(str.indexOf("NOPERMIT")>-1) {
		alert("无此操作权限!");
	} else if(str.indexOf("NODATA")>-1) {
		alert("没有数据!");
	} else if(str.indexOf("LOGTIMEOUT")>-1) {
		alert("登录超时,请重新登陆!");
	} else {
		alert("发生不可预测的错误:[" + e.name + "]" + e.message);
	}
}