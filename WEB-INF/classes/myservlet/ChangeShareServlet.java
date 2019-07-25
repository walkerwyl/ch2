package myservlet;

import myservlet.DB;
import mybean.teacher_bean;
import mybean.source_bean;
import mybean.class_bean;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

//@WebServlet(name="DeleteServlet", urlPatterns="/DeleteServlet")
public class ChangeShareServlet extends HttpServlet{

  public void init(ServletConfig config) throws ServletException{
    super.init();
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{

	String sou_id = (String) request.getParameter("Sou_ID");
	String couid = (String) request.getParameter("couid");
	String tmp = request.getParameter("Share");
	int share = Integer.parseInt(tmp);
	try{
        //更新数据库
      	PreparedStatement ps;
	ps = DB.dbCon().prepareStatement("UPDATE source SET Share=? WHERE Sou_ID=?");
       	ps.setInt(1,1-share);
       	ps.setString(2,sou_id);
	ps.executeUpdate();

	}
	catch(Exception e){}

	RequestDispatcher dispatcher = request.getRequestDispatcher("ManageFile.jsp?couid="+couid);
	dispatcher.forward(request, response);
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
    doPost(request, response);
  }

}

