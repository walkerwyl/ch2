package myservlet;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mybean.class_bean;
import mybean.teacher_bean;
import mybean.student_bean;

public class HomeworkServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession ss = request.getSession(true);
        String tt = request.getParameter("work");
        FileWriter writer;

	student_bean stu = (student_bean)ss.getAttribute("StudentBean");
        String Tea_ID = request.getParameter("teaid");
        String Cou_ID = request.getParameter("couid");
        String Class_ID = request.getParameter("classid");
        String workname = request.getParameter("workname");

        String fileName = stu.getStu_ID + ".txt";

        String filePath = request.getServletContext().getRealPath("/") + "upload/"+Tea_ID+"/"+Cou_ID+"/"+Class_ID+"/"+workname+"/"+fileName;
        try {
            writer = new FileWriter(filePath);
            writer.write(tt);
            writer.flush();
            writer.close();
        } catch (Exception e) {
        }
        RequestDispatcher dis = request.getRequestDispatcher("uploadhomework.jsp");
        dis.forward(request, response);
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
