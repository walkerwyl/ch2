<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="myservlet.DB"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="mybean.teacher_bean" %>
<%@page import="mybean.source_bean" %>
<%@page import="mybean.class_bean"%>
<jsp:useBean id="TeacherBean" type="mybean.teacher_bean" scope="session"/>

<!DOCTYPE html>
<html>
    <head>
        <title>ManageFile Page</title>
    </head>
    <body>
<table>
    
    <tr>
        <th>资源编号：</th>
        <th>资源名称:</th>
        <th>资源所属课程:</th>
        <th>资源状态：</th>
        <th>资源的操作:</th>
    </tr>
    
<%
	String tea_id = TeacherBean.getTea_ID();
	try{
	PreparedStatement ps;
	ps = DB.dbCon().prepareStatement("SELECT * FROM source WHERE Tea_ID=?");
	ps.setString(1, tea_id);
//	ps.executeUpdate();
	ResultSet rs = ps.executeQuery();
	while(rs.next()){
%>
    <tr>
        <th><%=rs.getString(4)%></th>
        <th><%=rs.getString(6)%></th>
        <th><%=rs.getString(2)%></th>
        <th>
<%
	if( 0==rs.getInt(7) ){
		%>共享<%
	}
	else{
		%>不共享<%
	}
%>
	</th>
        <th>
	<% out.print("<a href=upload.jsp?Cou_ID=" + rs.getString(2) + ">上传</a>"); %>
        <% out.print("<a href=DeleteServlet?Cou_ID=" + rs.getString(2) + "&Sou_Name=" + rs.getString(6) + ">删除</a>"); %>
        <% out.print("<a href=ChangeShareServlet?Sou_ID=" + rs.getString(4) + "&Share=" + rs.getInt(7)+ ">更改资源状态</a>"); %>
	</th>
    </tr>
<%}}
catch(Exception e){out.println(e);}
%>

</table>


<!--这里就只是转回主页面-->
<a href="Tea_Homepage.jsp">返回教师主页面</a>
<!--转交给另一个Servlet收集教学组的所有共享资源-->
<a href="MoreServlet">more>></a>

    </body>
</html>
