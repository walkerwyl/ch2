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

    public void doPost(HttpServletRequest request, HttpServletResponse response)  {

        try {
            request.setCharacterEncoding("UTF-8");
            String stu_ID = request.getParameter("stu_ID");
            String stu_name=null,class_ID=null;
            class_ID="1223";
// = request.getParameter("class_ID");
            
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://112.74.58.75:3306/OLAS_DB?useUnicode=true&characterEncoding=utf-8", "root", "41710020wys");
            PreparedStatement ps;
            ps = con.prepareStatement("select Name,Stu_ID from student");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                if (rs.getString(2).equals(stu_ID)) {
                    break;
                }
            }
            if(rs.isAfterLast()){
               response.sendRedirect("class_info.jsp?error=yes");
            }
            stu_name = rs.getString(1);
            ps = con.prepareStatement("insert into info(Class_ID,Stu_ID,Stu_Name) values(?,?,?)");
            ps.setString(1, class_ID);
            ps.setString(2, stu_ID);
            ps.setString(3, stu_name);
            ps.executeUpdate();
            response.sendRedirect("class_info.jsp?error=no");
            

        } catch (Exception ex) {
            try {
                response.getWriter().print(ex);
            } catch (IOException ex1) {
                Logger.getLogger(addStu_servlet.class.getName()).log(Level.SEVERE, null, ex1);
            }
        }

    }
}
