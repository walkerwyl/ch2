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
        <style>
            .footer{
                height: 20px;
                background-color: #ddd;
                position: fixed;
                bottom: 0;
            }

        </style>

    </head>
    <body class="lay-blog">
        <div class="header">
            <div class="header-wrap">
                <h3 class="logo pull-left">
                    <a href="Tea_Homepage2.jsp">
                        <img src="https://www.layui.com/template/xianyan/demo/res/static/images/logo.png" alt="" class="logo-img"></a>
                    <font face="楷体" color="white">welcome!<jsp:getProperty name="TeacherBean" property="name"/></font>
                </h3>
            </div>
        </div>
        <div class="container - wrap">
            <div class="container">
                <div class="contar-wrap">
                    <br><br><br><br><br> &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                    <form name="create" action="${pageContext.request.contextPath}/createClass"enctype="multipart/form-data" method="post">
                        <i class="layui-icon layui-icon-add1"> 创建班级</i><input type="file" style="opacity:0.5" name="file" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" />  
                         <input type="submit" class="layui-btn layui-btn-normal" style="height:33px;width:70px"value="上传"/> 
                         <br><br>
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
                            out.print("<div class='item-box  layer-photos-demo1 layer-photos-demo' style='color:#393D49'><h3>" + couname + "</div>");
                            out.print("<div class='comment count'><a href=ManageFile.jsp?couid=" + cou_id + ">管理教学资源</a></div>");
                            while (rs2.next()) {
                                out.print("<div class='item-box  layer-photos-demo1 layer-photos-demo' style='color:#009688'>" + rs2.getString(2) + "班</h3></div>");
                                out.print("<div class='comment count'> <p><a href=info.jsp>查看详细信息</a>");
                                out.print(" <a href=makeannounce2.jsp?teaid=" + TeacherBean.getTea_ID() + "&couid=" + cou_id + "&classid=" + rs2.getString(2) + ">发布通知</a>");
                                out.print(" <a href=makework.jsp?teaid=" + TeacherBean.getTea_ID() + "&couid=" + cou_id + "&classid=" + rs2.getString(2) + ">发布作业</a></p></div>");

                            }
                            out.print("</div>");
                        }
                    %>
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