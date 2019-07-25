package mybean;

import common.base.LayuiBaseObject;

public class Class extends LayuiBaseObject implements java.io.Serializable {
	
	private String class_id;
	private String cou_id;
	private String cou_name;
	private String tea_id;

	//非数据库
	
	
	public Class() {}

	public String getClass_id() {
		return class_id;
	}

	public void setClass_id(String class_id) {
		this.class_id = class_id;
	}

	public String getCou_id() {
		return cou_id;
	}

	public void setCou_id(String cou_id) {
		this.cou_id = cou_id;
	}

	public String getCou_name() {
		return cou_name;
	}

	public void setCou_name(String cou_name) {
		this.cou_name = cou_name;
	}

	public String getTea_id() {
		return tea_id;
	}

	public void setTea_id(String tea_id) {
		this.tea_id = tea_id;
	}
	
}