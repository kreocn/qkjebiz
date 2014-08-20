/**
 * 
 */
package org.iweb.sysvip.domain;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2014-2-20 上午10:14:39
 */
public class MemberCapital {
	private String member_id;
	private Double money;
	private Integer score;
	private Integer re_score;
	private Integer with_score;
	private Integer score_x;
	private Integer score_y;
	private Double money_x;
	private Double money_y;

	public Integer getWith_score() {
		return with_score;
	}

	public void setWith_score(Integer with_score) {
		this.with_score = with_score;
	}

	public Integer getScore_x() {
		return score_x;
	}

	public void setScore_x(Integer score_x) {
		this.score_x = score_x;
	}

	public Integer getScore_y() {
		return score_y;
	}

	public void setScore_y(Integer score_y) {
		this.score_y = score_y;
	}

	public Double getMoney_x() {
		return money_x;
	}

	public void setMoney_x(Double money_x) {
		this.money_x = money_x;
	}

	public Double getMoney_y() {
		return money_y;
	}

	public void setMoney_y(Double money_y) {
		this.money_y = money_y;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public Integer getRe_score() {
		return re_score;
	}

	public void setRe_score(Integer re_score) {
		this.re_score = re_score;
	}

}
