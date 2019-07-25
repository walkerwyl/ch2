package myservlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class addStu_servlet extends HttpServlet {

    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doPost(req, res);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) {

        try {
            request.setCharacterEncoding("UTF-8");
            String stu_ID = request.getParameter("stu_ID");
            String stu_name = null, class_ID = null;
            class_ID = request.getParameter("class_ID");

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://112.74.58.75:3306/OLAS_DB?useUnicode=true&characterEncoding=utf-8", "root", "41710020wys");
            PreparedStatement ps;
            ps = con.prepareStatement("select Name from student where Stu_ID=" + stu_ID);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
              response.getWriter().print("<script type='text/javascript' charset='UTF-8'>confirm('failed  student not found');window.location='info.jsp';</script>");
              //  response.getWriter().print("not found");
            }
            stu_name = rs.getString(1);
            ps = con.prepareStatement("insert into info values(?,?,0,0,0,0,0,?)");
            ps.setString(1, class_ID);
            ps.setString(2, stu_ID);
            ps.setString(3, stu_name);
            ps.executeUpdate();
            //response.getWriter().print("success");
            response.getWriter().print("<script type='text/javascript' charset='UTF-8'>confirm('success');window.location='info.jsp';</script>");

        } catch (Exception ex) {
           
           try {
                response.getWriter().print("<script type='text/javascript' charset='UTF-8'>confirm('failed');window.location='info.jsp';</script>");
           // response.getWriter().print(ex);
           } catch (IOException ex1) {
                Logger.getLogger(addStu_servlet.class.getName()).log(Level.SEVERE, null, ex1);
            }
        }

    }
}
