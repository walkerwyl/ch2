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
        <title>学生主页</title>
    </head>
    <body>
        名字:<jsp:getProperty name="StudentBean" property="name"/>
        
        <%
	    String stuid = StudentBean.getStu_ID();
            PreparedStatement ps1,ps2,ps3;
            ResultSet rs1,rs2,rs3;
            ps1 = DB.dbCon().prepareStatement("select * from info where Stu_ID=?");
            ps2 = DB.dbCon().prepareStatement("select * from class where Class_ID=?");
            ps3 = DB.dbCon().prepareStatement("select * from teacher where Tea_ID=?");
            ps1.setString(1, stuid);
            rs1 = ps1.executeQuery();
            while (rs1.next()) {
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
                    out.print("<br>");
                    out.print("学习次数：");
                    out.print(rs1.getInt(6));
                    out.print("    学习时间：");
                    out.print(rs1.getInt(7));
                    out.print("<br>");
                    out.print("<PRE>作业1：  成绩：");
                    out.print(rs1.getFloat(3));
                    out.print("  <a href=Do_Homework.jsp?name=work1&teaid="+rs2.getString(4)+"&couid="+rs2.getString(1)+"&classid="+rs1.getString(1)+"&id="+stuid+">写作业</a>");
                    out.print("<br>作业2：  成绩：");
                    out.print(rs1.getFloat(4));
                    out.print("  <a href=Do_Homework.jsp?name=work1&teaid="+rs2.getString(4)+"&couid="+rs2.getString(1)+"&classid="+rs1.getString(1)+"&id="+stuid+">写作业</a>");
                    out.print("<br>作业3：  成绩：");
                    out.print(rs1.getFloat(5));
                    out.print("  <a href=Do_Homework.jsp?name=work1&teaid="+rs2.getString(4)+"&couid="+rs2.getString(1)+"&classid="+rs1.getString(1)+"&id="+stuid+">写作业</a>");
                    out.print("<br><a href=readannounce.jsp?classid=");
		    out.print(rs1.getString(1));
		    out.print(">查看通知</a>");

                    out.print("</PRE>");
                    }
            }            
            out.print("<a href=View_Sources.jsp>查看教学资源</a>"); 
        %>
    </body>
</html>