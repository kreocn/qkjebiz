function showE(obj) {
	var str;
	for (i in obj) {
		str += " " + i;
	}
	return str;
}

function showinbody(obj) {
	$("body").append("<div>" + showE(obj) + "</div>");
}

function fRandomBy(under, over) {
	switch (arguments.length) {
	case 1:
		return parseInt(Math.random() * under + 1);
	case 2:
		return parseInt(Math.random() * (over - under + 1) + under);
	default:
		return 0;
	}
}

function toUTF8(szInput) {
	var wch, x, uch = "", szRet = "";
	for (x = 0; x < szInput.length; x++) {
		wch = szInput.charCodeAt(x);
		if (!(wch & 0xFF80)) {
			szRet += szInput.charAt(x);
		} else if (!(wch & 0xF000)) {
			uch = "%" + (wch >> 6 | 0xC0).toString(16) + "%" + (wch & 0x3F | 0x80).toString(16);
			szRet += uch;
		} else {
			uch = "%" + (wch >> 12 | 0xE0).toString(16) + "%" + (((wch >> 6) & 0x3F) | 0x80).toString(16) + "%"
					+ (wch & 0x3F | 0x80).toString(16);
			szRet += uch;
		}
	}
	return (szRet);
}

function native2ascii() {
	regexp = / [ ^ \x00 - \xff] /
	g;
	n = document.getElementById(' native ').value;
	a = n;
	while (m = regexp.exec(n)) {
		a = a.split(m[0]).join(escape(m[0]).split(' % ').join(' \\ '));
	}
	document.getElementById(' ascii ').value = a;
}
function ascii2native() {
	// regexp = /[^\x00-\xff]/g;
	a = document.getElementById(' ascii ').value;
	n = a;
	n = unescape(n.split(' \\ ').join(' % '));
	document.getElementById(' native ').value = n;
}

function native2ascii(str) {
	regexp = /[^\x00-\xff]/g;
	a = str;
	while (m = regexp.exec(str)) {
		a = a.split(m[0]).join(escape(m[0]).split('%').join('\\'));
	}
	return a;
}