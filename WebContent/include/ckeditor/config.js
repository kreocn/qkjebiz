/**
 * @license Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights
 *          reserved. For licensing, see LICENSE.md or
 *          http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function(config) {
	config.language = 'zh-cn';
	//config.toolbar = "Full";
	config.filebrowserBrowseUrl = 'include/ckfinder/ckfinder.html';
	config.filebrowserImageBrowseUrl = 'include/ckfinder/ckfinder.html?type=Images';
	config.filebrowserFlashBrowseUrl = 'include/ckfinder/ckfinder.html?type=Flash';
	config.filebrowserUploadUrl = 'include/ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Files';
	config.filebrowserImageUploadUrl = 'include/ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Images';
	config.filebrowserFlashUploadUrl = 'include/ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Flash';
	config.filebrowserWindowWidth = '1000';
	config.filebrowserWindowHeight = '700';

	config.toolbar_MyToolBars = [
			['Source', '-','Undo', 'Redo','RemoveFormat'],
			['Font', 'FontSize','Bold', 'Italic', 'Underline', 'Strike','TextColor', 'BGColor','JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'],
			['Link', 'Unlink', 'Image', 'Flash', 'Table','Maximize', 'ShowBlocks']
	];
	config.toolbar = "MyToolBars";	
	config.font_names =
		"宋体;" +
		"黑体;" +
		"微软雅黑;" +		
		"楷体;" +
		"隶书;" +
		"幼圆;" +
	    "Arial/Arial, Helvetica, sans-serif;" +
	    "Roman/Times New Roman, Times, serif;" +
	    "Verdana";
};
