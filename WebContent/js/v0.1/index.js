$(document).on("pagecreate", ".jqm-demos", function(event){
	var page = $(this);
	// Global navmenu panel
	$(".jqm-navmenu-panel ul").listview();
	$(".jqm-navmenu-link").on("click", function(){
		page.find(".jqm-navmenu-panel:not(.jqm-panel-page-nav)").panel("open");
	});
});