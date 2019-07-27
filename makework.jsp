
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>发布作业</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <link rel="shortcut icon" href="http://admin.zrstt.cn/group1/M00/00/00/rB_YCFsQ_OmAP6VFAAAQvtuENdk882.ico">
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
            .class1{
                border-radius:5px;
                border:2px;
                width: 40pt;
                height: 25pt;
                color:white;
                background-color: #483f56;
                font-size:13px;
                padding: 10px;
                resize: none;
            }
            #text-input {
                margin-left: 30%;
                padding: 15px;
                height: 400px;
                width: 70%;
                border: none;
                resize: none;
            }
            #preview {
                margin-left: 0%;
                padding: 15px;
                width: 70%;
                border: none;
                height: 400px;
                overflow-y:auto; 
                overflow-x:auto;
            }

            body {
                overflow-x: none;
            }
        </style>
    </head>
    <body style="background-color:rgba(241,241,241,.98)">
        <%
            String teaid = request.getParameter("teaid");//获取传递过来的参数
            String couid = request.getParameter("couid");
            String classid = request.getParameter("classid");

            SimpleDateFormat sdf2 = new SimpleDateFormat();//系统当前时间
            sdf2.applyPattern("yyyy-MM-dd HH:mm:ss");
            Date date = new Date();
            Calendar c = Calendar.getInstance();
            c.setTime(date);
            c.add(Calendar.DAY_OF_MONTH, 1);
            Date tom = c.getTime();
            String now = sdf2.format(tom);
        %>
        <div class="row">
            <form method="post" action="makework?teaid=<%=teaid%>&couid=<%=couid%>&classid=<%=classid%>">   
                <div class="col-md-6"><center>
                        <h1><br>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;编辑作业<br><br></h1>
                    </center>  
                    <textarea name="work"class="bg-success" id="text-input"  oninput="this.editor.update()" rows="6">Type **Markdown** here.</textarea><br>
                    <h1>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;设置作业有效时段:</h1>
                    &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;截止时间：<input name="etime" type="text" id="test" value="<%=now%>">
                    <h1>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;已发布的作业：
                        <%
                            String path = request.getServletContext().getRealPath("/upload/" + teaid + "/" + couid + "/" + classid);
                            String mm = "work1";//从work1开始判断，如果不为空就到下一个文件夹
                            File backfile = new File(path + "/" + mm);
                            if (backfile != null && backfile.exists() && backfile.isDirectory()) {
                                File[] files = backfile.listFiles();
                                if (files != null && files.length > 0) {

                        %>
                        work1:
                        <%                                    try {
                                        FileReader reader = new FileReader(path + "/work1/answer.txt");
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
                                    mm = "work2";
                                }
                            }
                            backfile = new File(path + "/" + mm);
                            if (backfile != null && backfile.exists() && backfile.isDirectory()) {
                                File[] files = backfile.listFiles();
                                if (files != null && files.length > 0) {
                        %>
                    &emsp;&emsp;work2:
                    <%
                                try {
                                    FileReader reader = new FileReader(path + "/work2/answer.txt");
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
                                mm = "work3";
                            }
                        }
                        backfile = new File(path + "/" + mm);
                        if (backfile != null && backfile.exists() && backfile.isDirectory()) {
                            File[] files = backfile.listFiles();
                            if (files != null && files.length > 0) {
                    %>
                    &emsp;&emsp;work3
                    <%
                                try {
                                    FileReader reader = new FileReader(path + "/work3/answer.txt");
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
                            }
                        }
                    %>
                    </h1>
                    <div id="divMessage"></div>
                </div>
                <div class="col-md-6"><h1><br>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;预览效果<br><br></h1>
                    <div id="preview" class="bg-primary" rows="6"> </div><br>
                    &emsp;请输入作业标题：<input type="text" name="answer"><br><br>
                    </h1>&emsp;<input type="submit" class="class1" value="发布"/>
                    &emsp;<a href="teaHomepage.jsp">返回主页</a>
                </div>
            </form>      
        </div>

        <script src="https://cdn.bootcss.com/markdown.js/0.5.0/markdown.min.js"></script>
        <script>
            function Editor(input, preview) {
                this.update = function () {
                    preview.innerHTML = markdown.toHTML(input.value);
                };
                input.editor = this;
                this.update();
            }
            var $ = function (id) {
                return document.getElementById(id);
            };
            new Editor($("text-input"), $("preview"));
        </script>
        <script src="laydate/laydate.js"></script> 
        <script>
            laydate.render({
                elem: '#test'
                , type: 'datetime'
            });
        </script>
    </body>
</html>
<script>
//取出传回来的参数error并与yes比较
    var error1 = '<%=request.getParameter("m")%>';
    if (error1 === 'no') {
        alert("发布失败!");
    }
    if (error1 === 'yes') {
        confirm("发布成功！");
    }
</script>