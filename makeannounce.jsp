
<%@page import="java.io.IOException"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
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
                width: 97%;
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
                background-color: #483f56;
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
        <div class="header layui-bg-cyan">
            <div class="header-wrap">
                <h3 class="logo pull-left">
                    <a href="teaHomepage.jsp"><img src="https://www.layui.com/template/xianyan/demo/res/static/images/logo.png" alt="" class="logo-img"></a>
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
                    <h1>已发布的通知：</h1><br>
                    <%
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://112.74.58.75:3306/OLAS_DB?useUnicode=true&characterEncoding=utf-8", "root", "41710020wys");
                        PreparedStatement ps = con.prepareStatement("select * from class where Class_ID=?");
                        ps.setString(1, classid);
                        ResultSet rs = ps.executeQuery();

                        while (rs.next()) {
                            String cou_ID = rs.getString(1);
                            String tea_ID = rs.getString(4);
                            String couName = rs.getString(3);

                            String path = request.getServletContext().getRealPath("/upload/" + tea_ID + "/" + cou_ID + "/" + classid + "/announce");
                            String[] list = new File(path).list();
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
                    <div style="float:right">
                        <a href="delete?teaid=<%=teaid%>&couid=<%=couid%>&filename=<%=fn%>&classid=<%=classid%>"><img src='pic/del.png'width='30' height='30'></a>
                    </div><br>
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
                                }
                            }
                        }
                    %>
                </div>
            </div>
        </div>
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

