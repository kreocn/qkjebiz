package org.iweb.sysvip.domain;

public class MemberAddress {
	private Integer uuid;// (int)
	private String member_id;// (varchar)会员号
	private String province;// (varchar)省/直辖市
	private String city;// (varchar)市/区
	private String area;// (varchar)县
	private String post;// (varchar)邮编
	private String street;// (varchar)街道地址
	private String con_name;// (varchar)收货人姓名
	private String mobile;// (varchar)手机/联系电话
	private Integer defaultaddress;// (int)是否默认地址,0:否 1:是

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getCon_name() {
		return con_name;
	}

	public void setCon_name(String con_name) {
		this.con_name = con_name;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public Integer getDefaultaddress() {
		return defaultaddress;
	}

	public void setDefaultaddress(Integer defaultaddress) {
		this.defaultaddress = defaultaddress;
	}

}
