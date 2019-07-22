package mybean;

import common.base.LayuiBaseObject;

public class Info extends LayuiBaseObject implements java.io.Serializable {
	
	private String class_id;
	private String stu_id;
	private Float work1;
	private Float work2;
	private Float work3;
	private Integer my_count;
	private Integer my_time;
	private String stu_name;//学生姓名
	
	//关联字段
	private String cou_id;    //课程ID
	private String cou_name;  //课程名称
	private String tea_id;    //教师ID
	private String name;      //教师姓名
	private String sou_id;    //资源ID
	private String sou_name;  //资源名称
	private Integer type;     //类型（0：1：2：3：学生作业）
	private Integer sum_count;//总数
	private Integer share;    //分享
	
	public Info() {}

	public String getClass_id() {
		return class_id;
	}

	public void setClass_id(String class_id) {
		this.class_id = class_id;
	}

	public String getStu_id() {
		return stu_id;
	}

	public void setStu_id(String stu_id) {
		this.stu_id = stu_id;
	}

	public Float getWork1() {
		return work1;
	}

	public void setWork1(Float work1) {
		this.work1 = work1;
	}

	public Float getWork2() {
		return work2;
	}

	public void setWork2(Float work2) {
		this.work2 = work2;
	}

	public Float getWork3() {
		return work3;
	}

	public void setWork3(Float work3) {
		this.work3 = work3;
	}

	public Integer getMy_count() {
		return my_count;
	}

	public void setMy_count(Integer my_count) {
		this.my_count = my_count;
	}

	public Integer getMy_time() {
		return my_time;
	}

	public void setMy_time(Integer my_time) {
		this.my_time = my_time;
	}

	public String getStu_name() {
		return stu_name;
	}

	public void setStu_name(String stu_name) {
		this.stu_name = stu_name;
	}

	public String getCou_name() {
		return cou_name;
	}

	public void setCou_name(String cou_name) {
		this.cou_name = cou_name;
	}

	public String getCou_id() {
		return cou_id;
	}

	public void setCou_id(String cou_id) {
		this.cou_id = cou_id;
	}

	public String getTea_id() {
		return tea_id;
	}

	public void setTea_id(String tea_id) {
		this.tea_id = tea_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSou_name() {
		return sou_name;
	}

	public void setSou_name(String sou_name) {
		this.sou_name = sou_name;
	}

	public String getSou_id() {
		return sou_id;
	}

	public void setSou_id(String sou_id) {
		this.sou_id = sou_id;
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