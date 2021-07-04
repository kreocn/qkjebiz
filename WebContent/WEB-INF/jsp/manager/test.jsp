<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>TEST ONLY -- <s:text name="APP_NAME" /></title>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-timepicker-addon.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/xheditor/xheditor-1.2.1.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/xheditor/xheditor_lang/zh-cn.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.xhupload.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/stylesheets/jquery.xhupload.css" />" />
<style type="text/css">
</style>
<script type="text/javascript">
var editor;
$(function() {
	
});
</script>

<script type="text/javascript">
      function fileSelected() {
        var file = document.getElementById('filedata').files[0];
        if (file) {
          var fileSize = 0;
          if (file.size > 1024 * 1024)
            fileSize = (Math.round(file.size * 100 / (1024 * 1024)) / 100).toString() + 'MB';
          else
            fileSize = (Math.round(file.size * 100 / 1024) / 100).toString() + 'KB';

          document.getElementById('fileName').innerHTML = 'Name: ' + file.name;
          document.getElementById('fileSize').innerHTML = 'Size: ' + fileSize;
          document.getElementById('fileType').innerHTML = 'Type: ' + file.type;
        }
      }

      function uploadFile() {
        var fd = new FormData();
        fd.append("filedata", document.getElementById('filedata').files[0]);
        var xhr = new XMLHttpRequest();
        xhr.upload.addEventListener("progress", uploadProgress, false);
        xhr.addEventListener("load", uploadComplete, false);
        xhr.addEventListener("error", uploadFailed, false);
        xhr.addEventListener("abort", uploadCanceled, false);
        xhr.open("POST", "/upload/put");
        xhr.send(fd);
      }

      function uploadProgress(evt) {
        if (evt.lengthComputable) {
          var percentComplete = Math.round(evt.loaded * 100 / evt.total);
          document.getElementById('progressNumber').innerHTML = percentComplete.toString() + '%';
        }
        else {
          document.getElementById('progressNumber').innerHTML = 'unable to compute';
        }
      }

      function uploadComplete(evt) {
        /* This event is raised when the server send back a response */
        alert(evt.target.responseText);
      }

      function uploadFailed(evt) {
        alert("There was an error attempting to upload the file.");
      }

      function uploadCanceled(evt) {
        alert("The upload has been canceled by the user or the browser dropped the connection.");
      }
    </script>
</head>
<body>
<div style="border: red solid 1px;padding: 50px;margin: 20px;">
  	<input id="ft" name="filetxt" value="http://" style="width: 300px;" />  <br />
  	<input id="ft2" name="filetxt2" value="http://" style="width: 300px;" /> 
<script type="text/javascript">

$(function(){
	$.fn.xhuploadinit();
	$("#ft").xhupload();
	$("#ft2").xhupload();
});
		//var x = {"err":"","msg":"200906030521128703.gif"};
		//alert(x.err);
		//alert(x.msg);
		//$("#ft").xhupload();
		//$("#ft2").xhupload();
		//$("#ft").ajaxFileUpload
function ajaxFileUpload(){
	$.ajaxFileUpload({ url : '/upload/put',
	secureuri : false,
	fileElementId : 'ft_filedata',
	dataType : 'json',
	beforeSend : function(){
		//<button class="button" id="buttonUpload" onclick="return ajaxFileUpload();">Upload</button>
		//$("#loading").show();
	},
	complete : function(){
		//$("#loading").hide();
	},
	success : function(data, status){
		alert(data.err);
		alert(data.msg);
		/*
		if (typeof (data.error) != 'undefined') {
			if (data.error != '') {
				alert(data.error);
			} else {
				alert(data.msg);
			}
		}
		*/
	},
	error : function(data, status, e){
		alert(e);
	} })

	return false;

}
</script>
  </div>
  <div style="height: 20px;"></div>
  <!-- ---------------------------------------------------------------------------- -->
  <div style="padding-left: 30px;">
    <textarea id="testxh" name="testxh" style="width: 80%; height: 300px;"></textarea>
  </div>
  <div style="height: 50px;"></div>
  <div>
    <form name="form1" action="/upload/put" onsubmit="return validator(this);" enctype="multipart/form-data" method="post">
      <input type="file" name="filedata" /> <input type="submit" value="Upload" />
      <input type="button" value="TEST" onclick="test_03();" />
    </form>
    <script>
    function test_02() {
    	var s = "d:/userAdmin/uploads/20120515_115146.jpg";
    	alert(s.match(/[^\/]*$/)[0]);
    	s = s.match(/[^\/]*$/)[0];
		alert(s.substr(s.lastIndexOf(".")+1));
    }
    function test_03() {
    	var s1 = '{"err":"","msg":"200906030521128703.gif"}';
    	var s2 = '<html>{"err":"asdfdsafsadf","msg":""}';
    	//var r = /^\{([a-zA-Z\"\']{2,15}(\s)*\:[^\r\n]{0,200}(,)?(\s)*)*\}$/;
		var r2=/^\{\"err\":\"[\s]*\",\"msg\":\"[\s]*"\$]/;
		var r3=/^\{"err":"[\S]*","msg":"[\S]*"\}$/;
    	alert("true:" + r3.test(s1) + " false:"+ r3.test(s2));
		//alert(s.substr(s.lastIndexOf(".")+1));
    }
    </script>
  </div>
  <!-- -------------------------------------------------------------------------- -->
  <div>
<form id="formx" method="post" action="/upload/put">
<div class="row">
      <label for="filedata">Select a File to Upload</label>
	<input type="file" name="filedata" id="filedata" onchange="fileSelected();"/>
    </div>
	<div id="fileName"></div>
	<div id="fileSize"></div>
	<div id="fileType"></div>
	<div class="row">
	<input type="button" onclick="uploadFile()" value="Upload" />
    </div>
	<div id="progressNumber"></div>
</form>
  </div>
  <!-- ----------------------------------------------------------------------- -->
  <div id="message"></div>
</body>
</html>