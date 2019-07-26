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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");   //解决乱码所必须

        String teaid = (String) request.getParameter("teaid");
        String couid = (String) request.getParameter("couid");
        String classid = (String) request.getParameter("classid");
        String filename = (String) request.getParameter("filename");

        String deletePath = request.getServletContext().getRealPath("/upload/" + teaid + "/" + couid + "/" + classid + "/announce/" + filename);
        //首先从数据库中删除对应的数据，然后从老师资源库中删除对应的文件
        try {
            deleteFile(deletePath);
        } catch (Exception e) {
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("makeannounce.jsp?couid=" + couid + "&teaid=" + teaid + "&classid=" + classid);
        dispatcher.forward(request, response);
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
