package myservlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.dao.DAO;
import mybean.Info;

import com.alibaba.fastjson.JSON;
import common.base.LayuiDataGrid;
import common.util.Util;


public class SourceServlet extends HttpServlet {
	
	public SourceServlet() {
		
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//分页信息
		int page=Integer.parseInt(request.getParameter("page"));  //当前页
		int limit=Integer.parseInt(request.getParameter("limit"));//每页条数
		int startIndex=(page-1)*limit; //该页第一条序号值(第1页 0，第2页10，第3页20，。。。）
		
		//条件查询
		String tea_id=request.getParameter("tea_id");//教师ID
		String name=request.getParameter("name");//教师姓名
		String cou_name=request.getParameter("cou_name");//课程名称
		String stu_name=request.getParameter("stu_name");//学生姓名
		String type=request.getParameter("type");//资源类型（0：1：2：3：学生作业）
		
		//将查询条件拼接到sql
		String where="";
		if(Util.isNotEmpty(tea_id)){
			where+=" and b.tea_id= '"+tea_id+"'";
		}
		if(Util.isNotEmpty(name)){
			where+=" and c.name like '%"+name+"%'";
		}
		if(Util.isNotEmpty(cou_name)){
			where+=" and b.cou_name like '%"+cou_name+"%'";
		}
		if(Util.isNotEmpty(stu_name)){
			where+=" and a.stu_name like '%"+stu_name+"%'";
		}
		if(Util.isNotEmpty(type)){
			where+=" and d.type= '"+type+"'";
		}
		
		//数据库工具类
		DAO dao =new DAO();
		
		String sql="select a.*,b.tea_id,b.cou_id,b.Cou_Name,c.name,d.sou_id,d.sou_name " +
			"from info a " +
			"inner join class b on a.class_id=b.class_id " +
			"left join teacher c on b.tea_id=c.tea_id " +
			"left join source d on b.tea_id=d.tea_id and b.cou_id=d.cou_id " +
			
			"where 1=1 "+where+
			" order by stu_id,b.Cou_Name limit "+startIndex+","+limit;
		String countSql="select count(*) " +
			"from info a " +
			"inner join class b on a.class_id=b.class_id " +
			"left join teacher c on b.tea_id=c.tea_id " +
			"left join source d on b.tea_id=d.tea_id and b.cou_id=d.cou_id " +
			"where 1=1 "+where+"";
	
		//查询指定页数据
		List<Info> list=dao.getForList(Info.class, sql);
		
		//查询总共条数
		Long count=dao.getForValue(countSql);
		
		//构造数据表格
		LayuiDataGrid j = new LayuiDataGrid();
		j.setData(list); //当前页数据
		j.setCount(count);//总条数
		j.setCode(0L);//查询状态（0：正常)
		
		//将对象转为Jonson字符串返回
		String json = JSON.toJSONString(j);
		
		
		// 设置响应内容类型
		response.setContentType("text/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		// 输出数据
		out = response.getWriter();
		//返回Json数据
		out.println(json);

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	public void init() throws ServletException {
	}
	public void destroy() {
		super.destroy(); 
	}
}
