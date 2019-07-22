<%@page import="java.sql.ResultSet"%>
<%@page import="myservlet.DB"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Iterator"%>
<%@page import="mybean.teacher_bean"%>
<%@page import="mybean.class_bean"%>
<%@page import="mybean.source_bean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="TeacherBean" type="mybean.teacher_bean" scope="session"/>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>教师主页</title>
    </head>
    <body>
        
       欢迎,<jsp:getProperty name="TeacherBean" property="name"/>
	<form name="create" action="${pageContext.request.contextPath}/createClass"enctype="multipart/form-data" method="post">
            <label >新建班级</label>
            <%--只允许选择一个excel--%>
            <input type="file" name="file" class="form-control" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" />
            <input type="submit" value="上传"  class="layui-btn layui-btn-fluid" lay-submit lay-filter="LAY-user-login-submit">
        </form>

        
        <%
            PreparedStatement ps,ps2,ps3;
            ResultSet rs,rs2,rs3;
            ps = DB.dbCon().prepareStatement("SELECT * FROM class WHERE Tea_ID=?");
            ps.setString(1,TeacherBean.getTea_ID());
            rs = ps.executeQuery();
            while(rs.next()){
                out.print("<br><h2>课程："+rs.getString(3)+"</h2><br>");
                ps2 = DB.dbCon().prepareStatement("SELECT * FROM class WHERE  Cou_ID=? AND Tea_ID=?");
                ps2.setString(1, rs.getString(1));
                ps2.setString(2, TeacherBean.getTea_ID());
                rs2 = ps2.executeQuery();
                while(rs2.next()){
                    out.print("<br>班级:"+rs2.getString(2));
                    out.print("    <a href=Class_Homepage.jsp>查看详细信息</a>"); 
                    out.print("    <a href=makeannounce.jsp?teaid="+ TeacherBean.getTea_ID() + "&couid=" + rs.getString(1) + "&classid=" + rs2.getString(2) + ">查看教学资源</a>"); 
                    out.print("    <a href=makework.jsp?teaid="+ TeacherBean.getTea_ID() + "&couid=" + rs.getString(1) + "&classid=" + rs2.getString(2) + ">发布作业</a>"); 
                    out.print("<br><br>");
                }
                out.print("<a href=ManageFile.jsp?couid=" + rs.getString(1) + ">管理教学资源</a><br>"); 
            }
        %>
	    </body>
</html>
<script> 

//取出传回来的参数error并与yes比较
var error1 ='<%=request.getParameter("create")%>';
  if(error1==='no'){
   alert("请选择正确文件!");
   error1=0;
  }
  if(error1==='yes'){
      confirm("创建成功！");
      error1=0;
  }
</script>
