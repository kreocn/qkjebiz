//*************************************** 
// HttpCookie 
// 
// 编写: 静静的黎明 
// 功能: 客户端Cookie操作封装， 
// 支持多值cookie 
// 
//*************************************** 

// 
// 填补 ie 5.0的 Array.splice 函数 
// 
if (new Array().splice == null) {
	// / usage: array.splice(startPos,deleteCount,[item1,item2,...]);for ie5.0
	Array.prototype.splice = function() {
		if (arguments.length < 2 || arguments[1] < 0)
			return new Array();

		var endPoint1 = arguments[0];
		if (endPoint1 < 0 && Math.abs(endPoint1) > this.length)
			endPoint1 = 0;

		var startPoint2 = (endPoint1 < 0) ? (this.length + endPoint1 + arguments[1]) : (endPoint1 + arguments[1]);

		var bArray = this.slice(0, endPoint1);
		var dArray = this.slice(endPoint1, startPoint2);
		var eArray = this.slice(startPoint2);
		var nArray = new Array();
		for ( var i = 2, al = arguments.length; i < al; i++) {
			nArray.push(arguments[i]);
		}
		var fArray = bArray.concat(nArray, eArray);

		for ( var i = 0, al = fArray.length; i < al; i++) {
			this[i] = fArray[i];
		}
		this.length = fArray.length;

		return dArray;
	}
}

// 
// NameValueCollection 类
// 
function NameValueCollection() {
	this.__keys = new Array();
	this.__values = new Object();

	this.__checkArg = function() {
		for ( var i = 0, j = arguments.length; i < j; i++) {
			if (typeof arguments[i] != "string")
				return false;
		}
		return true;
	}

	// 
	// 返回包含当前实例的所有键的字符数组
	// 
	this.allKeys = function() {
		return this.__keys.concat();
	}

	// 
	// 获取与 NameValueCollection 中的指定键关联的值(字符数组)。
	// 
	this.getValues = function(name) {
		if (!this.__checkArg(name)) {
			throw new Error("Invalid type on NameValueCollection.getValues's argument.");
		}

		var values = this.__values[name.toLowerCase()];

		return (values instanceof Array) ? values : null;
	}

	// 
	// 将具有指定名称和值的项添加到 NameValueCollection。
	// 
	this.add = function(name, value) {
		if (!this.__checkArg(name, value)) {
			throw new Error("Invalid type on NameValueCollection.add's argument");
		}

		var key = name.toLowerCase();

		if (this.__values[key] == null) {
			this.__keys[this.__keys.length] = name;
			this.__values[key] = new Array(value);
		} else {
			this.__values[key][this.__values[key].length] = value;
		}
	}

	// 
	// 获取与 NameValueCollection 中的指定键关联的值，
	// 如果对应多个值，以逗号分割，参考getValues。
	// 
	this.get = function(name) {
		if (!this.__checkArg(name)) {
			throw new Error("Invalid type on NameValueCollection.get's argument");
		}

		var value = this.__values[name.toLowerCase()];

		return (value instanceof Array) ? value.join(",") : null;
	}

	// 
	// 设置或改变(该项不为空)NameValueCollection 中某个项的值。
	// 
	this.set = function(name, value) {
		if (!this.__checkArg(name, value)) {
			throw new Error("Invalid type on NameValueCollection.set's argument");
		}

		var key = name.toLowerCase();

		if (this.__values[key] == null) {
			this.__keys[this.__keys.length] = name;
		}

		this.__values[key] = new Array(value);
	}

	this.hasKeys = function() {
		return this.__keys.length > 0;
	}
	// 
	// 清空NameValueCollection的所有键值。
	// 
	this.clear = function() {
		this.__keys = new Array();
		this.__values = new Object();
	}

	// 
	// 将具有指定键的项从当前实例中删除。
	// 
	this.remove = function(name) {
		if (!this.__checkArg(name)) {
			throw new Error("Invalid type on NameValueCollection.remove's argument");
		}

		var key = name.toLowerCase();

		if (this.__values[key] == null)
			return;

		for ( var i = 0, j = this.__keys.length; i < j; i++) {
			if (this.__keys[i] == key) {
				this.__keys.splice(i, 1);
				this.__values[key] = null;
				return;
			}
		}
	}
}
// 
// 类HttpCookie
// 
function HttpCookie(name) {
	// 
	// 私有属性
	// 
	this.__name;
	this.__isExisted;
	this.__expires;
	this.__value;
	this.__path;

	// 
	// 公有属性:values; 类型:JScript.Collections.NameValueCollection;
	// 
	this.values;

	// 
	// 判定当前的 HttpCookie 实例是否存在。
	// 
	this.isExisted = function() {
		return this.__isExisted;
	}

	// 
	// 判断当前的cookie是否具有子键。
	// 
	this.hasKeys = function() {
		return this.values.hasKeys();
	}

	// 
	// 私有方法,分析cookie串
	// 
	this.__analysisCooString = function(cstring) {
		var subCookies = cstring.split("&");

		for ( var k = 0, l = subCookies.length; k < l; k++) {
			var key, values, splitPos;

			splitPos = subCookies[k].indexOf("=");

			if (splitPos != -1) {
				key = subCookies[k].substring(0, splitPos);
				values = subCookies[k].substring(splitPos + 1);
				values = values.split(",");

				// 插入键值
				for ( var m = 0, n = values.length; m < n; m++)

					this.values.add(key, values[m]);
			} else {
				this.__value = subCookies[k];
			}
		}
	}

	// 
	// 私有方法，初始化 cookie 。
	// 如果以参数 name 为名字的cookie存在，则导入该cookie；
	// 调用isExisted 方法则返回真，否则初始化一个新实例；调用
	// isExisted()返回 false。
	// 
	this.__init = function(name) {
		if (typeof name != "string")
			throw new Error("Invalid type on HttpCookie's argument");

		this.__name = (name != null) ? name : "";
		this.__value = "";
		this.__isExisted = false;
		this.__expires = null;
		this.__path = "/";
		this.values = new NameValueCollection();

		var cookies = document.cookie.split("; ");

		for ( var i = 0, j = cookies.length; i < j; i++) {
			var name, value, splitPos;

			splitPos = cookies[i].indexOf("=");

			if (splitPos != -1) {
				name = cookies[i].substring(0, splitPos);
				value = cookies[i].substring(splitPos + 1);
			} else {
				name = cookies[i];
			}

			if (this.__name.toLowerCase() == name.toLowerCase()) {
				this.__isExisted = true;

				if (value == null)
					return;

				this.__analysisCooString(value);

				break;
			}
		}
	}

	// 
	// 返回当前HttpCookie实例的名字。
	// 
	this.getName = function() {
		return this.__name;
	}

	// 
	// 设定当前 HttpCookie 实例的值
	// 
	this.setValue = function(value) {
		if (value != null) {
			this.__value = value.toString();
			this.values = new NameValueCollection();
		}
	}

	// 
	// 返回 当前 HttpCookie 实例的值
	// 
	this.getValue = function() {
		var value = new String();

		if (this.values.hasKeys()) {
			var keys = this.values.allKeys();

			for ( var i = 0, j = keys.length; i < j; i++) {
				value += "&" + keys[i] + "=" + this.values.get(keys[i]);
			}
		}

		return this.__value + ((this.__value == "") ? value.substring(1) : value);

	}

	// 
	// 设定当前 HttpCookie 实例的过期时间；以秒为单位
	// 当该方法未被调用时，实例默认跟随窗体存活期。
	// 
	this.setExpires = function(secs) {
		if (typeof secs == "number") {
			var sysExpiresTime = new Date().getTime() + parseInt(secs) * 1000;

			this.__expires = new Date(sysExpiresTime).toGMTString();
		}
	}

	// 
	// 设定当前 HttpCookie 实例的的有效跟目录。
	// 
	this.setPath = function(path) {
		if (path != null)
			this.__path = path.toString();
	}

	// 
	// 将当前的HttpCookie实例配置写入 cookie。
	// 
	this.save = function() {
		document.cookie = this.__name + "=" + this.getValue() + ";"
				+ ((this.__expires != null) ? "expires=" + this.__expires + ";" : "") + "path=" + this.__path + ";";

	}
	// 初始化
	this.__init(name);
}

