<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>天佑德藏酒 -- ${it:i18n("HTML_NAME")}</title>
<link rel="stylesheet" href="<c:url value="/include/jQuery/style.ui.lightness/jquery-ui.min.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/css.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/page.css" />" />
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery.smartFloat.js" />"></script>
<script type="text/javascript">
var $page_tab;
$(function() {
	$page_tab = $(".mpanel").tabs();
	// 自动悬浮
	$(".float_buy").smartFloat();
	$("#tab_title li>a").each(function(i,n){
		$("#tab_title").data($(n).attr("href").substr(1),i);
	});
	
	$page_tab.on("tabsactivate", function(event, ui) {
		$(".img_a").fadeOut(100,function(){
			$(".img_a").css("background-image"," url('"+ui.newTab.attr("si")+"')");
		}).fadeIn(800);
	});
});
function activePage(s) {
	$page_tab.tabs("option", "active", $("#tab_title").data(s));
}
</script>
</head>
<body>
	<c:import url="/jsp/fore/top.jsp" />
	<div id="content">
		<div class="sep15"></div>
		<div class="banner">
			<div class="img_a"></div>
		</div>
		<div class="mpanel">
			<ul id="tab_title">
				<li si="http://qkjchina.com/ckframe/userfiles/images/cangjiu/product_main.jpg"><a href="#cellar_info">藏酒介绍</a></li>
			</ul>
			<div id="cellar_info">
				<div class="cellar_info_text">
					<p class="ttitle">青海互助青稞酒股份有限公司</p>
					<p>　　青海互助青稞酒股份有限公司(青青稞酒，证券代码: 002646) 位于青海省互助土族自治县威远镇西街6号，是中国青稞酒之源。公司是全国最大的青稞酒生产基地和受国家保护的青稞酒原产地。公司前身为1952年由青海互助县人民政府整合威远镇八大酒作坊组建而成的国营互助酒厂; 1992年，更名为青海省青稞酒厂; 2005年，酒厂改制， 改名为互助青稞酒有限公司; 2011年，公司更名为青海互助青稞酒股份有限公司并成功登陆A股市场。</p>
					<br />
					<p>　　青海互助青稞酒股份有限公司作为青稞酒的龙头企业。是"2个唯一"企业: 青海省唯一一家白酒上市企业;白酒行业内唯一一家被《福布斯》评为2013年中国最具潜力中小企业上市40强的企业; 同时公司产品先后荣获"中华老字号"、"有机产品"等荣誉。公司生产的青稞酒属清香型白酒，被中国酿酒工业协会认定为"中国白酒清香型{青稞原料)代表"。产品具有"地理环境、酿酒原料、大曲配料、制酒工艺、发酵设备、产品风格"六大方面的独特之处。</p>
					<p class="ttitle ttitle2">天佑德·藏酒</p>
					<p>　　"天佑德"作为青海互助青稞酒股份有限公司(股票代码: 002646)旗下最具传承性的高端品牌，有着四百多年的历史。</p>
					<br />
					<p>　　天佑德青稞酒在传承明清时期驰名西北的天佑德酿酒作坊古法酿酒工艺的基础上打造高端定制酒的尊贵品质。</p>
					<br />
					<p>　　天佑德·藏酒以"属于你的那坛酒"为品牌主张; 以"整坛定制、专属害蘸"为品牌区隔，以天佑德青稞酒的品牌基因、品类优势和具有收藏价值的品质特点为晶牌支撑点，以懂得品位和追求精英高尚生活的消费者为营销对象，依托公司天佑德酒庄项目倾力打造的一款具有收藏和投资价值的高品质定制酒。让消费者在尊享天佑德高品质酒体的同时可以享受到个性化定制、360度营控和一条龙式服务带来全新的消费体验。</p>
					<p class="ttitle ttitle2">什么是私人藏酒</p>
					<p>　　私人藏酒从酒窖酿酒出来开始就购买按传统工艺和纯粮酿造的优质清香型白酒基酒，以欧美贵族般奢华体验与享受的私人管家般尊贵服务于您，为企业、机构和个人彻底降低用酒成本的创新消费体验，面向社会高端人群和嗜好高品质清香型白酒的个人推出的私人藏酒包括：企业藏酒、个人藏酒、姓氏藏酒、机构藏酒、私人藏酒、私人酒庄，客户购买后，可选择自行珍藏方式：可一次性运走自行珍藏；也可托管珍藏，即授权我方委托酒厂私人藏酒酒库托管珍藏。私人藏酒同时还开创了白酒新的投资理财方式，清香型白酒因其时间价值、生产工艺和边际成本高，因此私人藏酒是抵御通货膨胀的最佳投资品（历史数据显示清香型白酒具有每年增长20%的收益属性）。</p>
					<br />
					<p>　　私人藏酒，保证每一批封坛藏酒都经过酒厂组织名师精心勾调，纯粮酿造，完全按照传统工艺生产。融汇清香白酒酿造之集大成者资源，具有与生俱来的稀有属性，是最具市场潜力和发展前景的黄金液体。</p>
					<br />
					<p>　　经过岁月的窖藏，封坛的私人藏酒价值会成倍增长。所以，不但藏酒会越来越香，其收藏价值也将会有巨大提高，让您用酒理财两不误。</p>
					<p class="ttitle ttitle2">私人藏酒的优势</p>
					<p>☆身份象征：专属企业、机构和个人身份的私人藏酒，贵族身份与奢华体验。</p>
					<p>☆招待客户：专属更显珍贵 独具匠心方显卓越 唯一方显尊贵与气度。</p>
					<p>☆礼品馈赠：送礼，私人贵族身份定制凸显送礼者的心意与用心程度。</p>
					<p>☆节日用酒：用酒时刻不用愁，拥有专属的私人封坛藏酒，贵族身份尽在掌握。</p>
					<p>☆降低成本：省掉所有中间环节，花最少的钱买最好的清香型白酒。</p>
					<p>☆私人酒庄：“不建酒厂 拥有酒厂”——拥有专属的私人酒庄。</p>
					<p>☆投资增值：最佳投资理财产品，巨大升值空间，零风险投资最佳选择。</p>
				</div>
			</div>
			
			<c:set var="tab_title_html" value="" />
			<c:forEach var="item" items="${goodss}" varStatus="sta">
			<div id="cellar_info_${item.uuid}">
				<div class="cellar_info_text">
					${item.goods_description}
				</div>
			</div>
			<c:set var="tab_title_html">
				${tab_title_html}<li si="${item.big_img}"><a href="#cellar_info_${item.uuid}">${item.goods_name}</a></li>
			</c:set>
			</c:forEach>
			<script type="text/javascript">
			$("#tab_title").append('${tab_title_html}');
			</script>
		</div>
	</div>
	<div class="float_buy">
		<div class="buy_trend">
			<div class="buy_trend_icon icon_img"></div>
			<div class="top_trend">
				<span class="trend_title">精品藏酒,接受预定</span> <span class="trend_time">2014-03-16</span>
			</div>
			<a href="/jsp/fore/contact.jsp" class="buy_button">立即预定</a>
		</div>
	</div>
	<c:import url="/jsp/fore/footer.jsp" />
</body>
</html>