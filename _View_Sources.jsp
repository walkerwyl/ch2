<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="myservlet.DB"%>
<%@page import="java.util.Iterator"%>
<%@page import="mybean.student_bean"%>
<%@page import="mybean.info_bean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="StudentBean" type="mybean.student_bean" scope="session"/>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>查看资源</title>
    </head>
    <body>
        课程如下<br><br>
        <%
            try{
                String stuid = StudentBean.getStu_ID();
                PreparedStatement ps1= DB.dbCon().prepareStatement("select * from info where Stu_ID=?");
                PreparedStatement ps2= DB.dbCon().prepareStatement("select * from class where Class_ID=?");
                PreparedStatement ps3= DB.dbCon().prepareStatement("select * from teacher where Tea_ID=?");
                PreparedStatement ps4= DB.dbCon().prepareStatement("select * from source where Tea_ID=? and Cou_ID=?");
                ResultSet rs1,rs2,rs3,rs4;
                String path = request.getServletContext().getRealPath("/");
                
                ps1.setString(1, stuid);
                rs1 = ps1.executeQuery();
                while(rs1.next()){
                    ps2.setString(1, rs1.getString(1));
                    rs2 = ps2.executeQuery();
                    while(rs2.next()){
                        out.print("<br>课程：");
                        out.print(rs2.getString(3));
                        out.print("——老师：");
                    
                        ps3.setString(1, rs2.getString(4));
                        rs3 = ps3.executeQuery();
                        while(rs3.next()){out.print(rs3.getString(1));}
                    
                        out.print("——班级：");
                        out.print(rs1.getString(1));
                        
                        ps4.setString(1, rs2.getString(4));
                        ps4.setString(2, rs2.getString(1));
                        rs4 = ps4.executeQuery();
                        while(rs4.next()){
                            out.print("<PRE>资源名称：");
                                out.print(rs4.getString(6));
                                out.print("—类型：");
                                out.print(rs4.getInt(3));
                                out.print("—资源总浏览次数：");
                                out.print(rs4.getInt(5));
                                if(rs4.getInt(3) == 0){
                                    out.print("<a href=View_Markdown.jsp?teaid="+rs2.getString(4)+"&couid="+rs2.getString(1)+"&souname="+rs4.getString(6)+"&souid=" + rs4.getString(4)+ "&classid=" + rs1.getString(1) +">查看资源</a>");
                                }
                                else if(rs4.getInt(3) == 1){
                                    out.print("<a href=View_PPT.jsp?teaid="+rs2.getString(4)+"&couid="+rs2.getString(1)+"&souname="+rs4.getString(6)+"&souid=" + rs4.getString(4) + "&classid="+rs1.getString(1) +">查看资源</a>");
                                }
                                else{
                                    out.print("<a href=View_Video.jsp?teaid="+rs2.getString(4)+"&couid="+rs2.getString(1)+"&souname="+rs4.getString(6)+"&souid=" + rs4.getString(4) + "&classid="+rs1.getString(1) +">查看资源</a>");
                                }
                                out.print("</PRE>");
                        }
                    }
                }
            }catch(Exception e){
                out.print(e);
            };
	out.print("<br><a href=Stu_Homepage2.jsp>返回主页</a>");
        %>
    </body>
</html>
