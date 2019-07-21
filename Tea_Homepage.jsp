<%@page import="java.util.Iterator"%>
<%@page import="mybean.class_bean"%>
<%@page import="mybean.teacher_bean"%>
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
                
        名字:<jsp:getProperty name="TeacherBean" property="name"/>
        ID:<jsp:getProperty name="TeacherBean" property="tea_ID"/>
        <%--property中tes_ID首字母保持一致
<%--        
        <%
            Iterator<class_bean> it = TeacherBean.classes.iterator();	
                while (it.hasNext()) {		
                    class_bean n = it.next();
                    %>
                    成绩1：<%=%>
                    成绩2：<%=%>
                    成绩3：<%=%>
                    <%
                }
        %>
--%>
            <br><a href="ManageFile.jsp">ManageFile.jsp</a>
    </body>
</html>