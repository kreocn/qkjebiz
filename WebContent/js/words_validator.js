var words_validator = function(words,type) {
	
	this.reg = new Object();
	this.reg.english = /^[a-zA-Z0-9_\-]+$/;
	this.reg.chinese = /^[\u0391-\uFFE5]+$/;
	this.reg.number = /^[-\+]?\d+(\.\d+)?$/;
	this.reg.integer = /^[-\+]?\d+$/;
	this.reg.float = /^[-\+]?\d+(\.\d+)?$/;
	this.reg.date = /^(\d{4})(-|\/)(\d{1,2})\2(\d{1,2})$/;
	this.reg.email = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
	this.reg.url = /^(((ht|f)tp(s?))\:\/\/)[a-zA-Z0-9]+\.[a-zA-Z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
	this.reg.phone = /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/;
	this.reg.mobile = /1[0-9]{10}$/;
	this.reg.ip = /^(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5]).(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5]).(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5]).(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5])$/;
	this.reg.zipcode = /^[1-9]\d{5}$/;
	this.reg.qq = /^[1-9]\d{4,10}$/;
	this.reg.msn = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
	this.reg.idcard = /(^\d{15}$)|(^\d{17}[0-9Xx]$)/;

	// 执行字符串验证
	this.validate = function() {
		var v = words;
		var dataType = type;
		
		if (!v.isEmpty() && dataType != null) {
			dataType = dataType.toLowerCase();
			try {
				// alert(dataType);
				if (!(eval('this.reg.' + dataType)).test(v)) {
					return false;
				}
			} catch (e) {
				return false;
			}
		}
		return true;
	};

	return this.validate();
};