/**
 * xhexitor的封装简化版
 */
function createHtmlEditor(selector, upload_url){
	upload_url = upload_url || "/upload/put";
	var $text = $(selector);
	$text.css("width", "100%");
	$text.css("min-height", "300px");
	$text.css("display", "none");
	var editor = $text
			.xheditor({
				tools : 'Cut,Copy,Paste,Pastetext,SelectAll,|,Blocktag,Fontface,FontSize,Bold,Italic,Underline,Strikethrough,FontColor,BackColor,Removeformat,|,Align,Outdent,Indent,|,Hr,List,Table,|,Link,Img,|,Source,Preview,Fullscreen',
				upImgUrl : "/upload/put",
				upImgExt : "jpg,jpeg,gif,png",
				upLinkUrl : "/upload/put",
				upLinkExt : "zip,rar,7z,txt,doc,docx,xls,xlsx,ppt,pptx",
				// html5Upload : false,
				// upMultiple : '1',
				skin : 'nostyle' });
	// editor.toggleFullscreen(true);
	return editor;
}