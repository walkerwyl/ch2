
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="mybean.teacher_bean"%>
<!DOCTYPE html>
<jsp:useBean id="TeacherBean" type="mybean.teacher_bean" scope="session"/>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>makeannnounce2</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://www.layui.com/template/xianyan/demo/res/layui/css/layui.css">
        <link rel="stylesheet" href="https://www.layui.com/template/xianyan/demo/res/static/css/mian.css">
        <style>
 	        .class2{
                border:1;
                border-radius:5px;
                width: 730px;
                height: 240px;
                padding: 10px;
                resize: none; 
            }
            h1 {
                font-family: Consolas, monaco, monospace;
                font-size: 20px;
                font-style: normal;
                font-variant: normal;
                font-weight: 500;
                line-height: 23px;
            }
            .footer{
                height: 20px;
                background-color: #ddd;
                position: fixed;
                bottom: 0;
            }
            .class1{
                border-radius:5px;
                border:2px;
                width: 40pt;
                height: 28pt;
                color:white;
                background-color: #1e9eff;
                font-size:13px;
                padding: 10px;
                resize: none;
            }
            body {
                overflow-x: none;
            }
        </style>
    </head>
    <body class="lay-blog">
        <div class="header">
            <div class="header-wrap">
                <h3 class="logo pull-left">
                    <a href="Tea_Homepage2.jsp"><img src="https://www.layui.com/template/xianyan/demo/res/static/images/logo.png" alt="" class="logo-img"></a>
                    <font face="楷体" color="white">welcome!<jsp:getProperty name="TeacherBean" property="name"/></font>
                </h3>
            </div>
        </div>
        <%
            String teaid = request.getParameter("teaid");//获取传递过来的参数
            String couid = request.getParameter("couid");
            String classid = request.getParameter("classid");
        %>
        <div class="container - wrap">
            <div class="container">
                <div class="contar-wrap">
                    <br><br><br><br><br>
                    <div class="item">               
                        <h1>Class:<%=classid%><br><br>编辑要发布的通知内容：</h1><br>           
                        <form method="post" action="makeannounce?teaid=<%=teaid%>&couid=<%=couid%>&classid=<%=classid%>">
                            <h1><textarea  name="ann" class="class2" placeholder="Start here."></textarea></h1>
                            <br>
                            <input type="submit" class="class1" value="发布"/>
                            <br><br>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <br><br><br><br>
        <div class="footer">
            <p><span>欢迎使用OLAS</span></p>
        </div>
        <script src="https://www.layui.com/template/xianyan/demo/res/layui/layui.js"></script>
        <script>
            layui.config({
                base: '../res/static/js/'
            }).use('blog');
        </script>  
    </body>
</html>
<script>

//取出传回来的参数error并与yes比较
    var error1 = '<%=request.getParameter("make")%>';
    if (error1 === 'no') {
        alert("发布失败!");
    }
    if (error1 === 'yes') {
        confirm("发布成功！");
    }
</script>

