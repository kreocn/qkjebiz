function ShowPage(v_aPage) {
	var $this = this;
	var url,CurrPage,re,CurrentPage,iurl,FirstPageUrl,PrevPageUrl,NextPageUrl,LastPageUrl,PageCount,prevpage,nextpage,PageStart,PageEnd,i,ipage;
	url=""+document.location;
	
	if (url.indexOf("Page=")==-1) {
		CurrPage=v_aPage || 1;
		CurrentPage=v_aPage || 1;
	}
	else {
		re=/(\S.*)(Page=\d*)(\S.*|\S*)/g;
		CurrentPage=url.replace(re,"$2");
		CurrentPage=CurrentPage.replace("Page=","");
		//re=/(?:\S{1,}Page=|\D.*)/g;
		//CurrentPage=url.replace(re,"");
		url=url.replace("&Page="+CurrentPage,""); 
		url=url.replace("Page="+CurrentPage+"&","");
		url=url.replace("Page="+CurrentPage,"");
	}
	url+=(url.indexOf("?")==-1)?"?":"&";
	url=url.replace("?&","?");
	url=url.replace("&&","&");
	
	this.current_url = url;
	
	this.FromatPage = function(str,StartNum,EndNum) {
		str+="";
		if (str.length>=1) {
			mynum=parseInt(str,10);
			if (isNaN(mynum)) {
				mynum=StartNum;
			}
			else {
				if (EndNum>-1) {
					mynum=(mynum<StartNum)?StartNum:mynum;
					mynum=(mynum>EndNum)?EndNum:mynum;
				}
				else {
					mynum=(mynum<StartNum)?StartNum:mynum;
				}
			}
		}
		else {
			mynum=StartNum;
		}
		return (mynum);
	};
	
	this.show = function(Tabstart,Tabend,CurrPageFont1,CurrPageFont2,PageCountFont1,PageCountFont2,PrePageFont1,PrePageFont2,RecCountFont1,RecCountFont2,FirstFont,PrevFont,NextFont,LastFont,Jump,PageNumFont1,PageNumFont2,PageNumFont3,PageNumFont4,LinkFont1,LinkFont2,LinkFont3,LinkFont4,iRecCount,iRecPerPage,iPageNum) {
		var show_html = "";
		RecCount=this.FromatPage(iRecCount,0,-1);
		RecPerPage=this.FromatPage(iRecPerPage,1,-1);
		PageNum=this.FromatPage(iPageNum,0,-1);
		PageCount=(RecCount%RecPerPage==0)?(RecCount/RecPerPage):(this.FromatPage((RecCount/RecPerPage),0,RecCount)+1);
		CurrPage=(PageCount>0)?(this.FromatPage(CurrentPage,1,PageCount)):(this.FromatPage(CurrentPage,0,PageCount));
		prevpage=this.FromatPage((CurrPage-1),1,PageCount);  
		nextpage=this.FromatPage((CurrPage+1),1,PageCount); 
		if (CurrPage<=1&&PageCount<=1) {
			FirstPageUrl="<a class='disabled'>"+LinkFont3+FirstFont+LinkFont4+"</a>";
			PrevPageUrl="<a class='disabled'>"+LinkFont3+PrevFont+LinkFont4+"</a>";
			NextPageUrl="<a class='disabled'>"+LinkFont3+NextFont+LinkFont4+"</a>";
			LastPageUrl="<a class='disabled'>"+LinkFont3+LastFont+LinkFont4+"</a>";
		}
		else if (CurrPage==1&&PageCount>1) {
			FirstPageUrl="<a class='disabled'>"+LinkFont3+FirstFont+LinkFont4+"</a>";
			PrevPageUrl="<a class='disabled'>"+LinkFont3+PrevFont+LinkFont4+"</a>";
			NextPageUrl="<a href=\""+url+"Page="+nextpage+"\" class='next'>"+LinkFont1+NextFont+LinkFont2+"</a>";
			LastPageUrl="<a href=\""+url+"Page="+PageCount+"\" class='last'>"+LinkFont1+LastFont+LinkFont2+"</a>";
		}
		else if (CurrPage==PageCount) {
			FirstPageUrl="<a href=\""+url+"Page=1\" class='first'>"+LinkFont1+FirstFont+LinkFont2+"</a>";
			PrevPageUrl="<a href=\""+url+"Page="+prevpage+"\" class='prev'>"+LinkFont1+PrevFont+LinkFont2+"</a>";
			NextPageUrl="<a class='disabled'>"+LinkFont3+NextFont+LinkFont4+"</a>";
			LastPageUrl="<a class='disabled'>"+LinkFont3+LastFont+LinkFont4+"</a>";
		}
		else {
			FirstPageUrl="<a href=\""+url+"Page=1\" class='first'>"+LinkFont1+FirstFont+LinkFont2+"</a>";
			PrevPageUrl="<a href=\""+url+"Page="+prevpage+"\" class='prev'>"+LinkFont1+PrevFont+LinkFont2+"</a>";
			NextPageUrl="<a href=\""+url+"Page="+nextpage+"\" class='next'>"+LinkFont1+NextFont+LinkFont2+"</a>";
			LastPageUrl="<a href=\""+url+"Page="+PageCount+"\" class='last'>"+LinkFont1+LastFont+LinkFont2+"</a>";
		}
		
		PageStart=this.FromatPage((CurrPage-PageNum),1,PageCount);  
		PageEnd=this.FromatPage((CurrPage+PageNum),1,PageCount);  
		
		show_html += CurrPageFont1+CurrPage+CurrPageFont2+PageCountFont1+PageCount+PageCountFont2;
		//show_html += PrePageFont1 + RecPerPage+PrePageFont2+RecCountFont1+RecCount+RecCountFont2+FirstPageUrl+PrevPageUrl;
		
		show_html += FirstPageUrl+PrevPageUrl;
		if (CurrPage>=1) {
			for (i=PageStart;i<=PageEnd;i++) {
				if (i!=CurrPage) {
					//document.write ("&nbsp;<A href=\""+url+"Page="+i+"\">"+PageNumFont1+i+PageNumFont2+"</A>&nbsp;");
					show_html += "<a href=\""+url+"Page="+i+"\" class='page'>"+PageNumFont1+i+PageNumFont2+"</a>";
				}
				else {
					//document.write ("&nbsp;"+PageNumFont3+i+PageNumFont4+"&nbsp;");
					show_html += "<a class='current'>"+PageNumFont3+i+PageNumFont4+"";
				}
			}
		}
		//document.write (NextPageUrl+LastPageUrl+Jump);
		show_html += NextPageUrl+LastPageUrl+Jump;
		//document.write ("<INPUT type=\"text\" id=\"oPage\" size=\"5\" maxlength=\"10\" onkeydown=\"if (event.keyCode==13) CheckPage("+PageCount+")\"><INPUT type=\"button\" value=\"Go\" onClick=\"CheckPage("+PageCount+")\">"+Tabend);
		//show_html += " <input type=\"text\" id=\"oPage\"  class=\"opage_input\" style=\"width: 30px;\" onkeydown=\"if (event.keyCode==13) CheckPage("+PageCount+")\"> 页 <button data-role=\"none\" onClick=\"CheckPage()\">跳转</button>  "+Tabend;
		show_html += RecCountFont1+RecCount+RecCountFont2;
		return show_html;
	};
	//recCount:资源总数
	//每页显示资源数
	//显示页的两边 显示的页的数量
	this.show2 = function(recCount,pageSize,iPageNum) {
		document.write(this.show("","","<a class='disabled'>","/","","</a>","","","<a class='disabled'>","</a>","首页","&lt;","&gt;","尾页","","","","","","","","","",recCount,pageSize,iPageNum));
	};
	
	this.show_html = function(recCount,pageSize,iPageNum) {
		return this.show("","","<a class='disabled'>","/","","</a>","","","<a class='disabled'>","</a>","首页","&lt;","&gt;","尾页","","","","","","","","","",recCount,pageSize,iPageNum);
	};
}

function CheckPage(v_aPage) {
	var to_Page = document.getElementById("oPage").value || 1;
	var url = window.location.href;
	if (url.indexOf("Page=") == -1) {
		CurrPage = v_aPage || 1;
		CurrentPage = v_aPage || 1;
	} else {
		re = /(\S.*)(Page=\d*)(\S.*|\S*)/g;
		CurrentPage = url.replace(re, "$2");
		CurrentPage = CurrentPage.replace("Page=", "");
		url = url.replace("&Page=" + CurrentPage, "");
		url = url.replace("Page=" + CurrentPage + "&", "");
		url = url.replace("Page=" + CurrentPage, "");
	}
	url += (url.indexOf("?") == -1) ? "?" : "&";
	url = url.replace("?&", "?");
	url = url.replace("&&", "&");
	url = url + "Page=" + to_Page;
	location.href = url;
}