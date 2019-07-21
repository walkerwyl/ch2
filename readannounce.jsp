
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.File"%>
<%@page import="mybean.info_bean"%>
<%@page import="mybean.student_bean"%>
<%@page import="mybean.teacher_bean"%>
<%@page import="mybean.class_bean"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Scanner"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!--适配手机-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <link rel="shortcut icon" href="http://admin.zrstt.cn/group1/M00/00/00/rB_YCFsQ_OmAP6VFAAAQvtuENdk882.ico">
        <!--使用bootstrap的样式，比较好看-->
        <link href="http://cdn.bootcss.com/bootstrap/3.3.1/css/bootstrap.min.css" rel="stylesheet">
        <style>
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
    <body>
        <%
            //HttpSession ss = request.getSession(true);//获取路径
            String class_ID = request.getParameter("classid");
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://112.74.58.75:3306/OLAS_DB?useUnicode=true&characterEncoding=utf-8", "root", "41710020wys");
            PreparedStatement ps = con.prepareStatement("select * from class where Class_ID=?");
			ps.setString(1,class_ID);
            ResultSet rs = ps.executeQuery();
           
            while (rs.next()) {
				String cou_ID = rs.getString(1);
				String tea_ID = rs.getString(4);

				String path = request.getServletContext().getRealPath("/upload/" + tea_ID + "/" + cou_ID + "/" + class_ID + "/announce");
				String[] list = new File(path).list();
				if (list != null) {
					for (int i = 0; i < list.length; i++) {
						String fn = list[i];
						String[] time = fn.split("\\-|\\.");
						String t = time[0] + "-" + time[1] + "-" + time[2] + "\t" + time[3] + ":" + time[4] + ":" + time[5];
        %>
        <h2><%=t%></h2>
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
					} catch (IOException e) {
						e.printStackTrace();
					}
        %>
        <br>
        <br>
        <%
					}
				}
			}
			
        %>
        <a href="Stu_Homepage.jsp">返回主页</a>
    </body>
</html>
