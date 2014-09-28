/**
 * 选择地区(AJAX) 所需类库
 * 
 * @need jquery.js
 * @need jquery.select.js
 */
function SArea(province_obj, city_obj, country_obj) {

	this.province = "";
	this.city = "";
	this.country = "";
	this.ajax_url = "/erp/common_ajax/json_ajax";

	var selfobj = this;

	// type 0无效 1省 2市 3县
	this.type = 0;

	this.config = {
		isShowHead : true
	// 初始化时,是否在显示"请选择"
	};

	// 初始化控件
	this.init = function(province, city, country) {
		province_obj.clearAllOption();
		city_obj.clearAllOption();
		country_obj.clearAllOption();
		
		this.province = province;
		// if (!this.province)
		// this.province = "浙江省";
		this.city = city;
		// if (!this.city)
		// this.city = "宁波市";
		this.country = country;
		// 为省份改变绑定事件
		if ($(city_obj).length>0) {
			province_obj.unbind().bind("change", function() {
				if ($(city_obj).length>0) {
					country_obj.clearAllOption();
				}
				city_obj.clearAllOption();
				selfobj.getCities();
			});
		}
		// 为市改变绑定事件
		if ($(country_obj).length>0) {
			city_obj.unbind().bind("change", function() {
				country_obj.clearAllOption();
				selfobj.getCountries();
			});
		}
		this.getProvinces();
	};

	this.setAjaxUrl = function(ajax_url) {
		this.ajax_url = ajax_url;
	};

	// @param type
	// 1:province 2:city 3:country

	this.getParameter = function() {
		var parameterStr = "work=AreaSelect";
		if (this.type == 1) {
			parameterStr += "&parameters=" + encodeURIComponent("type=province");
		} else if (this.type == 2) {
			parameterStr += "&parameters="
					+ encodeURIComponent("type=city&province=" + province_obj.getSelectedValue());
		} else if (this.type == 3) {
			parameterStr += "&parameters="
					+ encodeURIComponent("type=country&province=" + province_obj.getSelectedValue() + "&city="
							+ city_obj.getSelectedValue());
		}
		return parameterStr;
	};

	this.sendAjax = function(parameter) {
		$.ajax({
			type : 'post',
			url : this.ajax_url,
			data : parameter,
			dataType : 'json',
			success : _op,
			error : function() {
				// 请求出错处理
			}
		});
	};

	var _op = function(data, textStatus) {
		if (selfobj.type == 1) {
			if (selfobj.config.isShowHead)
				province_obj.addOption("请选择", "");
			for (i in data) {
				province_obj.addOption(data[i], data[i]);
			}
			if (selfobj.province) {
				selfobj.setProvince(selfobj.province);
				if (city_obj) {
					selfobj.getCities();
				}
			}
		} else if (selfobj.type == 2) {
			if (selfobj.config.isShowHead)
				city_obj.addOption("请选择", "");
			for (i in data) {
				city_obj.addOption(data[i], data[i]);
			}
			if (selfobj.city) {
				selfobj.setCity(selfobj.city);
				if (country_obj) {
					selfobj.getCountries();
				}
			}
		} else if (selfobj.type == 3) {
			if (selfobj.config.isShowHead)
				country_obj.addOption("请选择", "");
			for (i in data) {
				country_obj.addOption(data[i], data[i]);
			}
			if (selfobj.country) {
				selfobj.setCountry(selfobj.country);
			}
		}

	};

	// 填充省级行政单位
	this.getProvinces = function() {
		this.type = 1;
		this.sendAjax(this.getParameter());
	};
	// 设定省级单位
	this.setProvince = function(province) {
		province_obj.setSelectedValue(province);
	};

	// 填充市级单位
	this.getCities = function() {
		this.type = 2;
		this.sendAjax(this.getParameter());
	};

	this.setCity = function(city) {
		city_obj.setSelectedValue(city);
	};

	// 填充县级单位
	this.getCountries = function() {
		this.type = 3;
		this.sendAjax(this.getParameter());
	};

	this.setCountry = function(country) {
		country_obj.setSelectedValue(country);
	};
}