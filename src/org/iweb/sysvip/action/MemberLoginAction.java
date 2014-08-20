/**
 * 
 */
package org.iweb.sysvip.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.MD5Plus;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.dao.UserRoleDAO;
import org.iweb.sys.domain.RolePrvg;
import org.iweb.sysvip.MemberStatusFactory;
import org.iweb.sysvip.dao.MemberDAO;
import org.iweb.sysvip.domain.Member;
import org.iweb.sysvip.domain.MemberLoginInfo;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2014-1-5 下午5:07:15
 */
public class MemberLoginAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(MemberLoginAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private MemberDAO dao = new MemberDAO();

	private Member member;
	private String message;

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String login() throws Exception {
		return SUCCESS;
	}

	public String minfo() throws Exception {
		return SUCCESS;
	}

	public String checkLogin() throws Exception {
		map.clear();
		if (member == null || ToolsUtil.isEmpty(member.getUuid())) {
			this.setMessage("参数错误!");
		} else {
			String r_passwords = member.getPasswords();
			map.put("uuid", member.getUuid());
			List l = dao.getCheckMember(map);
			if (l == null || l.size() == 0) {
				this.setMessage("用户名不存在!");
			} else if (l.size() > 1) {
				this.setMessage("参数错误,请联系管理员!");
			} else if (l.size() == 1) {
				this.setMember((Member) l.get(0));
				if (MD5Plus.compare(r_passwords, this.getMember().getPasswords())) {
					setMemberLoginInfo(this.getMember());
					log.info(this.getMember().getUuid() + "登录成功!");
					return SUCCESS;
				} else {
					this.setMessage("密码错误!");
				}
			}
		}
		return INPUT;
	}

	private void setMemberLoginInfo(Member m) {
		MemberLoginInfo ml = new MemberLoginInfo();
		ml.setUuid(m.getUuid());
		ml.setTitle(m.getTitle());
		ml.setMobile(m.getMobile());
		ml.setIs_mobile_check(m.getIs_mobile_check());
		ml.setEmail(m.getEmail());
		ml.setIs_email_check(m.getIs_email_check());
		ml.setMember_name(m.getMember_name());
		ml.setUser_type(m.getUser_type());
		ml.setReg_time(m.getReg_time());
		ml.setReg_type(m.getReg_type());

		ml.setLast_login_time(m.getLast_login_time()); // 上次的最后登录时间
		ml.setDept_code(m.getDept_code());
		ml.setManager(m.getManager());

		ml.setUser_type_name(m.getUser_type_name());
		ml.setDept_name(m.getDept_name());
		ml.setManager_name(m.getManager_name());
		ml.setManager_mobile(m.getManager_mobile());

		ml.setLogin_time(new Date());
		ml.setLogin_ip(ContextHelper.getRealIP());

		if (ToolsUtil.isEmpty(ml.getUser_type())) {
			ml.setMember_prvg_map(new HashMap<String, Integer>());
			ml.setMember_function_map(new HashMap<String, String>());
		} else {
			map.clear();
			map.put("role_id", ml.getUser_type());
			List<RolePrvg> role_p_list = (new UserRoleDAO()).listRolePrvg(map);

			HashMap<String, Integer> mp_map = new HashMap<>();
			HashMap<String, String> mf_map = new HashMap<>();
			for (int i = 0, n = role_p_list.size(); i < n; i++) {
				RolePrvg rp = role_p_list.get(i);
				mp_map.put(rp.getPrivilege_id(), rp.getType());
				mf_map.put(rp.getPrivilege_id(), rp.getFunction());
			}
			ml.setMember_prvg_map(mp_map);
			ml.setMember_function_map(mf_map);
		}

		ContextHelper.getRequest().getSession().setAttribute(Parameters.MemberLoginInfo_Session_Str, ml);
	}

	public String member_login_out() throws Exception {
		MemberStatusFactory.Logout();
		setMessage("已安全退出系统");
		return SUCCESS;
	}
}
