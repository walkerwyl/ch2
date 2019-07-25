<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="myservlet.DB"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="mybean.teacher_bean" %>
<%@page import="mybean.source_bean" %>
<%@page import="mybean.class_bean"%>
<jsp:useBean id="TeacherBean" type="mybean.teacher_bean" scope="session"/>

<html>
    <head>
        <title>管理教学资源</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://www.layui.com/template/xianyan/demo/res/layui/css/layui.css">
        <link rel="stylesheet" href="https://www.layui.com/template/xianyan/demo/res/static/css/mian.css">
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
                <br><br><br><br><br>
        <div class="container - wrap">
            <div class="container">
                <div class="contar-wrap"> 
                    <%
                        String teaid = TeacherBean.getTea_ID();
                        String couid = request.getParameter("couid");
                        try {
                            PreparedStatement ps;
                            ps = DB.dbCon().prepareStatement("SELECT * FROM source WHERE Tea_ID=? AND Cou_ID=?");
                            ps.setString(1, teaid);
                            ps.setString(2, couid);
                            //	ps.executeUpdate();
                            ResultSet rs = ps.executeQuery();
                    %>
                    <div class="comment count">
                        <p> <% out.print("<a href=upload.jsp?Cou_ID=" + couid + ">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;上传资源</a>");%>
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;  <a href="MoreServlet">查看共享资源</a></p>
                    </div>  
                    <br>
                    <%
                        while (rs.next()) {
                    %>
                    <div class="item">
                        <div class="item-box  layer-photos-demo1 layer-photos-demo">
                            编号：<%=rs.getString(4)%>
                            &emsp;&emsp;&emsp;&emsp;&emsp;文件名：<%=rs.getString(6)%>
                            &emsp;&emsp;&emsp;&emsp;&emsp;状态：
                            <%	if (0 == rs.getInt(7)) {
                            %>共享<%
                            } else {
                            %>不共享<%
                                }
                            %>
                        </div>
                        <div class="comment count">
                            <% out.print("<a href=DeleteServlet?Cou_ID=" + couid + "&Sou_Name=" + rs.getString(6) + ">删除</a>"); %>
                            <% out.print("<a href=ChangeShareServlet?Sou_ID=" + rs.getString(4) + "&Share=" + rs.getInt(7) + "&couid=" + couid + ">更改资源状态</a>"); %>
                        </div> 
                    </div>
                    <%     }

                        } catch (Exception e) {
                            out.println(e);
                        }
                    %>

                </div>
            </div>
        </div>
    </body>
</html>
