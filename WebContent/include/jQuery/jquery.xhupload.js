/**
 * jquery上传插件 使用方法 $.fn.xhuploadinit(); $("#uploadTextField").xhupload();
 */
(function($){
	var xhuploadAjaxUrl = "/upload/put";
	var successFuntion = $.noop;
	$.fn.xhuploadinit = function(initConfig,initSuccessFuntion){
		if (initConfig) xhuploadAjaxUrl += xhuploadAjaxUrl + "?initConfig=" + initConfig;
		if(initSuccessFuntion && typeof(initSuccessFuntion)=="function" )successFuntion = initSuccessFuntion;
		var immediate = true;
		$("body").append('<input type="file" id="xhUploadFile" name="filedata" class="fileinput" />');
		$("body").append('<div id="xhUploadFile_progress" title="文件上传"><div id="xhUploadFile_progressbar"></div></div>');
		var filename = "", filesize = 0, filetype = "", fileext = "";
		$("#xhUploadFile").on("change", function(){
			if (this.files) {
				// alert("支持:" + this.files[0].size);
				filesize = this.files[0].size;
				filename = this.files[0].name;
				filetype = this.files[0].type;
				fileext = $.fn.xhupload.getFileExt(filename);
			} else {
				// 不支持返回filesize
				filename = $.fn.xhupload.getFileName(thisval);
				fileext = $.fn.xhupload.getFileExt(thisval);
			}
			// 创建进度条dialog
			$('#xhUploadFile_progress').dialog({ autoOpen : false,
			height : 100,
			width : 300,
			modal : true });
			$('#xhUploadFile_progressbar').progressbar({ value : false,
			change : function(){},
			complete : function(){
			// $('#xhUploadFile_progressbar').progressbar("value", 0);
			// $('#xhUploadFile_progress').dialog("close");
			} });

			if (immediate) {
				$('#xhUploadFile_progress').dialog("open");
				// alert(xhupload_opts.immediate);
				// 直接上传文件
				$.fn.xhUploadFile("xhUploadFile");
			}
		});
	};

	$.fn.xhupload = function(options){
		var defaults = { url : xhuploadAjaxUrl,// 上传serve
		filefield : "filedata",// input.file的表单名称
		immediate : 1,// 0:普通模式 1:立即模式,选择文件即上传
		info : 0,// 是否返回文件信息(大小,文件名,类型) 0:不返回 1:返回
		fileext : [ 'jpg', 'gif', 'png', 'jpeg' ],// 对返回的文件信息的扩展名进行校验
		};

		return this.each(function(){
			var $this = $(this);
			var opts = $.extend({}, defaults, options);
			$.fn.xhcreate($this, opts);
		});
	};

	$.fn.xhcreate = function(o, c){
		var oid = o.attr("id");
		o.after('<span id="filebtn" class="filearea"><input type="button" id="' + oid + '_filebutton" name="filebutton" value="选择文件" class="filebutton" /></span>');
		$("#" + oid + "_filebutton").on("click", function(){
			$("#xhUploadFile").data("recallid", oid);
			$("#xhUploadFile").click();
		});
	};

	$.fn.xhupload.sizeFormat = function(s){
		if (s > 1024 * 1024) return (Math.round(file.size * 100 / (1024 * 1024)) / 100).toString() + 'MB';
		else return (Math.round(file.size * 100 / 1024) / 100).toString() + 'KB';
	};

	$.fn.xhupload.getFileName = function(s){ // 从
		return s.match(/[^\/|\\]*$/)[0];
	};

	$.fn.xhupload.getFileExt = function(s){
		s = $.fn.xhupload.getFileName(s);
		return s.substr(s.lastIndexOf(".") + 1);
	};

	$.fn.xhUploadFile = function(file_id){
		var contentType;
		var formData;
		if (window.FormData && window.XMLHttpRequest) {
			contentType = false;
			formData = new FormData();
			formData.append("filedata", document.getElementById(file_id).files[0]);
		} else {
			contentType = "multipart/form-data";
			formData = null;
		}

		$.ajax({ url : xhuploadAjaxUrl,
		type : "POST",
		data : formData,
		processData : false,
		contentType : contentType,
		xhr : function(){
			var xhr = jQuery.ajaxSettings.xhr();
			xhr.onload = function(evt){// 完成
				var text = evt.target.responseText;
				var reg = /^\{"err":"[\S]*","msg":"[\S]*"\}$/;
				if (reg.test(text)) {
					var jobj = eval("(" + evt.target.responseText + ")");
					if (jobj.err != '') {
						alert("err:" + jobj.err);
					} else {
						var msg = jobj.msg;
						if (msg.substr(0, 1) == '!') {
							msg = msg.substring(1);
						}
						$("#" + $("#xhUploadFile").data("recallid")).val(msg);
					}
				} else {
					alert(evt.target.responseText);
				}
			};
			xhr.upload.onprogress = function(evt){ // 进度条函数
				if (evt.lengthComputable) {
					var percentComplete = Math.round(evt.loaded * 100 / evt.total);
					$('#xhUploadFile_progressbar').progressbar("value", percentComplete);
					// document.getElementById('progressNumber').innerHTML = percentComplete.toString() + '%';
				} else {
					alert("上传失败");
					// document.getElementById('progressNumber').innerHTML = 'unable to compute';
				}
			};
			xhr.abort = function(){};
			xhr.error = function(){};
			return xhr;
		},
		success : function(data){
			// 只有当返回时 进度条才算结束
			$('#xhUploadFile_progress').dialog("close");
			// alert("afasdf:" + data);
			if(typeof successFuntion == "function")
				successFuntion();
		} });
	};
})(jQuery);

String.prototype.startWith = function(str){
	var reg = new RegExp("^" + str);
	return reg.test(this);
};
String.prototype.endWith = function(str){
	var reg = new RegExp(str + "$");
	return reg.test(this);
};