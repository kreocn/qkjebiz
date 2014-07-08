function getMenu(n, path) {
	var cn = n || 0;
	var p = path || "";
	document.writeln("<div id=\"top_menu\">");
	document.writeln("<div class=\"menu_list\">");
	document.writeln("<ul>");
	document.writeln("<li " + (cn == 0 ? "class=\"active\"" : "") + "><a href=\"/\">首　页</a></li>");
	document.writeln("<li " + (cn == 1 ? "class=\"active\"" : "") + "><a href=\"" + p + "html/cellar/\">藏酒介绍</a></li>");
	document.writeln("<li " + (cn == 2 ? "class=\"active\"" : "") + "><a href=\"" + p + "html/ware/\">岩窖洞藏</a></li>");
	document.writeln("<li " + (cn == 3 ? "class=\"active\"" : "") + "><a href=\"" + p + "html/news/\">藏酒动态</a></li>");
	document
			.writeln("<li " + (cn == 4 ? "class=\"active\"" : "") + "><a href=\"" + p + "html/contact/\">联系我们</a></li>");
	document.writeln("</ul>");
	document.writeln("<div class=\"clear\"></div>");
	document.writeln("</div>");
	document.writeln("</div>");
}

function getFooter(path) {
	var p = path || "";
	document.writeln("<div id=\"footer\">");
	document.writeln("<div class=\"foot_sep\"></div>");
	document.writeln("<div class=\"fav_link\">");
	document.writeln("<p class=\"bb\">");
	document.writeln("<a href=\"http://www.qkj.com.cn\">青青稞酒股份有限公司</a> <b>|</b>");
	document.writeln("<a href=\"http://www.qkjxs.com\">青稞酒销售有限公司</a> <b>|</b>");
	document.writeln("<a href=\"http://hzjl.tmall.com/\">互助酒类专营店</a> <b>|</b>");
	document.writeln("<a href=\"http://e.weibo.com/qhhzqkjxsyxgs?topnav=11\">新浪官方微博</a> <b>|</b>");
	document.writeln("<a href=\"http://t.qq.com/qhhzqkjxsyxgs\">腾讯官方微博</a> ");
	document.writeln("</p>");
	document.writeln("</div>");
	document.writeln("<div class=\"fav_link\">");
	document.writeln("<p>");
	document.writeln("<a href=\"/\">网站首页</a>");
	document.writeln("<a href=\"" + p + "html/cellar/\">藏酒介绍</a>");
	document.writeln("<a href=\"" + p + "html/ware/\">岩窖洞藏</a>");
	document.writeln("<a href=\"" + p + "html/news/\">藏酒动态</a>");
	document.writeln("<a href=\"" + p + "html/help/\">常见问题</a>");
	document.writeln("<a href=\"" + p + "html/sell/\">合作伙伴</a>");
	document.writeln("<a href=\"" + p + "html/servise/\">客户服务</a>");
	document.writeln("<a href=\"" + p + "html/contact/\">联系我们</a>");
	document.writeln("<a href=\"" + p + "html/intro/\">公司简介</a>");
	document.writeln("<a href=\"" + p + "html/express/\">配送方式</a>");
	document.writeln("<em>© 2014 青青稞酒 版权所有</em>");
	document.writeln("</p>");
	document.writeln("<p>");
	document.writeln("<span>ICP备案号:</span>");
	document.writeln("<span>京ICP备12037065号</span>");
	document.writeln("<b>|</b>");
	document.writeln("<a href=\"#\">站长统计</a>");
	document.writeln("</p>");
	document.writeln("</div>");
	document.writeln("</div>");
}

function getLoginFooter(root_path) {
	var p = root_path || "";
	document.writeln("<div id=\"footer\">");
	document.writeln("<div class=\"foot_sep\"></div>");
	document.writeln("<div class=\"fav_link\">");
	document.writeln("<p class=\"bb\">");
	document.writeln("<a href=\"http://www.qkj.com.cn\">青青稞酒股份有限公司</a> <b>|</b>");
	document.writeln("<a href=\"http://www.qkjxs.com\">青稞酒销售有限公司</a> <b>|</b>");
	document.writeln("<a href=\"http://hzjl.tmall.com/\">互助酒类专营店</a> <b>|</b>");
	document.writeln("<a href=\"http://e.weibo.com/qhhzqkjxsyxgs?topnav=11\">新浪官方微博</a> <b>|</b>");
	document.writeln("<a href=\"http://t.qq.com/qhhzqkjxsyxgs\">腾讯官方微博</a> ");
	document.writeln("</p>");
	document.writeln("</div>");
	document.writeln("<div class=\"fav_link\">");
	document.writeln("<p>");
	document.writeln("<a href=\"/\">网站首页</a>");
	document.writeln("<a href=\"" + p + "html/cellar/\">藏酒介绍</a>");
	document.writeln("<a href=\"" + p + "html/ware/\">岩窖洞藏</a>");
	document.writeln("<a href=\"" + p + "html/news/\">藏酒动态</a>");
	document.writeln("<a href=\"" + p + "html/help/\">常见问题</a>");
	document.writeln("<a href=\"" + p + "html/sell/\">合作伙伴</a>");
	document.writeln("<a href=\"" + p + "html/servise/\">客户服务</a>");
	document.writeln("<a href=\"" + p + "html/contact/\">联系我们</a>");
	document.writeln("<a href=\"" + p + "html/intro/\">公司简介</a>");
	document.writeln("<a href=\"" + p + "html/express/\">配送方式</a>");
	document.writeln("<em>© 2014 青青稞酒 版权所有</em>");
	document.writeln("</p>");
	document.writeln("<p>");
	document.writeln("<span>ICP备案号:</span>");
	document.writeln("<span>京ICP备12037065号</span>");
	document.writeln("<b>|</b>");
	document.writeln("<a href=\"#\">站长统计</a>");
	document.writeln("</p>");
	document.writeln("</div>");
	document.writeln("</div>");
}