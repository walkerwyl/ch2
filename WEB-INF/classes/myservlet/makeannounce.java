package myservlet;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mybean.class_bean;
import mybean.teacher_bean;

public class makeannounce extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");   //解决乱码所必须
        HttpSession ss = request.getSession(true);
        String tt = request.getParameter("ann");
        FileWriter writer;

        SimpleDateFormat sdf = new SimpleDateFormat();//系统当前时间
        sdf.applyPattern("yyyy-MM-dd-HH-mm-ss");
        Date date = new Date();
        String fileName = sdf.format(date) + ".txt";

        String tea_ID = request.getParameter("teaid");//获取文件目录
        String cou_ID = request.getParameter("couid");
        String cla_ID = request.getParameter("classid");
        
        File updir = new File(tea_ID + "/" + cou_ID + "/" + cla_ID);//判断有没有这个班级的文件夹
        if (!updir.exists()) {
            updir.mkdir();
        }
        File updir2 = new File(tea_ID + "/" + cou_ID + "/" + cla_ID + "/announce");
        if (!updir2.exists()) {
            updir2.mkdir();
        }

        String filePath = "upload/" + tea_ID + "/" + cou_ID + "/" + cla_ID + "/announce/" + fileName;

        try {
            writer = new FileWriter(filePath);
            writer.write(tt);
            writer.flush();
            writer.close();
        } catch (Exception e) {
        }
        response.sendRedirect("makeannounce.jsp?make=yes");
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
