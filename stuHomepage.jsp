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
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://www.layui.com/template/xianyan/demo/res/layui/css/layui.css">
        <link rel="stylesheet" href="https://www.layui.com/template/xianyan/demo/res/static/css/mian.css">
    </head>
    <body class="lay-blog">
        <div class="header layui-bg-green">
            <div class="header-wrap">
                <h3 class="logo pull-left">
                    <a href="stuHomepage.jsp">
                        <img src="https://www.layui.com/template/xianyan/demo/res/static/images/logo.png" alt="" class="logo-img"></a>
                    <font face="楷体" color="white">welcome!<jsp:getProperty name="StudentBean" property="name"/></font>
                </h3>
            </div>
        </div>
        <div class="container - wrap">
            <div class="container">
                <div class="contar-wrap">
                    <br><br><br><br><br>
                    <div class="comment count"> <a href=viewSources.jsp>查看教学资源</a></div>
                    <br> 
                    <%
                        String stuid = StudentBean.getStu_ID();
                        PreparedStatement ps1, ps2, ps3;
                        ResultSet rs1, rs2, rs3;
                        ps1 = DB.dbCon().prepareStatement("select * from info where Stu_ID=?");
                        ps2 = DB.dbCon().prepareStatement("select * from class where Class_ID=?");
                        ps3 = DB.dbCon().prepareStatement("select * from teacher where Tea_ID=?");
                        ps1.setString(1, stuid);
                        rs1 = ps1.executeQuery();
                        while (rs1.next()) {
                            ps2.setString(1, rs1.getString(1));
                            rs2 = ps2.executeQuery();
                            out.print("<div class='item'>");
                            while (rs2.next()) {
                                out.print("<div class='item-box layui-bg-green layer-photos-demo1 layer-photos-demo'><h3>");
                                out.print("<br>课程：" + rs2.getString(3));
                                out.print("<div style='float:right'>" + "老师：");
                                ps3.setString(1, rs2.getString(4));
                                rs3 = ps3.executeQuery();
                                while (rs3.next()) {
                                    out.print(rs3.getString(1));
                                }
                                out.print("&emsp;&emsp;" + "班级：" + rs1.getString(1));
                                out.print("&emsp;&emsp;&emsp;<div class='layui-btn layui-btn-primary' ><a href=readAnnounce.jsp?classid=" + rs1.getString(1) + ">查看通知</a></div></div></div>");
                                out.print("<br><div class='item-box  layer-photos-demo1 layer-photos-demo'>学习次数：" + rs1.getInt(6));
                                out.print("&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;" + "学习时间：" + rs1.getInt(7) + "min");
                                out.print("<br><br></h3>");
                                out.print("作业1：" + "&emsp;&emsp;&emsp;" + "成绩：" + rs1.getFloat(3));
                                out.print(" <div style='float:left'><a href=doHomework.jsp?name=work1&teaid=" + rs2.getString(4) + "&couid=" + rs2.getString(1) + "&classid=" + rs1.getString(1) + "&id=" + stuid + "><img src='pic/write.png'width='35' height='35'/>&emsp;&emsp;&emsp;</a></div>");
                                out.print("<br><br>作业2：" + "&emsp;&emsp;&emsp;" + "成绩：" + rs1.getFloat(4));
                                out.print(" <div  style='float:left'><a href=doHomework.jsp?name=work2&teaid=" + rs2.getString(4) + "&couid=" + rs2.getString(1) + "&classid=" + rs1.getString(1) + "&id=" + stuid + "><img src='pic/write.png'width='35' height='35'/>&emsp;&emsp;&emsp;</a></div>");
                                out.print("<br><br>作业3：" + "&emsp;&emsp;&emsp;" + "成绩：" + rs1.getFloat(5));
                                out.print(" <div  style='float:left'><a href=doHomework.jsp?name=work3&teaid=" + rs2.getString(4) + "&couid=" + rs2.getString(1) + "&classid=" + rs1.getString(1) + "&id=" + stuid + "><img src='pic/write.png'width='35' height='35'/>&emsp;&emsp;&emsp;</a></div></div>");

                            }
                            out.print("</div>");
                        }

                    %>
                </div>
            </div>
        </div>
        <script src="https://www.layui.com/template/xianyan/demo/res/layui/layui.js"></script>
        <script>
            layui.config({
                base: '../res/static/js/'
            }).use('blog');
        </script>

    </body>
</html>