<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
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
        <div class="header layui-bg-cyan">
            <div class="header-wrap ">
                <h3 class="logo pull-left">
                    <a href="teaHomepage.jsp">
                        <img src="https://www.layui.com/template/xianyan/demo/res/static/images/logo.png" alt="" class="logo-img"></a>
                    <font face="楷体" color="white">welcome!<jsp:getProperty name="TeacherBean" property="name"/></font>
                </h3>
                <h3 class="logo pull-right">
                    <a href="LogoutServlet">
                        <img src="pic/logout1.jpg" width="35" height="35"/>
                    </a>
                </h3>
            </div>
        </div>
        <div class="container - wrap">
            <div class="container">
                <div class="contar-wrap">
                    <br><br><br><br><br> &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                    <form name="create" action="${pageContext.request.contextPath}/createClass" enctype="multipart/form-data" method="post">
                        创建班级：<input type="file" style="opacity:0.8"  name="file" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" />  
                        <input type="submit" style="opacity:0.8" class="layui-btn layui-btn-primary layui-bg-cyan"  value="上传"/> <br><br>
                    </form>                          

                    <%
                        Set cources = new HashSet();
                        PreparedStatement ps, ps2, ps3;
                        ResultSet rs, rs2, rs3;
                        String couname = null;
                        ps = DB.dbCon().prepareStatement("SELECT * FROM class WHERE Tea_ID=?");
                        ps.setString(1, TeacherBean.getTea_ID());
                        rs = ps.executeQuery();
                        while (rs.next()) {
                            cources.add(rs.getString(1));
                        }

                        Iterator<String> couid = cources.iterator();
                        while (couid.hasNext()) {
                            String cou_id = couid.next();

                            ps3 = DB.dbCon().prepareStatement("SELECT * FROM class WHERE  Cou_ID=?");
                            ps3.setString(1, cou_id);
                            rs3 = ps3.executeQuery();//couname = rs3.getString(3)

                            while (rs3.next()) {
                                couname = rs3.getString(3);
                            }

                            ps2 = DB.dbCon().prepareStatement("SELECT * FROM class WHERE  Cou_ID=? AND Tea_ID=?");
                            ps2.setString(1, cou_id);
                            ps2.setString(2, TeacherBean.getTea_ID());
                            rs2 = ps2.executeQuery();

                            out.print("<div class='item'>");
                            out.print("<div class='item-box layer-photos-demo1 layer-photos-demo'><br><h2>课程：&emsp;" + couname);
                            out.print("</h2><div style='float:right '><a href=ManageFile.jsp?couid=" + cou_id + ">管理资源</a></div></div>");
                            while (rs2.next()) {
                                out.print("<div class='item-box  layer-photos-demo1 layer-photos-demo layui-bg-cyan'><br> &emsp;&emsp;&emsp;&emsp;&emsp;" + rs2.getString(2) + "班</div>");
                                out.print("<div class='comment count '><p><a href=info.jsp?classid=" + rs2.getString(2) + ">查看详细信息</a>");
                                out.print(" <a href=makeannounce.jsp?teaid=" + TeacherBean.getTea_ID() + "&couid=" + cou_id + "&classid=" + rs2.getString(2) + ">发布通知</a>");
                                out.print("<div class='comment count '><a href=makework.jsp?teaid=" + TeacherBean.getTea_ID() + "&couid=" + cou_id + "&classid=" + rs2.getString(2) + ">发布作业</a><a href=source.jsp?couname=" + rs2.getString(3) + "&teaname=" + TeacherBean.getName()+ ">批改作业</a></p></div></div>");

                            }
                            out.print("</div>");
                        }
                    %>
                </div>
            </div>
        </div>
        <br><br><br><br>
        <script src="https://www.layui.com/template/xianyan/demo/res/layui/layui.js"></script>
        <script>
            layui.config({
                base: '../res/static/js/'
            }).use('blog');
        </script>
    </body>
</html>
