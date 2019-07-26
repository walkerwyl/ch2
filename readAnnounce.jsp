
<%@page import="java.util.Arrays"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Scanner"%>
<%@page import="mybean.student_bean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="StudentBean" type="mybean.student_bean" scope="session"/>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ReadAnnounce Page</title>
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
            h1 {
                font-family: Consolas, monaco, monospace;
                font-size: 20px;
                font-style: normal;
                font-variant: normal;
                font-weight: 500;
                line-height: 23px;
            }

            body {
                overflow-x: none;
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
        <div class="container - wrap">
            <div class="container">
                <div class="contar-wrap">
                    <br><br><br><br><br>
                    <%
                        String class_ID = request.getParameter("classid");//获取路径
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://112.74.58.75:3306/OLAS_DB?useUnicode=true&characterEncoding=utf-8", "root", "41710020wys");
                        PreparedStatement ps = con.prepareStatement("select * from class where Class_ID=?");
                        ps.setString(1, class_ID);
                        ResultSet rs = ps.executeQuery();

                        while (rs.next()) {
                            String cou_ID = rs.getString(1);
                            String tea_ID = rs.getString(4);
                            String couName = rs.getString(3);

                            String path = request.getServletContext().getRealPath("/upload/" + tea_ID + "/" + cou_ID + "/" + class_ID + "/announce");
                            String[] list = new File(path).list();
                    %>
                    课程名称：<%=couName%>    
                    <br><br>
                    <%
                        if (list != null) {
                            Date[] dates = new Date[list.length];//按时间排序
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
                            sdf.setLenient(true);
                            int i = 0;
                            try {
                                for (i = 0; i < list.length; i++) {
                                    dates[i] = sdf.parse(list[i]);
                                }
                                Arrays.sort(dates);
                                for (i = 0; i < dates.length; i++) {
                                    list[i] = sdf.format(dates[i]) + ".txt";
                                }
                            } catch (Exception e) {
                            }
                            for (i = list.length - 1; i >= 0; i--) {
                                out.print("<div class='item'>");
                                out.print("<div class='item-box  layer-photos-demo1 layer-photos-demo'>");
                                String fn = list[i];
                                String[] time = fn.split("\\-|\\.");
                                String t = time[0] + "年" + time[1] + "月" + time[2] + "日\t" + time[3] + ":" + time[4] + ":" + time[5];
                    %>
                    <h1><%=t%></h1>
                    <br>
                    <%
                        try {
                            FileReader reader = new FileReader(path + "/" + fn);
                            BufferedReader bufferedReader = new BufferedReader(reader);
                            StringBuffer txt = new StringBuffer();
                            String temp = null;
                            while ((temp = bufferedReader.readLine()) != null) {
                                txt.append(temp);
                                txt.append("<br>");
                            }
                            out.print(txt);
                            reader.close();
                            bufferedReader.close();
                            out.print("</h1></div></div>");
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    %>
                    <br>
                    <%
                                }
                            }
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
