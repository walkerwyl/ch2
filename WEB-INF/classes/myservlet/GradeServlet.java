package myservlet;

import myservlet.DB;
import mybean.teacher_bean;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "GradeServlet", urlPatterns = {"/GradeServlet"})
public class GradeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("text/html;charset=UTF-8");
            request.setCharacterEncoding("UTF-8");

            String classid = request.getParameter("classid");
            String stuid = request.getParameter("stuid");
            String workname = request.getParameter("workname");
            String grade = request.getParameter("grade");
            String couname = "";

            PreparedStatement ps2 = DB.dbCon().prepareStatement("SELECT * FROM class WHERE Class_ID=?");
            ps2.setString(1, classid);
            ResultSet rs = ps2.executeQuery();
            while (rs.next()) {
                couname = rs.getString(3);
            }

            float truegrade = Float.parseFloat(grade);

            PreparedStatement ps = DB.dbCon().prepareStatement("UPDATE info SET " + workname + "=? WHERE Class_ID=? AND Stu_ID=?");
            ps.setFloat(1, truegrade);
            ps.setString(2, classid);
            ps.setString(3, stuid);
            ps.executeUpdate();

            RequestDispatcher dis = request.getRequestDispatcher("source.jsp?couname=" + couname);
            dis.forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(GradeServlet.class.getName()).log(Level.SEVERE, null, ex);
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
