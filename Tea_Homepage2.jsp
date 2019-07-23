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
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://www.layui.com/template/xianyan/demo/res/layui/css/layui.css">
        <link rel="stylesheet" href="https://www.layui.com/template/xianyan/demo/res/static/css/mian.css">

    </head>
    <body class="lay-blog">
        <div class="header">
            <div class="header-wrap">
                <h1 class="logo pull-left">
                    <a href="javascript：void(0)" onclick="history.go(0)"><!--刷新-->
                        <img src="https://www.layui.com/template/xianyan/demo/res/static/images/logo.png" alt="" class="logo-img">
                        <font face="楷体" color="white"><jsp:getProperty name="TeacherBean" property="name"/></font>
                    </a>
                </h1>
                <div class="blog-nav pull-right">
                    <ul class="layui-nav pull-left">
                        <li class="layui-nav-item">
                            <form name="create" action="${pageContext.request.contextPath}/createClass"enctype="multipart/form-data" method="post">
                                <input type="file" style="float: left" name="file" placeholder="选择班级信息"  accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" />
                                <input type="submit" class="layui-btn layui-btn-normal" placeholder="上传"/> 
                            </form>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="container - wrap">
            <div class="container">
                <div class="contar-wrap">

                    <%
                        PreparedStatement ps, ps2, ps3;
                        ResultSet rs, rs2, rs3;
                        ps = DB.dbCon().prepareStatement("SELECT * FROM class WHERE Tea_ID=?");
                        ps.setString(1, TeacherBean.getTea_ID());
                        rs = ps.executeQuery();
                        while (rs.next()) {

                    %> 
                    <div class="item">
                        <div class="item-box  layer-photos-demo1 layer-photos-demo">
                            <% out.print("<h3 >" + rs.getString(3));
                                ps2 = DB.dbCon().prepareStatement("SELECT * FROM class WHERE  Cou_ID=? AND Tea_ID=?");
                                ps2.setString(1, rs.getString(1));
                                ps2.setString(2, TeacherBean.getTea_ID());
                                rs2 = ps2.executeQuery();
                                while (rs2.next()) {
                                    out.print("--" + rs2.getString(2) + "班</h3>");
                            %>
                            <div class='comment count'> 
                                <%  out.print("<p><a href=Class_Homepage.jsp>查看详细信息</a>");
                                            out.print(" <a href=makeannounce.jsp?teaid=" + TeacherBean.getTea_ID() + "&couid=" + rs.getString(1) + "&classid=" + rs2.getString(2) + ">发布通知</a>");
                                            out.print(" <a href=makework.jsp?teaid=" + TeacherBean.getTea_ID() + "&couid=" + rs.getString(1) + "&classid=" + rs2.getString(2) + ">发布作业</a>");

                                        }
                                        out.print("<a href=ManageFile.jsp?couid=" + rs.getString(1) + ">管理教学资源</a></p>");
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                    </div>
            </div>
        </div>        

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
