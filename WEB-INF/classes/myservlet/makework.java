package myservlet;

import mybean.class_bean;
import mybean.teacher_bean;
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

public class makework extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet makework</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet makework at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");   //解决乱码所必须的
        HttpSession ss = request.getSession(true);
        String tt = request.getParameter("work");
        String an = request.getParameter("answer");
        String etime = request.getParameter("etime");
        FileWriter writer;

        String[] etimes = etime.split("\\-|\\s|:");//设置的截止时间
        etime = etimes[0] + "-" + etimes[1] + "-" + etimes[2] + "-" + etimes[3] + "-" + etimes[4] + "-" + etimes[5];

        SimpleDateFormat sdf = new SimpleDateFormat();//当前的系统时间
        sdf.applyPattern("yyyy-MM-dd-HH-mm-ss");
        Date date = new Date();

        teacher_bean tea = new teacher_bean();//获取文件路径
        class_bean cla = new class_bean();
        tea = (teacher_bean) ss.getAttribute("teacherbean");
        cla = (class_bean) ss.getAttribute("classbean");
        String tea_ID = tea.getTea_ID();
        String cou_ID = cla.getCou_ID();
        String cla_ID = cla.getClass_ID();

        File updir = new File(request.getServletContext().getRealPath("/upload/" + tea_ID + "/" + cou_ID + "/" + cla_ID));//判断有没有这个班级的文件夹
        if (!updir.exists()) {
            updir.mkdir();
        }

        String mm = "work1";
        String path = request.getServletContext().getRealPath("/upload/" + tea_ID + "/" + cou_ID + "/" + cla_ID + "/" + mm);
        File updir2 = new File(path);
        if (!updir2.exists()) {
            updir2.mkdir();
        } else {
            mm = "work2";
        }
        File updir3 = new File(path);
        if (!updir3.exists()) {
            updir3.mkdir();
        } else {
            mm = "work3";
        }
        File updir4 = new File(path);
        if (!updir4.exists()) {
            updir4.mkdir();
        }

        String filePath = path + "/work.txt";//得到文件路径和名称组合
        String filePath2 = path + "/answer.txt";
        String filePath3 = path + "/time.txt";

        try {
            writer = new FileWriter(filePath);//写文件
            writer.write(tt);
            writer.flush();
            writer.close();
            writer = new FileWriter(filePath2);//写文件
            writer.write(an);
            writer.flush();
            writer.close();
            writer = new FileWriter(filePath3);//写文件
            writer.write(etime);
            writer.flush();
            writer.close();
        } catch (Exception e) {

        }
        PrintWriter out = response.getWriter();
        out.println("<html><body>发布成功<br><a href=\"Tea_Homepage.jsp\">返回主页</a></body></html>");
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
