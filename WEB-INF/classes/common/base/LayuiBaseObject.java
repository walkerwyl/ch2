package common.base;
/*
 * 用户layui数据表格分页、排序
 */
public class LayuiBaseObject {
	private int page;// 当前页
	private int limit;// 每页显示记录数
	private String sort;// 排序字段名
	private String order;// 按什么排序(asc,desc)
	private String ids;
	
	public int getPage() {
		return page;
	}
	public int getLimit() {
		return limit;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public void setLimit(int limit) {
		this.limit = limit;
	}
	public String getSort() {
		return sort;
	}
	public String getOrder() {
		return order;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	
	
}
