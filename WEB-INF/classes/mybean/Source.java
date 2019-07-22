package mybean;

import common.base.LayuiBaseObject;

public class Source extends LayuiBaseObject implements java.io.Serializable {
	
	private String sou_id;
	private String sou_name;
	private String tea_id;
	private String cou_id;
	private Integer type;//资源类型（0：1：2：3：学生作业）
	private Integer sum_count;
	private Integer share;
	
	public Source() {}

	public String getSou_id() {
		return sou_id;
	}

	public void setSou_id(String sou_id) {
		this.sou_id = sou_id;
	}

	public String getSou_name() {
		return sou_name;
	}

	public void setSou_name(String sou_name) {
		this.sou_name = sou_name;
	}

	public String getTea_id() {
		return tea_id;
	}

	public void setTea_id(String tea_id) {
		this.tea_id = tea_id;
	}

	public String getCou_id() {
		return cou_id;
	}

	public void setCou_id(String cou_id) {
		this.cou_id = cou_id;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getSum_count() {
		return sum_count;
	}

	public void setSum_count(Integer sum_count) {
		this.sum_count = sum_count;
	}

	public Integer getShare() {
		return share;
	}

	public void setShare(Integer share) {
		this.share = share;
	}
}