package myservlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MoreServlet extends HttpServlet{
  public void init(ServletConfig config) throws ServletException {
    super.init();
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      	response.setContentType("text/html;charset=UTF-8");
    	try{
     		PrintWriter out = response.getWriter();
      		out.println("<html><body>");
      		out.println("<table>");
      		out.print("<tr><th>资源编号：</th>");
      		out.print("<th>资源名称：</th>");
		out.print("<th>资源所属课程：</th>");
		out.print("<th>资源所属老师：</th></tr>");
    		PreparedStatement ps;
    		ps = DB.dbCon().prepareStatement("select * from source where Share=0");
    		ResultSet rs = ps.executeQuery();

      		while( rs.next() ){
          	out.print( "<tr><th>" + rs.getString(4)  +"</th>" );
          	out.print( "<th>" + rs.getString(6) + "</th>" );
          	out.print( "<th>"  +rs.getString(2) + "</th>" );
          	out.print( "<th>"  +rs.getString(1) + "</th></tr>" );
        	}
      		out.println("</table>");
      		out.println("<a href=teaHomepage.jsp>回到教师主页面</a>");
      		out.println("</body></html>");
    	}
	catch(Exception e){}
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    doPost(request, response);
  }

}

