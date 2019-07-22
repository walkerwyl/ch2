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


public class InfoServlet extends HttpServlet {

	public InfoServlet() {
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action=request.getParameter("action");  //处理标志
		
		//打分处理
		if("toScore".equals(action)){
			
			
			String tea_id=request.getParameter("tea_id");  //教师ID
			String cou_id=request.getParameter("cou_id");  //课程ID
			String stu_id=request.getParameter("stu_id");  //学生ID
		
			request.setAttribute("tea_id", tea_id);
			request.setAttribute("cou_id", cou_id);
			request.setAttribute("stu_id", stu_id);
			
			request.getRequestDispatcher("/jsp/source/sourceForm.jsp").forward(request,response);
			
		} else if("score".equals(action)){
			common.base.Json json = new common.base.Json();
			boolean b = false;
			
			String tea_id=request.getParameter("tea_id");  //教师ID
			String cou_id=request.getParameter("cou_id");  //课程ID
			String stu_id=request.getParameter("stu_id");  //学生ID
			
			String work1=request.getParameter("work1");  //成绩1
			String work2=request.getParameter("work2");  //成绩2
			String work3=request.getParameter("work3");  //成绩3
			
			//参数都不为空
			if(Util.isNotEmpty(tea_id) && Util.isNotEmpty(cou_id) && Util.isNotEmpty(stu_id)){
				//数据库工具类
				DAO dao =new DAO();
				
				String sql="select class_id from class where tea_id=? and cou_id=? " ; 
				
				mybean.Class c=dao.get(mybean.Class.class, sql, tea_id,cou_id);
				
				if(Util.isNotEmpty(c)){
					String sql2="update info set work1=?,work2=?,work3=? where class_id=? and stu_id=? " ; 
					
					dao.update(sql2,Integer.parseInt(work1),Integer.parseInt(work2),Integer.parseInt(work3),c.getClass_id(),stu_id);
					 
					b = true;
				}
			}
			if(b) {
				json.setSuccess(true);
				json.setMsg("打分成功！");
			} else {
				json.setSuccess(false);
				json.setMsg("打分失败！");
			}
			
			//将对象转为Jonson字符串返回
			String r = JSON.toJSONString(json);
			
			// 设置响应内容类型
			response.setContentType("text/json; charset=utf-8");
			PrintWriter out = response.getWriter();
			// 输出数据
			out = response.getWriter();
			//返回Json数据
			out.println(r);
			
			
		} else {
		//非打分处理
			//分页信息
			int page=Integer.parseInt(request.getParameter("page"));  //当前页
			int limit=Integer.parseInt(request.getParameter("limit"));//每页条数
			int startIndex=(page-1)*limit; //该页第一条序号值(第1页 0，第2页10，第3页20，。。。）
			
			//条件查询
			String class_id=request.getParameter("class_id");  //班级
			String cou_name=request.getParameter("cou_name");  //课程名称
			String stu_id=request.getParameter("stu_id");      //学号
			String stu_name=request.getParameter("stu_name");  //学生姓名
			String tea_id=request.getParameter("tea_id");      //教师ID
			
			//将查询条件拼接到sql
			String where="";
			if(Util.isNotEmpty(class_id)){
				where+=" and a.class_id like '%"+class_id+"%'";
			}
			if(Util.isNotEmpty(stu_id)){
				where+=" and a.stu_id like '%"+stu_id+"%'";
			}
			if(Util.isNotEmpty(stu_name)){
				where+=" and a.stu_name like '%"+stu_name+"%'";
			}
			if(Util.isNotEmpty(cou_name)){
				where+=" and b.cou_name like '%"+cou_name+"%'";
			}
			if(Util.isNotEmpty(tea_id)){
				where+=" and b.tea_id = '"+tea_id+"'";
			}
			
			//数据库工具类
			DAO dao =new DAO();
			
			String sql="select a.*,b.Cou_Name,c.name " +
					"from info a " +
					"left join class b on a.class_id=b.class_id " +
					"left join teacher c on b.tea_id=c.tea_id " +
					"where 1=1 "+where+
					" order by stu_id,b.Cou_Name limit "+startIndex+","+limit;
			String countSql="select count(*) " +
					"from info a " +
					"left join class b on a.class_id=b.class_id " +
					"left join teacher c on b.tea_id=c.tea_id " +
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
