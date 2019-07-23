package myservlet;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
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

        String[] etimes = etime.split("\\-|\\s|:");//设置的截止时间改格式
        etime = etimes[0] + "-" + etimes[1] + "-" + etimes[2] + "-" + etimes[3] + "-" + etimes[4] + "-" + etimes[5];

        String tea_ID = request.getParameter("teaid");//获取文件目录
        String cou_ID = request.getParameter("couid");
        String cla_ID = request.getParameter("classid");
        String path = request.getServletContext().getRealPath("/upload/" + tea_ID + "/" + cou_ID + "/" + cla_ID);//获取路径

        try {
            File dir = new File(path + "/work1");//创建三个work文件夹
            if (!dir.exists()) {
                dir.mkdirs();
            }
            File dir2 = new File(path + "/work2");
            if (!dir2.exists()) {
                dir2.mkdirs();
            }
            File dir3 = new File(path + "/work3");
            if (!dir3.exists()) {
                dir3.mkdirs();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        String mm = "work1";//从work1开始判断，如果不为空就到下一个文件夹
        File backfile = new File(path + "/" + mm);
        if (backfile != null && backfile.exists() && backfile.isDirectory()) {
            File[] files = backfile.listFiles();
            if (files != null && files.length > 0) {
                mm = "work2";
            }
        }
        backfile = new File(path + "/" + mm);
        if (backfile != null && backfile.exists() && backfile.isDirectory()) {
            File[] files = backfile.listFiles();
            if (files != null && files.length > 0) {
                mm = "work3";
            }
        }

        String filePath1 = path + "/" + mm + "/work.txt";//得到文件路径和名称组合
        String filePath2 = path + "/" + mm + "/answer.txt";
        String filePath3 = path + "/" + mm + "/time.txt";

        try {
            writer = new FileWriter(filePath1);//写文件
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
        response.sendRedirect("makework.jsp?m=yes");
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
