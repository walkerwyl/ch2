package myservlet;

import java.util.Iterator;
import mybean.source_bean;
import mybean.teacher_bean;
import mybean.class_bean;
import myservlet.DB;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

//@WebServlet(name="DeleteServlet", urlPatterns="/DeleteServlet")
public class DeleteServlet extends HttpServlet{
  
  public void init(ServletConfig config) throws ServletException{
    super.init();
  }
  
  public void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException{
	HttpSession session = request.getSession();
	teacher_bean teacher = (teacher_bean) session.getAttribute("TeacherBean");

	String tea_id = teacher.getTea_ID(); 
	String cou_id = (String) request.getParameter("Cou_ID");
	String sou_name = (String) request.getParameter("Sou_Name");
	String deletePath = request.getServletContext().getRealPath( "/upload/" + tea_id + "/" + cou_id + "/source/" + sou_name );
    //首先从数据库中删除对应的数据，然后从老师资源库中删除对应的文件
    try{
      	PreparedStatement ps;
      	ps = DB.dbCon().prepareStatement("DELETE FROM source WHERE Sou_Name=?");
	ps.setString(1,sou_name);
	ps.executeUpdate();

	deleteFile(deletePath);

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("Sou_Name=" + sou_name+ "的资源已删除");
	out.println(deletePath);
        out.println("<a href=Tea_Homepage.jsp>回到教师主页面</a>");
        out.println("<a href=ManageFile.jsp>回到ManageFile.jsp页面</a>");
        out.println("</html></body>");

    }
    catch(Exception e){}
  }

	public void deleteFile(String path){
		File f = new File(path);
		f.delete();
	}

  public void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException{
    doPost(request, response);
  }
  
}
