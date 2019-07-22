package myservlet;

import mybean.student_bean;
import mybean.teacher_bean;
import mybean.class_bean;
import mybean.source_bean;
import mybean.info_bean;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {
	@SuppressWarnings("unchecked")
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession ss = request.getSession(true);
        
        String id = request.getParameter("id");
        String pwd = request.getParameter("password");
        String identity = request.getParameter("identity");
        
        if(!id.equals(null)&&!pwd.equals(null)){
  
            try{
                PreparedStatement ps;
                if(identity.equals("teacher")){
                    ps = DB.dbCon().prepareStatement("select * from teacher where Tea_ID=? and Password=?");
                }
                else{
                    ps = DB.dbCon().prepareStatement("select * from student where Stu_ID=? and Password=?");
                }
                ps.setInt(1, Integer.parseInt(id));
                ps.setString(2, pwd);
                ResultSet rs = ps.executeQuery();
                
                if(rs.next()){
                    if(identity.equals("teacher")){
                        teacher_bean tea = new teacher_bean();
                        ss.setAttribute("TeacherBean", tea);
                        
                        tea.setName(rs.getString(1));
                        tea.setTea_ID(rs.getString(2));
                        tea.setGender(rs.getInt(3));
                        
                        
                        ps = DB.dbCon().prepareStatement("select * from source where Tea_ID=?");
                        ps.setInt(1, Integer.parseInt(id));
                        rs = ps.executeQuery();
                        
//                        while(rs.next()){
//                           source_bean source = new source_bean();
//                            source.setTea_ID(rs.getString(1));
//                            source.setCou_ID(rs.getString(2));
//                            source.setType(rs.getInt(3));
//                            source.setSou_ID(rs.getString(4));
//                            source.setSum_Count(rs.getInt(5));
//                            source.setSou_Name(rs.getString(6));
//                            source.setShare(rs.getInt(7));
//                            tea.sources.add(source);
//                        }
                        
//                        ps = DB.dbCon().prepareStatement("select * from class where Tea_ID=?");
//                        ps.setInt(1, Integer.parseInt(id));
//                        rs = ps.executeQuery();
                        
//                        while(rs.next()){
//                            class_bean class1 = new class_bean();
//                            class1.setCou_ID(rs.getString(1));
//                            class1.setClass_ID(rs.getString(2));
//                            class1.setCou_Name(rs.getString(3));
//                            class1.setTea_ID(rs.getString(4));
//                            tea.classes.add(class1);
//                        }
                        
                        RequestDispatcher dis = request.getRequestDispatcher("Tea_Homepage.jsp");
                        dis.forward(request, response);
                    }
                    
                    else{
                        student_bean stu = new student_bean();
                        ss.setAttribute("StudentBean", stu);
                        
                        stu.setName(rs.getString(1));
                        stu.setStu_ID(rs.getString(2));
                        stu.setGender(rs.getInt(4));
                        
                        
                        ps = DB.dbCon().prepareStatement("select * from info where Stu_ID=?");
                        ps.setInt(1, Integer.parseInt(id));
                        rs = ps.executeQuery();
                        
                        while(rs.next()){
                            info_bean info = new info_bean();
                            info.setClass_ID(rs.getString(1));
                            info.setStu_ID(rs.getString(2));
                            info.setWork1(rs.getFloat(3));
                            info.setWork2(rs.getFloat(4));
                            info.setWork3(rs.getFloat(5));
                            info.setMy_Count(rs.getInt(6));
                            info.setMy_Time(rs.getInt(7));
                            info.setStu_Name(rs.getString(8));
                            stu.infos.add(info);
                        }
                        
                        RequestDispatcher dis = request.getRequestDispatcher("Stu_Homepage.jsp");
                        dis.forward(request, response);
                    }
                }else{
                    //rr.setFlag("Wrong id or password!");
                    RequestDispatcher dis = request.getRequestDispatcher("LoginError.jsp");
                    dis.forward(request, response);
                }
            }
            catch(Exception e){};
        }else{
            //rr.setFlag("id or password can not be null");
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
