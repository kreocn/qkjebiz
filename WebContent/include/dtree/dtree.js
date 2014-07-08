/*--------------------------------------------------|
| dTree 2.05 | www.destroydrop.com/javascript/tree/ |
|---------------------------------------------------|
| Copyright (c) 2002-2003 Geir Landr�               |
|                                                   |
| This script can be used freely as long as all     |
| copyright messages are intact.                    |
|                                                   |
| Updated: 17.04.2003                               |
|--------------------------------------------------*/

// Node object
function Node(id, pid, name, url, title, target, icon, iconOpen, open, isChecked) {
	this.id = id;
	this.pid = pid;
	this.name = name;
	this.url = url;
	this.title = title;
	this.target = target;
	this.icon = icon;
	this.iconOpen = iconOpen;
	this._io = open || false;
	this._is = false;
	this._ls = false;
	this._hc = false;	// 判断此Node是否是纯叶子节点(下面没有子节点的节点)		this._hp = false;	// 判断此Node是否有父节点		this._ai = 0;
	this._p;		this.isChecked = isChecked;
};

// Tree object
function dTree(objName) {
	this.config = {
		target				: null,
		folderLinks			: true,
		useSelection		: true,
		useCookies			: true,
		useLines			: true,
		useIcons			: true,
		useStatusText		: false,
		closeSameLevel		: false,
		inOrder				: false,				isMenu				: false,	// 如果是Menu形式,所有有子节点的Node的Url将会失效,代之的功能是打开子节点				check				: 0,	// 0:不加 1:复选框(checkbox) 2:单选框(radio)				isControlParent		: false,	// 当check为1时,确定是否要操作父节点的选择情况,详细见程序注释说明				isAddNoRootNode		: false,	// 不在根节点(-1)从属下的节点,是否也要显示				extra_radio_type01	: false	// 增加特殊radio框,设置权限时专用,在权限后增加 全局 部门 个人 选项	};
	this.icon = {
		root				: 'img/base.gif',
		folder			: 'img/folder.gif',
		folderOpen	: 'img/folderopen.gif',
		node				: 'img/page.gif',
		empty				: 'img/empty.gif',
		line				: 'img/line.gif',
		join				: 'img/join.gif',
		joinBottom	: 'img/joinbottom.gif',
		plus				: 'img/plus.gif',
		plusBottom	: 'img/plusbottom.gif',
		minus				: 'img/minus.gif',
		minusBottom	: 'img/minusbottom.gif',
		nlPlus			: 'img/nolines_plus.gif',
		nlMinus			: 'img/nolines_minus.gif'
	};
	this.obj = objName;
	this.aNodes = [];
	this.aIndent = [];
	this.root = new Node(-1);
	this.selectedNode = null;
	this.selectedFound = false;
	this.completed = false;
};

// Adds a new node to the node array
dTree.prototype.add = function(id, pid, name, url, title, target, icon, iconOpen, open, isChecked) {
	this.aNodes[this.aNodes.length] = new Node(id, pid, name, url, title, target, icon, iconOpen, open, isChecked);
};

// Open/close all nodes
dTree.prototype.openAll = function() {
	this.oAll(true);
};
dTree.prototype.closeAll = function() {
	this.oAll(false);
};

// Outputs the tree to the page
dTree.prototype.toString = function() {
	var str = '<div class="dtree">\n';
	if (document.getElementById) {
		if (this.config.useCookies) this.selectedNode = this.getSelected();
		str += this.addNode(this.root);		if(this.config.isAddNoRootNode) {			for ( var i = 0; i < this.aNodes.length; i++) {				var cnn = this.aNodes[i];				if(!cnn._hp && cnn.pid && cnn.pid!=this.root.id) {					//如需增加,则添加新树					str += this.addNode(new Node(cnn.pid));				}			}		}
	} else str += 'Browser not supported.';
	str += '</div>';
	if (!this.selectedFound) this.selectedNode = null;
	this.completed = true;
	return str;
};

// Creates the tree structure
dTree.prototype.addNode = function(pNode) {
	var str = '';
	var n=0;
	if (this.config.inOrder) n = pNode._ai;	
	for (n; n<this.aNodes.length; n++) {				if (this.aNodes[n].pid == pNode.id) {						var cn = this.aNodes[n];						cn._p = pNode;						cn._ai = n;						this.setCS(cn);
			
			if (!cn.target && this.config.target) cn.target = this.config.target;
			if (cn._hc && !cn._io && this.config.useCookies) cn._io = this.isOpen(cn.id);
			if (!this.config.folderLinks && cn._hc) cn.url = null;
			if (this.config.useSelection && cn.id == this.selectedNode && !this.selectedFound) {
					cn._is = true;
					this.selectedNode = n;
					this.selectedFound = true;
			}
			str += this.node(cn, n);
			if (cn._ls) break;
		}
	}
	return str;
};

// Creates the node icon, url and text
dTree.prototype.node = function(node, nodeId) {	var str = "";	if(this.config.isMenu && node._hc) {		if(node.pid==-1) {			str = '<div class="dTreeNode_Root">' + this.indent(node, nodeId);		} else if(node.pid==0) {			str = '<div class="dTreeNode_Title" onclick="javascript: ' + this.obj + '.o(' + nodeId + ');">' + this.indent(node, nodeId);		} else {			str = '<div class="dTreeNode_Title2" onclick="javascript: ' + this.obj + '.o(' + nodeId + ');">' + this.indent(node, nodeId);		}			} else {		str = '<div class="dTreeNode">' + this.indent(node, nodeId);	}
	if (this.config.useIcons) {
		if (!node.icon) node.icon = (this.root.id == node.pid) ? this.icon.root : ((node._hc) ? this.icon.folder : this.icon.node);
		if (!node.iconOpen) node.iconOpen = (node._hc) ? this.icon.folderOpen : this.icon.node;
		if (this.root.id == node.pid) {
			node.icon = this.icon.root;
			node.iconOpen = this.icon.root;
		}
		str += '<img id="i' + this.obj + nodeId + '" src="' + ((node._io) ? node.iconOpen : node.icon) + '" alt="i' + this.obj + nodeId + '" />';
	}	// 以下为增加了checkbox的页面	if(this.config.check!=0){		str+='<span class="checkArea">';		var check_type = "checkbox";		var onclick_op = 'onclick="javascript:'+this.obj+'.cc('+nodeId+')"';		var title_area = "";		if(this.config.check==1) {			check_type = "checkbox";			onclick_op = 'onclick="javascript:'+this.obj+'.cc('+nodeId+')"';		} if(this.config.check==2) {			check_type = "radio";			onclick_op = "";		}		if (node.title) {			title_area = 'title="' + node.title + '"';		}		if(node.pid==-1)			str+= '<input type="'+check_type+'" '+title_area+' style="display: none;" name="c' + this.obj + '" id="c'+ this.obj + nodeId + '" value="'+this.aNodes[nodeId].id+'" '+onclick_op+' />';		else {			if(node.isChecked) 				str+= '<input type="'+check_type+'" '+title_area+' name="c' + this.obj + '" id="c'+ this.obj + nodeId + '" value="'+this.aNodes[nodeId].id+'" checked '+onclick_op+' />';			else str+= '<input type="'+check_type+'" '+title_area+' name="c' + this.obj + '" id="c'+ this.obj + nodeId + '" value="'+this.aNodes[nodeId].id+'" '+onclick_op+' />';		}		str+='</span>';	}		if(this.config.isMenu && node._hc && node.url) {		str += '<a href="javascript: void(0);" class="node">';	} else if (node.url) {
		str += '<a id="s' + this.obj + nodeId + '" class="' + ((this.config.useSelection) ? ((node._is ? 'nodeSel' : 'node')) : 'node') + '" href="' + node.url + '"';
		if (node.title) str += ' title="' + node.title + '"';
		if (node.target) str += ' target="' + node.target + '"';
		if (this.config.useStatusText) str += ' onmouseover="window.status=\'' + node.name + '\';return true;" onmouseout="window.status=\'\';return true;" ';
		// if (this.config.useSelection && ((node._hc &&		// this.config.folderLinks) || !node._hc))		if (this.config.useSelection && node._hc && this.config.folderLinks)
			str += ' onclick="javascript: ' + this.obj + '.s(' + nodeId + ');"';
		str += '>';
	} else if ((!this.config.folderLinks || !node.url || !(this.config.check!=0)) && node._hc && node.pid != this.root.id) {		str += '<a href="javascript: ' + this.obj + '.o(' + nodeId + ');" class="node">';	}		if(this.config.check!=0){		if(node.pid!=-1)			str+= '<label for="c'+ this.obj + nodeId + '">';	}
	str += node.name;		if(this.config.check!=0){		if(node.pid!=-1)			str+= '</label>';	}
	if (node.url || ((!this.config.folderLinks || !node.url || !(this.config.check!=0)) && node._hc)) {		str += '</a>';	}		if(this.config.extra_radio_type01) {		str += '<span class="extra_check">';		str += '<input type="radio" name="'+this.aNodes[nodeId].id+'" id="USER_'+this.aNodes[nodeId].id + nodeId +'" value="0"> <label for="USER_'+this.aNodes[nodeId].id + nodeId +'">个人</label>';		str += '<input type="radio" name="'+this.aNodes[nodeId].id+'" id="DEPT_'+this.aNodes[nodeId].id + nodeId +'" value="1"> <label for="DEPT_'+this.aNodes[nodeId].id + nodeId +'">部门</label>';		str += '<input type="radio" name="'+this.aNodes[nodeId].id+'" id="GLOBAL_'+this.aNodes[nodeId].id + nodeId +'" value="2"> <label for="GLOBAL_'+this.aNodes[nodeId].id + nodeId +'">全局</label>';		str += '</span>';	}
	str += '</div>';
	if (node._hc) {
		str += '<div id="d' + this.obj + nodeId + '" class="clip" style="display:' + ((this.root.id == node.pid || node._io) ? 'block' : 'none') + ';">';
		str += this.addNode(node);
		str += '</div>';
	}
	this.aIndent.pop();
	return str;
};

// Adds the empty and line icons
dTree.prototype.indent = function(node, nodeId) {
	var str = '';
	if (this.root.id != node.pid) {
		for (var n=0; n<this.aIndent.length; n++)
			str += '<img src="' + ( (this.aIndent[n] == 1 && this.config.useLines) ? this.icon.line : this.icon.empty ) + '" '+(this.config.isMenu?'width="8"':'')+' alt="" />';
		(node._ls) ? this.aIndent.push(0) : this.aIndent.push(1);
		if (node._hc) {						if(this.config.isMenu) {				str += '<a href="javascript: void(0);"><img id="j' + this.obj + nodeId + '" src="';			} else {				str += '<a href="javascript: ' + this.obj + '.o(' + nodeId + ');"><img id="j' + this.obj + nodeId + '" src="';			}			
			if (!this.config.useLines) str += (node._io) ? this.icon.nlMinus : this.icon.nlPlus;
			else str += ( (node._io) ? ((node._ls && this.config.useLines) ? this.icon.minusBottom : this.icon.minus) : ((node._ls && this.config.useLines) ? this.icon.plusBottom : this.icon.plus ) );
			str += '" alt="" /></a>';
		} else str += '<img src="' + ( (this.config.useLines) ? ((node._ls) ? this.icon.joinBottom : this.icon.join ) : this.icon.empty) + '" '+(this.config.isMenu?'width="8"':'')+' alt="" />';
	}
	return str;
};
// Checks if a node has any children and if it is the last sibling and has any// parent
dTree.prototype.setCS = function(node) {
	var lastId;
	for (var n=0; n<this.aNodes.length; n++) {
		if (this.aNodes[n].pid == node.id) node._hc = true;				if (this.aNodes[n].id == node.pid) node._hp = true;		
		if (this.aNodes[n].pid == node.pid) lastId = this.aNodes[n].id;
	}	
	if (lastId==node.id) node._ls = true;
};

// Returns the selected node
dTree.prototype.getSelected = function() {
	var sn = this.getCookie('cs' + this.obj);
	return (sn) ? sn : null;
};

// Highlights the selected node
dTree.prototype.s = function(id) {
	if (!this.config.useSelection) return;
	var cn = this.aNodes[id];
	if (cn._hc && !this.config.folderLinks) return;
	if (this.selectedNode != id) {
		if (this.selectedNode || this.selectedNode==0) {
			eOld = document.getElementById("s" + this.obj + this.selectedNode);
			eOld.className = "node";
		}
		eNew = document.getElementById("s" + this.obj + id);
		eNew.className = "nodeSel";
		this.selectedNode = id;
		if (this.config.useCookies) this.setCookie('cs' + this.obj, cn.id);
	}
};

// Toggle Open or close
dTree.prototype.o = function(id) {
	var cn = this.aNodes[id];
	this.nodeStatus(!cn._io, id, cn._ls);
	cn._io = !cn._io;
	if (this.config.closeSameLevel) this.closeLevel(cn);
	if (this.config.useCookies) this.updateCookie();
};

// Open or close all nodes
dTree.prototype.oAll = function(status) {
	for (var n=0; n<this.aNodes.length; n++) {
		if (this.aNodes[n]._hc && this.aNodes[n].pid != this.root.id) {
			this.nodeStatus(status, n, this.aNodes[n]._ls)
			this.aNodes[n]._io = status;
		}
	}
	if (this.config.useCookies) this.updateCookie();
};

// Opens the tree to a specific node
dTree.prototype.openTo = function(nId, bSelect, bFirst) {
	if (!bFirst) {
		for (var n=0; n<this.aNodes.length; n++) {
			if (this.aNodes[n].id == nId) {
				nId=n;
				break;
			}
		}
	}
	var cn=this.aNodes[nId];
	if (cn.pid==this.root.id || !cn._p) return;
	cn._io = true;
	cn._is = bSelect;
	if (this.completed && cn._hc) this.nodeStatus(true, cn._ai, cn._ls);
	if (this.completed && bSelect) this.s(cn._ai);
	else if (bSelect) this._sn=cn._ai;
	this.openTo(cn._p._ai, false, true);
};

// Closes all nodes on the same level as certain node
dTree.prototype.closeLevel = function(node) {
	for (var n=0; n<this.aNodes.length; n++) {
		if (this.aNodes[n].pid == node.pid && this.aNodes[n].id != node.id && this.aNodes[n]._hc) {
			this.nodeStatus(false, n, this.aNodes[n]._ls);
			this.aNodes[n]._io = false;
			this.closeAllChildren(this.aNodes[n]);
		}
	}
}

// Closes all children of a node
dTree.prototype.closeAllChildren = function(node) {
	for (var n=0; n<this.aNodes.length; n++) {
		if (this.aNodes[n].pid == node.id && this.aNodes[n]._hc) {
			if (this.aNodes[n]._io) this.nodeStatus(false, n, this.aNodes[n]._ls);
			this.aNodes[n]._io = false;
			this.closeAllChildren(this.aNodes[n]);		
		}
	}
}

// Change the status of a node(open or closed)
dTree.prototype.nodeStatus = function(status, id, bottom) {
	eDiv	= document.getElementById('d' + this.obj + id);
	eJoin	= document.getElementById('j' + this.obj + id);
	if (this.config.useIcons) {
		eIcon	= document.getElementById('i' + this.obj + id);
		eIcon.src = (status) ? this.aNodes[id].iconOpen : this.aNodes[id].icon;
	}
	eJoin.src = (this.config.useLines)?
	((status)?((bottom)?this.icon.minusBottom:this.icon.minus):((bottom)?this.icon.plusBottom:this.icon.plus)):
	((status)?this.icon.nlMinus:this.icon.nlPlus);
	eDiv.style.display = (status) ? 'block': 'none';
};


// [Cookie] Clears a cookie
dTree.prototype.clearCookie = function() {
	var now = new Date();
	var yesterday = new Date(now.getTime() - 1000 * 60 * 60 * 24);
	this.setCookie('co'+this.obj, 'cookieValue', yesterday);
	this.setCookie('cs'+this.obj, 'cookieValue', yesterday);
};

// [Cookie] Sets value in a cookie
dTree.prototype.setCookie = function(cookieName, cookieValue, expires, path, domain, secure) {	
	document.cookie =
		escape(cookieName) + '=' + escape(cookieValue)
		+ (expires ? '; expires=' + expires.toGMTString() : '')
		+ (path ? '; path=' + path : '')
		+ (domain ? '; domain=' + domain : '')
		+ (secure ? '; secure' : '');
};

// [Cookie] Gets a value from a cookie
dTree.prototype.getCookie = function(cookieName) {
	var cookieValue = '';
	var posName = document.cookie.indexOf(escape(cookieName) + '=');
	if (posName != -1) {
		var posValue = posName + (escape(cookieName) + '=').length;
		var endPos = document.cookie.indexOf(';', posValue);
		if (endPos != -1) cookieValue = unescape(document.cookie.substring(posValue, endPos));
		else cookieValue = unescape(document.cookie.substring(posValue));
	}
	return (cookieValue);
};

// [Cookie] Returns ids of open nodes as a string
dTree.prototype.updateCookie = function() {
	var str = '';
	for (var n=0; n<this.aNodes.length; n++) {
		if (this.aNodes[n]._io && this.aNodes[n].pid != this.root.id) {
			if (str) str += '.';
			str += this.aNodes[n].id;
		}
	}
	this.setCookie('co' + this.obj, str);
};

// [Cookie] Checks if a node id is in a cookie
dTree.prototype.isOpen = function(id) {
	var aOpen = this.getCookie('co' + this.obj).split('.');
	for (var n=0; n<aOpen.length; n++)
		if (aOpen[n] == id) return true;
	return false;
};/** * 设定CheckBox的勾选情况,checkedStr是逗号隔开已选的的node_id *  * @param checkedStr */dTree.prototype.setCheck = function(checkedStr) {	// var	if(!(checkedStr==null||checkedStr=="")) {		var checkedList = checkedStr.split(",");		for ( var i = 0; i < this.aNodes.length; i++) {			if(this.isIn(this.aNodes[i].id,checkedList)) {				this.aNodes[i].isChecked = true;				// document.getElementById("c"+this.obj+""+i).checked = true;			}		}			}}/** * 设定CheckBox的勾选情况,checked是单个的node_id *  * @param checked */dTree.prototype.setCheckOne = function(checked) {	// var	if(!(checked==null||checked=="")) {		for ( var i = 0; i < this.aNodes.length; i++) {						if(this.aNodes[i].id = checked) {				this.aNodes[i].isChecked = true;			}		}			}}dTree.prototype.isIn = function(obj,objs) {	for ( var i = 0; i < objs.length; i++) {		if(obj==objs[i]) {			return true;		}	}	return false;}dTree.prototype.cc=function(nodeId){   	      var cs = document.getElementById("c"+this.obj+nodeId).checked;       var n,node = this.aNodes[nodeId];       var len =this.aNodes.length;         for (n=0; n<len; n++) {             if (this.aNodes[n].pid == node.id) {                             document.getElementById("c"+this.obj+n).checked=cs;                          this.cc(n);                      }                }    // 对于父节点的操作    if(this.config.check==1 && this.config.isControlParent) {    	if (cs == false) { // 父节点下所有子节点都已取消选择,则父节点也取消选择    		var clicknode = node   		do {    			for (j = 0; j < len; j++) {    				if (this.aNodes[j].pid == clicknode.pid && document.getElementById("c" + this.obj + j).checked == true) {    					return;    				}    			}    			if (j == len) {    				for (k = 0; k < len; k++) {    					if (this.aNodes[k].id == clicknode.pid) {    						document.getElementById("c" + this.obj + k).checked = false;    						clicknode = this.aNodes[k];    						break;    					}    				}    			}    			break;    		} while (clicknode.pid != -1);    	}    	if (cs == true) { // 父节点下所有子节点都已选择,则父节点也选择    		var pid = node.pid;    		var bSearch;    		do {    			bSearch = false;    			for (n = 0; n < len; n++) {    				if (this.aNodes[n].id == pid) {    					document.getElementById("c" + this.obj + n).checked = true;    					pid = this.aNodes[n].pid;    					bSearch = true;    					break;    				}    			}    		} while (bSearch == true);    	}    }};

// If Push and pop is not implemented by the browser
if (!Array.prototype.push) {
	Array.prototype.push = function array_push() {
		for(var i=0;i<arguments.length;i++)
			this[this.length]=arguments[i];
		return this.length;
	}
};
if (!Array.prototype.pop) {
	Array.prototype.pop = function array_pop() {
		lastElement = this[this.length-1];
		this.length = Math.max(this.length-1,0);
		return lastElement;
	}
};