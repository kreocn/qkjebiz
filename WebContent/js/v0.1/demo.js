$(function(){
	$(".pagination").each(function(i){
		var opt = eval("(" + $(this).attr("data") + ")");
		$(this).paging(opt['count'], { format : "<(qq-)nncnn(-pp)>",
		perpage : opt['size'],
		lapping : 0,
		page : opt['cur'],
		onSelect : function(page){
		// alert(page);
		// var data = this.slice;
		// alert(data[0]);
		// alert(data[1]);
		},
		onFormat : function(type){
			switch (type) {
			case 'block':
				if (!this.active) return '<a class="disabled">' + this.value + '</a>';
				else if (this.value != this.page) return '<a href="#' + this.value + '">' + this.value + '</a>';
				return '<a class="current">' + this.value + '</a>';
			case 'right':
			case 'left':
				if (!this.active) { return ''; }
				return '<a href="#' + this.value + '">' + this.value + '</a>';
			case 'next':
				if (this.active) return '<a href="#' + this.value + '" class="next">&gt;</a>';
				return '<a class="disabled">&gt;</span>';
			case 'prev':
				if (this.active) return '<a href="#' + this.value + '" class="prev">&lt;</a>';
				return '<a class="disabled">&lt;</span>';
			case 'first':
				if (this.active) return '<a href="#' + this.value + '" class="first">First</a>';
				return '<a class="disabled">首页</span>';
			case 'last':
				if (this.active) return '<a href="#' + this.value + '" class="last">Last</a>';
				return '<a class="disabled">末页</span>';
			case "leap":
				if (this.active) return "   ";
				return "";
			case 'fill':
				if (this.active) return "..";
				return "";
			}
		} });
	});
});