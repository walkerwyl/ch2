
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="mybean.teacher_bean"%>
<!DOCTYPE html>
<jsp:useBean id="TeacherBean" type="mybean.teacher_bean" scope="session"/>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>发布作业</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://www.layui.com/template/xianyan/demo/res/layui/css/layui.css">
        <link rel="stylesheet" href="https://www.layui.com/template/xianyan/demo/res/static/css/mian.css">
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
                border:0px;
                width: 30pt;
                height: 18pt;
                color:white;
                background-color: #1e9eff;
                font-size:15px;
            }
            #text-input {
                margin-right: 50%;
                padding: 15px;
                height: 400px;
                width: 70%;
                border: none;
                resize: none;
            }

            #preview {
                margin-left: 3%;
                padding: 15px;
                width: 70%;
                border: none;
                height: 400px;
                overflow-y:auto; 
                overflow-x:auto;
            }
            .footer{
                height: 20px;
                background-color: #ddd;
                position: fixed;
                bottom: 0;
            }
            body {
                overflow-x: none;
            }
        </style>
    </head>
    <body class="lay-blog">
        <div class="header">
            <div class="header-wrap">
                <h3 class="logo pull-left">
                    <a href="Tea_Homepage2.jsp"><img src="https://www.layui.com/template/xianyan/demo/res/static/images/logo.png" alt="" class="logo-img"></a>
                    <font face="楷体" color="white">welcome!<jsp:getProperty name="TeacherBean" property="name"/></font>
                </h3>
            </div>
        </div>
        <br><br><br><br>
        <%
            String teaid = request.getParameter("teaid");//获取传递过来的参数
            String couid = request.getParameter("couid");
            String classid = request.getParameter("classid");
        %>
        <div class="row">
            <form method="post" action="makework?teaid=<%=teaid%>&couid=<%=couid%>&classid=<%=classid%>">
                <h1>编辑要发布的作业内容：</h1>             
                <textarea name="work"class="bg-success" id="text-input"  oninput="this.editor.update()" clo="" rows="6">Type **Markdown** here.</textarea>
                <h1>设置作业有效时段</h1>
                截止时间：<input name="etime" type="text" id="test" placeholder="yyyy-MM-dd HH:mm:ss">
                <div id="divMessage"></div>
                <h1>预览效果：</h1>
                <div id="preview" class="bg-primary" rows="6"> </div><br>
                请提供一个参考答案：<input type="text" name="answer" value="" />
                <input type="submit" class="class1" value="发布"/>
            </form>  
        </div>  
        <script src="laydate/laydate.js"></script>
        <script>
            laydate.render({
                elem: '#test'
                , type: 'datetime'
            });
        </script>
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