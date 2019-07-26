<%-- 
    Document   : login2
    Created on : 2019-7-22, 14:57:17
    Author     : liqr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>登陆 - OLAS</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
        <link rel="stylesheet" href="https://www.layui.com/admin/std/dist/layuiadmin/layui/css/layui.css" media="all">
        <link rel="stylesheet" href="https://www.layui.com/admin/std/dist/layuiadmin/style/admin.css" media="all">
        <link rel="stylesheet" href="https://www.layui.com/admin/std/dist/layuiadmin/style/login.css" media="all">

    </head>



    <body background='pic/bg2.png'>

        <div class="bodystyle"></div>
        <form action="LoginServlet" method="post">
            <div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">
                <div class="layadmin-user-login-main">
                    <div class="layadmin-user-login-box layadmin-user-login-header">
                        <h2>WELCOME TO OLAS!</h2>
                        <p>欢迎登陆在线学习辅助系统</p>
                    </div>
                    <div class="layadmin-user-login-box layadmin-user-login-body layui-form">
                        <div class="layui-form-item">
                            <label class="layadmin-user-login-icon layui-icon layui-icon-username" for="LAY-user-login-username"></label>
                            <input type="text" name="id" id="LAY-user-login-username" lay-verify="required" placeholder="用户名（ID)" class="layui-input">
                        </div>
                        <div class="layui-form-item">
                            <label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-password"></label>
                            <input type="password" name="password" id="LAY-user-login-password" lay-verify="required" placeholder="密码" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item" style="margin-bottom: 20px;">
                        <center>  <p>选择您的身份<br><br>
                                <input type="radio" name="identity" checked value="teacher" lay-skin="primary"/>老师

                                <input type="radio" name="identity" value="student" lay-skin="primary"/>学生</p>
                        </center>
                    </div>
                    <div class="layui-form-item">

                        <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="LAY-user-login-submit" >登 陆</button>

                    </div>
                </div>
            </div>
        </form>
    </body>
</html>
