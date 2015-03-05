package com.qkjsys.ebiz.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.rpt.dao.SimpleReportDAO;
import org.iweb.rpt.domain.ListObject;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.DateUtil;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.qkjsys.ebiz.dao.GoodsDAO;
import com.qkjsys.ebiz.dao.GoodsImgDAO;
import com.qkjsys.ebiz.dao.GoodsInfoDAO;
import com.qkjsys.ebiz.domain.Goods;
import com.qkjsys.ebiz.domain.GoodsImg;
import com.qkjsys.ebiz.domain.GoodsInfo;
import com.qkjsys.ebiz.domain.GoodsStock;

public class GoodsAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(GoodsAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private GoodsDAO dao = new GoodsDAO();
	private GoodsImgDAO imgdao = new GoodsImgDAO();

	private Goods goods;
	private List<Goods> goodx;

	private GoodsInfo goodsInfo;

	private GoodsImg goodsImg;
	private List<GoodsImg> goodsImgs;

	private Integer stockNum;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;商品列表";
	
	public String getPath() {
		return path;
	}

	public GoodsInfo getGoodsInfo() {
		return goodsInfo;
	}

	public void setGoodsInfo(GoodsInfo goodsInfo) {
		this.goodsInfo = goodsInfo;
	}

	public Integer getStockNum() {
		return stockNum;
	}

	public void setStockNum(Integer stockNum) {
		this.stockNum = stockNum;
	}

	public GoodsImg getGoodsImg() {
		return goodsImg;
	}

	public void setGoodsImg(GoodsImg goodsImg) {
		this.goodsImg = goodsImg;
	}

	public List<GoodsImg> getGoodsImgs() {
		return goodsImgs;
	}

	public void setGoodsImgs(List<GoodsImg> goodsImgs) {
		this.goodsImgs = goodsImgs;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public List<Goods> getGoodx() {
		return goodx;
	}

	public void setGoodx(List<Goods> goodx) {
		this.goodx = goodx;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getViewFlag() {
		return viewFlag;
	}

	public void setViewFlag(String viewFlag) {
		this.viewFlag = viewFlag;
	}

	public int getRecCount() {
		return recCount;
	}

	public void setRecCount(int recCount) {
		this.recCount = recCount;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public void validate() {
	}

	public String list() throws Exception {
		ContextHelper.isPermit("SYS_EBIZ_GOODS_LIST");
		try {
			map.clear();
			if (goods != null)
				map.putAll(ToolsUtil.getMapByBean(goods));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setGoodx(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;商品列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String addLoad() throws Exception {
		ContextHelper.isPermit("SYS_EBIZ_GOODS_ADDLOAD");
		try {
			setViewFlag("add");
			if (goods == null) {
				goods = new Goods();
			}
			goods.setGoods_points(-1);
			Date d = new Date();
			goods.setGoods_promotion_start(DateUtil.getDate(d, "yyyy-MM-dd"));
			goods.setGoods_promotion_end(DateUtil.getDate(DateUtil.addMonth(d, 1), "yyyy-MM-dd"));
			goods.setGoods_num(1);
			goods.setGoods_num_warning(1);
			goods.setGoods_points_sales(0);

			// 藏酒固定项,以后发展业务之后去除
			// 固定100L为单位(100公斤)
			goods.setGoods_unit("坛");
			goods.setGoods_spec(100.0);
			goods.setGoods_spec_unit("L");

			// 临时,以后自动替换
			setColumn_1list();
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/sysebiz/goods_list?viewFlag=relist'>商品列表</a>&nbsp;&gt;&nbsp;添加藏酒";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!addLoad Error:", e);
			throw new Exception(this.getClass().getName() + "!addLoad Error:", e);
		}
		return SUCCESS;
	}

	public String addSave() throws Exception {
		ContextHelper.isPermit("SYS_EBIZ_GOODS_ADDSAVE");
		try {
			Date d = new Date();
			String ut = ContextHelper.getUserLoginUuid();
			String ip = ContextHelper.getRealIP();
			goods.setGoods_sales(1); // 默认不上架
			goods.setAdd_time(d);
			goods.setAdd_user(ut);
			goods.setAdd_ip(ip);
			goods.setLm_user(ut);
			goods.setLm_time(d);
			goods.setLm_ip(ip);
			int goods_id = (Integer) dao.add(goods);
			// 添加商品附加信息
			if (goodsInfo == null)
				goodsInfo = new GoodsInfo();
			goodsInfo.setGoods_id(goods_id);
			GoodsInfoDAO idao = new GoodsInfoDAO();
			idao.add(goodsInfo);

			// 添加库存信息
			dao.addStock(goods_id, goods.getGoods_num());

			// 添加商品图库信息
			imgdao.addBatch(goodsImgs, goods_id);

			// 批量生成藏酒数据,是藏酒类型才执行
			if (goods.getGoods_type() == 1) {
				try {
					dao.createCellarsByGoodsID(goods_id);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String loadSave() throws Exception {
		ContextHelper.isPermit("SYS_EBIZ_GOODS_SAVELOAD");
		try {
			setViewFlag("mdy");
			map.clear();
			map.put("uuid", goods.getUuid());
			if (null == map.get("uuid"))
				this.setGoods(null);
			else
				this.setGoods((Goods) dao.list(map).get(0));

			map.clear();
			map.put("goods_id", this.getGoods().getUuid());
			this.setGoodsImgs(imgdao.list(map));

			// 添加附加信息
			GoodsInfoDAO idao = new GoodsInfoDAO();
			map.clear();
			map.put("goods_id", goods.getUuid());
			this.setGoodsInfo((GoodsInfo) idao.list(map).get(0));

			// 临时,以后自动替换
			setColumn_1list();
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/sysebiz/goods_list?viewFlag=relist'>商品列表</a>&nbsp;&gt;&nbsp;修改藏酒";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!loadSave 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!loadSave 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("SYS_EBIZ_GOODS_SAVE");
		try {
			goods.setLm_user(ContextHelper.getUserLoginUuid());
			goods.setLm_time(new Date());
			goods.setLm_ip(ContextHelper.getRealIP());
			dao.save(goods);

			GoodsInfoDAO idao = new GoodsInfoDAO();
			idao.save(goodsInfo);

			imgdao.addBatch(goodsImgs, goods.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 商品上架
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-2-22 下午2:01:20
	 */
	public String mdyGoodsSalesUp() throws Exception {
		ContextHelper.isPermit("SYS_EBIZ_GOODS_SALESUP");
		try {
			goods.setGoods_sales(0);
			goods.setLm_user(ContextHelper.getUserLoginUuid());
			goods.setLm_time(new Date());
			goods.setLm_ip(ContextHelper.getRealIP());
			dao.mdyGoodsSales(goods);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyGoodsSalesUp 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyGoodsSalesUp 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 商品下架
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-2-22 下午2:01:07
	 */
	public String mdyGoodsSalesDown() throws Exception {
		ContextHelper.isPermit("SYS_EBIZ_GOODS_SALESDOWN");
		try {
			goods.setGoods_sales(1);
			goods.setLm_user(ContextHelper.getUserLoginUuid());
			goods.setLm_time(new Date());
			goods.setLm_ip(ContextHelper.getRealIP());
			dao.mdyGoodsSales(goods);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyGoodsSalesDown 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyGoodsSalesDown 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String saveInStock() throws Exception {
		ContextHelper.isPermit("SYS_EBIZ_GOODS_SAVEINSTOCK");
		try {
			dao.saveInStock(new GoodsStock(goods.getUuid(), stockNum));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	// 临时,以后变成自动
	List<ListObject> column_1list;

	public List<ListObject> getColumn_1list() {
		return column_1list;
	}

	public void setColumn_1list() {
		SimpleReportDAO sdao = new SimpleReportDAO();
		map.clear();
		map.put("sqltext", "SELECT uuid AS `key`,ware_name AS `value` FROM qkj_t_warehouse");
		this.column_1list = sdao.getSimpleList(map);
	}

}