/** ************以下为测试代码********** */
function enumCookieValues(coo) {
	// 枚举
	var keys = coo.values.allKeys();

	alert("用HttpCookie.values.get枚举");

	for ( var i = 0, j = keys.length; i < j; i++) {
		alert("key=" + keys[i] + "; value=" + coo.values.get(keys[i]));
	}
	// //////////////////////////////////////////////////
	alert("用HttpCookie.values.getValues枚举");

	for ( var i = 0, j = keys.length; i < j; i++) {
		var valueArr = coo.values.getValues(keys[i]);

		for ( var k = 0, l = valueArr.length; k < l; k++) {
			alert("key=" + keys[i] + ";value=" + valueArr[k]);
		}
	}

}
// 简单的单值cookie的例子，需要效果请拿掉注释

// var coo = new HttpCookie("cookie");
// coo.setValue("cookie的值");
// coo.save();
// alert(coo.getValue());

// 多值cookie
var coo = new HttpCookie("cookie1");

if (coo.isExisted() == false) {
	// set 重写或设定， add方法不重写原来的键值
	coo.values.set("language", "javascript");

	coo.values.add("method", "post");

	coo.values.add("method", "get");

	coo.save();

	// 枚举
	enumCookieValues(coo);

} else {
	// 枚举
	enumCookieValues(coo);

	// 删除一个键值
	coo.values.remove("method");
	// 设定过期时间秒数，这里设定为当前时间，就是删除
	coo.setExpires(0);

	coo.save();

}