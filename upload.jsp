<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="mybean.class_bean"%>
<%@page import="mybean.teacher_bean"%>
<%@page import="mybean.source_bean"%>

<jsp:useBean id="TeacherBean" type="mybean.teacher_bean" scope="session"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>UploadFile Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://www.layui.com/template/xianyan/demo/res/layui/css/layui.css">
        <link rel="stylesheet" href="https://www.layui.com/template/xianyan/demo/res/static/css/mian.css">
        <style>
            .class1{
                border-radius:5px;
                border:2px;
                width: 40pt;
                height: 27pt;
                color:white;
                background-color: #483f56;
                font-size:15px;
                padding: 10px;
                resize: none;
            }
            .footer{
                height: 20px;
                background-color: #ddd;
                position: fixed;
                bottom: 0;
            }
        </style>
    </head>
    <body class="lay-blog">
        <div class="header layui-bg-cyan">
            <div class="header-wrap">
                <h3 class="logo pull-left">
                    <a href="teaHomepage.jsp"><img src="https://www.layui.com/template/xianyan/demo/res/static/images/logo.png" alt="" class="logo-img"></a>
                    <font face="楷体" color="white">welcome!<jsp:getProperty name="TeacherBean" property="name"/></font>
                </h3>
            </div>
        </div>
        <div class="container - wrap">
            <div class="container">
                <div class="contar-wrap">
                    <br><br><br><br><br>
                    <div class="item">
                        <fieldset>
                            <%
                                String Cou_ID = request.getParameter("Cou_ID");
                                out.print("Couse ID:" + Cou_ID + "<br><br>");
                                request.getSession().setAttribute("couid", Cou_ID);
                            %>
                            <legend>上传单个文件</legend>
                            <form action="UploadServlet" method="post" enctype="multipart/form-data">
                                上传文件：
                                <input type="file" name="file"><br><br>
                                <input type="submit" class="class1" value="上传">
                                <br>
                            </form>
                        </fieldset> 
                    </div>
                </div>
            </div>
        </div>
        <!--
<fieldset>
    <legend>上传多个文件</legend>
    <form action="UploadServlet" method="post" enctype="multipart/form-data">
        上传文件：
        <input type="file" name="file1"><br>
        上传文件：
        <input type="file" name="file2"><br>
        <input type="submit" value="上传">
    </form>
</fieldset>
        -->
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

