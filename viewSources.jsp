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
        <title>查看资源</title>
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
        <div class="header layui-bg-green">
            <div class="header-wrap">
                <h3 class="logo pull-left">
                    <a href="stuHomepage.jsp"><img src="https://www.layui.com/template/xianyan/demo/res/static/images/logo.png" alt="" class="logo-img"></a>
                    <font face="楷体" color="white">welcome!<jsp:getProperty name="StudentBean" property="name"/></font>
                </h3>
            </div>
        </div>                   
        <br><br><br><br><br>
        <div class="container - wrap">
            <div class="container">
                <div class="contar-wrap">
                    <%
                        try {
                            String stuid = StudentBean.getStu_ID();
                            PreparedStatement ps1 = DB.dbCon().prepareStatement("select * from info where Stu_ID=?");
                            PreparedStatement ps2 = DB.dbCon().prepareStatement("select * from class where Class_ID=?");
                            PreparedStatement ps3 = DB.dbCon().prepareStatement("select * from teacher where Tea_ID=?");
                            PreparedStatement ps4 = DB.dbCon().prepareStatement("select * from source where Tea_ID=? and Cou_ID=?");
                            ResultSet rs1, rs2, rs3, rs4;
                            String path = request.getServletContext().getRealPath("/");

                            ps1.setString(1, stuid);
                            rs1 = ps1.executeQuery();
                            while (rs1.next()) {
                                ps2.setString(1, rs1.getString(1));
                                rs2 = ps2.executeQuery();
                                while (rs2.next()) {
                                    out.print("<h3>");
                                    out.print("课程：");
                                    out.print(rs2.getString(3));
                                    ps3.setString(1, rs2.getString(4));
                                    rs3 = ps3.executeQuery();
                                    out.print("<div style='float:right'>老师：");
                                    while (rs3.next()) {
                                        out.print(rs3.getString(1));
                                    }
                                    out.print("&emsp;&emsp;&emsp;&emsp;&emsp;" + "班级：" + rs1.getString(1) + "&emsp;" + "</h3></div><br>");
                                    ps4.setString(1, rs2.getString(4));
                                    ps4.setString(2, rs2.getString(1));
                                    rs4 = ps4.executeQuery();
                                    while (rs4.next()) {
                                        out.print("<div class='item'>");
                                        out.print("<div class='item-box  layer-photos-demo1 layer-photos-demo'>");
                                        if (rs4.getInt(3) == 0) {
                                            out.print("<img src='pic/txt.png'width='35' height='35'/>&emsp;");
                                        } else if (rs4.getInt(3) == 1) {
                                            out.print("<img src='pic/ppt.png'width='35' height='35'/>&emsp;");
                                        } else {
                                            out.print("<img src='pic/mp4.png'width='35' height='35'/>&emsp;");
                                        }
                                        out.print(rs4.getString(6) + "<div style='float:right'>" + "资源总浏览次数：" + rs4.getInt(5) + "&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;");
                                        if (rs4.getInt(3) == 0) {
                                            out.print("<a href=viewMarkdown.jsp?teaid=" + rs2.getString(4) + "&couid=" + rs2.getString(1) + "&souname=" + rs4.getString(6) + "&souid=" + rs4.getString(4) + "&classid=" + rs1.getString(1) + "><img src='pic/eye.png'width='35' height='35'/></a></div><br>");
                                        } else if (rs4.getInt(3) == 1) {
                                            out.print("<a href=viewPPT.jsp?teaid=" + rs2.getString(4) + "&couid=" + rs2.getString(1) + "&souname=" + rs4.getString(6) + "&souid=" + rs4.getString(4) + "&classid=" + rs1.getString(1) + "><img src='pic/eye.png'width='35' height='35'/></a></div><br>");
                                        } else {
                                            out.print("<a href=viewVideo.jsp?teaid=" + rs2.getString(4) + "&couid=" + rs2.getString(1) + "&souname=" + rs4.getString(6) + "&souid=" + rs4.getString(4) + "&classid=" + rs1.getString(1) + "><img src='pic/eye.png'width='35' height='35'/></a></div><br>");
                                        }
                                        out.print("</div></div>");
                                    }                              
                                }
                            }
                            out.print("</div>");
                        } catch (Exception e) {
                            out.print(e);
                        };
                    %>
                </div>
            </div>
        </div>
    </body>
</html>
