package myservlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

//@WebServlet(name="DeleteServlet", urlPatterns="/DeleteServlet")
public class delete extends HttpServlet {

    public void init(ServletConfig config) throws ServletException {
        super.init();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        String teaid = (String) request.getParameter("teaid");
        String couid = (String) request.getParameter("couid");
        String classid = (String) request.getParameter("classid");
        String filename = (String) request.getParameter("filename");

        String deletePath = request.getServletContext().getRealPath("/upload/" + teaid + "/" + couid + "/" + classid + "/announce/" + filename);
        //首先从数据库中删除对应的数据，然后从老师资源库中删除对应的文件
        try {
            deleteFile(deletePath);

            //response.setContentType("text/html;charset=UTF-8");
            //PrintWriter out = response.getWriter();
            //out.println("<html><body>");
            //out.println("Sou_Name=" + sou_name+ "的资源已删除");
            //out.println(deletePath);
            //out.println("<a href=Tea_Homepage.jsp>回到教师主页面</a>");
            //out.println("<a href=ManageFile.jsp>回到ManageFile.jsp页面</a>");
            //out.println("</html></body>");
            //RequestDispatcher dispatcher = request.getRequestDispatcher("ManageFile.jsp?couid="+couid);
            //dispatcher.forward(request, response);
            response.getWriter().print("<script type='text/javascript' charset='UTF-8'>confirm(删除成功);windows.location='ManageFile.jsp?couid=" + couid + "'</script>");

        } catch (Exception e) {
        }
        response.sendRedirect("teaHomepage.jsp?");
    }

    public void deleteFile(String path) {
        File f = new File(path);
        f.delete();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

}
