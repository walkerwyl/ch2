<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>JSP Page</title>
    </head>
    <body>
        <h1>
            导入班级信息：
        </h1>
        <form name="create" action="createClass" enctype="multipart/form-data" method="post">
            <label >选择文件</label>
            <%--只允许选择一个excel--%>
            <input type="file" name="file" class="form-control" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" />
            <input type="submit" value="上传"  >
        </form>
        <h1>
            添加学生信息
        </h1>
        <form name="add" action="addStu_servlet" method="post">
            <input type="button" value="班级1" name="class_ID" />
           
            <input type="button" value="添加学生" onclick="input()"/>
            <script>
                function input() {
                     
                     document.getElementById("showDiv").style.display = "block";//显示输入框
                }
            </script>
            <div id="showDiv" style="display:none;">
                <script>
                function input() {
                    document.getElementById("showDiv").style.display = "block";//显示输入框
                }
                </script>
                <label>输入学生ID</label>
                <input type="text" name="stu_ID"/>
                
                <input type="submit" value="确定" />
            </div>
            
        </form>

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
  var error2 ='<%=request.getParameter("error")%>';
  if(error2==='yes'){
   alert("输入错误!");
  }
  if(error2==='no'){
      confirm("添加成功！");
  }
</script>
