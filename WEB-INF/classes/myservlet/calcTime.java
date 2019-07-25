package myservlet;

import mybean.student_bean;
import myservlet.DB; 
import java.sql.PreparedStatement; 
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "calcTime", urlPatterns = {"/calcTime"})
public class calcTime extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
	HttpSession session = request.getSession(); 
	student_bean student = (student_bean) session.getAttribute("StudentBean");
	String stuid = student.getStu_ID();

        String classid = request.getParameter("classid");
	String souid = request.getParameter("souid");

        String start = request.getParameter("start");
        DateFormat df = new SimpleDateFormat("HH:mm:ss");
        Date endTime = new Date();
        String end = df.format(endTime);
        
        int startHour = Integer.parseInt( start.substring(0, 2) );
        int startMinute = Integer.parseInt( start.substring(3, 5) );
        //int startSecond = Integer.parseInt( start.substring(6) );
        int endHour = Integer.parseInt( end.substring(0, 2) );
        int endMinute = Integer.parseInt( end.substring(3, 5) );
        //int endSecond = Integer.parseInt( end.substring(6) );
        
        //时间计算按分钟来
        //int timeCount = 60*60*(endHour - startHour) + 60*(endMinute - startMinute) + (endSecond - startSecond);
        int timeCount = 60*(endHour - startHour) + (endMinute - startMinute);

	try{
		PreparedStatement ps = DB.dbCon().prepareStatement("UPDATE info SET My_Count=My_Count+1,My_Time=My_Time+? WHERE Stu_ID=? AND Class_ID=?");
		ps.setInt(1,timeCount);
		ps.setString(2,stuid);
		ps.setString(3,classid);
		ps.executeUpdate();

		ps = DB.dbCon().prepareStatement("UPDATE source SET Sum_Count=Sum_Count+1 WHERE Sou_ID=?");
		ps.setString(1,souid);
		ps.executeUpdate();
	}
	catch(Exception e){}


        
        response.setContentType("text/html;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet calcTime</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet calcTime at " + request.getContextPath() + "</h1>");
            out.println("startTime=" + start);
            out.println("endTime=" + end);
	    out.println("timeCount=" + timeCount);
	    out.println("stuid=" + stuid);
	    out.println("classid=" + classid);

//            out.println("小时："+ end.substring(0, 2));
//            out.println("分钟："+ end.substring(3, 5));
//            out.println("秒："+ end.substring(6));
//            out.println(timeCount);
            out.println("<a href=View_Sources.jsp>Reutrn to View_Sources.jsp</a>");
            out.println("</body>");
            out.println("</html>");
        }
	catch(Exception e){}
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
