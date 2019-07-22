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
	导入班级信息：
        
        <form name="create" action="${pageContext.request.contextPath}/createClass"enctype="multipart/form-data" method="post">
            <label >选择文件</label>
            <%--只允许选择一个excel--%>
            <input type="file" name="file" class="form-control" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" />
            <input type="submit" value="上传"  >
        </form>

            <br><a href="ManageFile.jsp">ManageFile.jsp</a>
    </body>
</html>
<script> 

//取出传回来的参数error并与yes比较
var error1 ='<%=request.getParameter("create")%>';
  if(error1==='no'){
   alert("请选择正确文件!");
  }
  if(error1==='yes'){
      confirm("创建成功！");
  }
 
</script>