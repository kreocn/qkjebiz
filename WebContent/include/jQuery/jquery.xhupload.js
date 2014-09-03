/**
 * jquery上传插件
 */
(function($){
	var xhupload_opts = {};
	$.fn.xhupload = function(options){
		var $this = $(this);
		var $this_id = $this.attr("id");
		var defaults = { url : "/upload/put",// 上传serve
		filefield : "filedata",// input.file的表单名称
		immediate : 1,// 0:普通模式 1:立即模式,选择文件即上传
		info : 0,// 是否返回文件信息(大小,文件名,类型) 0:不返回 1:返回
		fileext : [ 'jpg', 'gif', 'png', 'jpeg' ],// 对返回的文件信息的扩展名进行校验
		progress : function(evt){ // 进度条函数
			if (evt.lengthComputable) {
				var percentComplete = Math.round(evt.loaded * 100 / evt.total);
				$('#' + $this_id + '_progressbar').progressbar("value", percentComplete);
				// document.getElementById('progressNumber').innerHTML = percentComplete.toString() + '%';
			} else {
				alert("上传失败");
				// document.getElementById('progressNumber').innerHTML = 'unable to compute';
			}

		},
		complete : function(evt){// 完成
			// alert(evt.target.responseText);
			// alert(evt.target.responseText);
			// {"err":"","msg":"200906030521128703.gif"}
			var text = evt.target.responseText;
			var reg = /^\{"err":"[\S]*","msg":"[\S]*"\}$/;
			if (reg.test(text)) {
				var jobj = eval("(" + evt.target.responseText + ")");
				if (jobj.err != '') {
					alert("err:" + jobj.err);
				} else {
					$this.val(jobj.msg);
				}
			} else {
				alert("上传文件错误,文件最大不能超过10M.");
			}

		},
		failed : function(evt){
			alert("上传文件失败");
		},
		canceled : function(evt){
			alert("上传文件被中断");
		} };

		xhupload_opts = $.extend({}, defaults, options);
		return this.each(function(){
			$.fn.xhcreate($this);
		});
	};
	$.fn.xhcreate = function(obj){
		/*
		 * <span class="filearea"><input type="file" id="ft_filedata" name="filedata" class="fileinput" /><input type="button" id="ft_filebutton" name="filebutton" value="选择文件"
		 * class="filebutton" /> </span>
		 */
		// var $this = $(this);
		var oid = obj.attr("id");
		var filefield = xhupload_opts.filefield;
		var filename = "", filesize = 0, filetype = "", fileext = "";
		obj
				.after('<span class="filearea"><input type="file" id="' + oid + '_' + filefield + '" name="' + filefield + '" class="fileinput" /><input type="button" id="ft_filebutton" name="filebutton" value="选择文件" class="filebutton" /></span>');
		$("#" + oid + "_" + filefield).on(
				"change",
				function(){
					if (xhupload_opts.info == 1) {
						var thisval = $(this).val();
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
					}

					// 创建进度条dialog
					if ($('#' + oid + '_progress').length == 0)
						$("body").append('<div id="' + oid + '_progress" title="文件上传"><div id="' + oid + '_progressbar"></div><div id="' + oid + '_progressbar2"></div></div>');
					$('#' + oid + '_progress').dialog({ autoOpen : false,
					height : 100,
					width : 300,
					modal : true });

					$('#' + oid + '_progressbar').progressbar({ value : false,
					change : function(){},
					complete : function(){
						$('#' + oid + '_progress').dialog("close");
					} });

					if (xhupload_opts.immediate == 1) {
						$('#' + oid + '_progress').dialog("open");
						// alert(xhupload_opts.immediate);
						// 直接上传文件
						$.fn.xhUploadFile(oid + '_' + filefield);
					}
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
			formData.append(xhupload_opts.filefield, document.getElementById(file_id).files[0]);
		} else {
			contentType = "multipart/form-data";
			formData = null;
		}

		$.ajax({ url : xhupload_opts.url,
		type : "POST",
		data : formData,
		processData : false,
		contentType : contentType,
		xhr : function(){
			var xhr = jQuery.ajaxSettings.xhr();
			xhr.onload = xhupload_opts.complete;
			xhr.upload.onprogress = xhupload_opts.progress;
			xhr.abort = xhupload_opts.canceled;
			xhr.error = xhupload_opts.failed;
			return xhr;
		},
		success : function(data){
		// alert("afasdf:" + data);
		} });

	};

})(jQuery);

jQuery.extend({ createUploadIframe : function(id, uri){
	// create frame
	var frameId = 'jUploadFrame' + id;
	var iframeHtml = '<iframe id="' + frameId + '" name="' + frameId + '" style="position:absolute; top:-9999px; left:-9999px"';
	if (window.ActiveXObject) {
		if (typeof uri == 'boolean') {
			iframeHtml += ' src="' + 'javascript:false' + '"';

		} else if (typeof uri == 'string') {
			iframeHtml += ' src="' + uri + '"';

		}
	}
	iframeHtml += ' />';
	jQuery(iframeHtml).appendTo(document.body);

	return jQuery('#' + frameId).get(0);
},
createUploadForm : function(id, fileElementId, data){
	// create form
	var formId = 'jUploadForm' + id;
	var fileId = 'jUploadFile' + id;
	var form = jQuery('<form  action="" method="POST" name="' + formId + '" id="' + formId + '" enctype="multipart/form-data"></form>');
	if (data) {
		for ( var i in data) {
			jQuery('<input type="hidden" name="' + i + '" value="' + data[i] + '" />').appendTo(form);
		}
	}
	var oldElement = jQuery('#' + fileElementId);
	var newElement = jQuery(oldElement).clone();
	jQuery(oldElement).attr('id', fileId);
	jQuery(oldElement).before(newElement);
	jQuery(oldElement).appendTo(form);

	// set attributes
	jQuery(form).css('position', 'absolute');
	jQuery(form).css('top', '-1200px');
	jQuery(form).css('left', '-1200px');
	jQuery(form).appendTo('body');
	return form;
},

ajaxFileUpload : function(s){
	// TODO introduce global settings, allowing the client to modify them for all requests, not only timeout
	s = jQuery.extend({}, jQuery.ajaxSettings, s);
	var id = new Date().getTime()
	var form = jQuery.createUploadForm(id, s.fileElementId, (typeof (s.data) == 'undefined' ? false : s.data));
	var io = jQuery.createUploadIframe(id, s.secureuri);
	var frameId = 'jUploadFrame' + id;
	var formId = 'jUploadForm' + id;
	// Watch for a new set of requests
	if (s.global && !jQuery.active++) {
		jQuery.event.trigger("ajaxStart");
	}
	var requestDone = false;
	// Create the request object
	var xml = {}
	if (s.global) jQuery.event.trigger("ajaxSend", [ xml, s ]);
	// Wait for a response to come back
	var uploadCallback = function(isTimeout){
		var io = document.getElementById(frameId);
		try {
			if (io.contentWindow) {
				xml.responseText = io.contentWindow.document.body ? io.contentWindow.document.body.innerHTML : null;
				xml.responseXML = io.contentWindow.document.XMLDocument ? io.contentWindow.document.XMLDocument : io.contentWindow.document;
			} else if (io.contentDocument) {
				xml.responseText = io.contentDocument.document.body ? io.contentDocument.document.body.innerHTML : null;
				xml.responseXML = io.contentDocument.document.XMLDocument ? io.contentDocument.document.XMLDocument : io.contentDocument.document;
			}
		} catch (e) {
			jQuery.handleError(s, xml, null, e);
		}
		if (xml || isTimeout == "timeout") {
			requestDone = true;
			var status;
			try {
				status = isTimeout != "timeout" ? "success" : "error";
				// Make sure that the request was successful or notmodified
				if (status != "error") {
					// process the data (runs the xml through httpData regardless of callback)
					var data = jQuery.uploadHttpData(xml, s.dataType);
					// If a local callback was specified, fire it and pass it the data
					if (s.success) s.success(data, status);

					// Fire the global callback
					if (s.global) jQuery.event.trigger("ajaxSuccess", [ xml, s ]);
				} else jQuery.handleError(s, xml, status);
			} catch (e) {
				status = "error";
				jQuery.handleError(s, xml, status, e);
			}
			// The request was completed
			if (s.global) jQuery.event.trigger("ajaxComplete", [ xml, s ]);
			// Handle the global AJAX counter
			if (s.global && !--jQuery.active) jQuery.event.trigger("ajaxStop");
			// Process result
			if (s.complete) s.complete(xml, status);
			jQuery(io).unbind()
			setTimeout(function(){
				try {
					jQuery(io).remove();
					jQuery(form).remove();

				} catch (e) {
					jQuery.handleError(s, xml, null, e);
				}
			}, 100)
			xml = null
		}
	}
	// Timeout checker
	if (s.timeout > 0) {
		setTimeout(function(){
			// Check to see if the request is still happening
			if (!requestDone) uploadCallback("timeout");
		}, s.timeout);
	}
	try {
		var form = jQuery('#' + formId);
		jQuery(form).attr('action', s.url);
		jQuery(form).attr('method', 'POST');
		jQuery(form).attr('target', frameId);
		if (form.encoding) {
			jQuery(form).attr('encoding', 'multipart/form-data');
		} else {
			jQuery(form).attr('enctype', 'multipart/form-data');
		}
		jQuery(form).submit();
	} catch (e) {
		jQuery.handleError(s, xml, null, e);
	}

	jQuery('#' + frameId).load(uploadCallback);
	return { abort : function(){} };

},
uploadHttpData : function(r, type){
	var data = !type;
	data = type == "xml" || data ? r.responseXML : r.responseText;
	// If the type is "script", eval it in global context
	if (type == "script") jQuery.globalEval(data);
	// Get the JavaScript object, if JSON is used.
	if (type == "json") eval("data = " + data);
	// evaluate scripts within html
	if (type == "html") jQuery("<div>").html(data).evalScripts();

	return data;
} });
