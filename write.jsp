
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>在线编辑教学文档</title>
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
                margin-left: 10%;
                padding: 15px;
                height: 400px;
                width: 90%;
                border: none;
                resize: none;
            }
            #preview {
                margin-left: 0%;
                padding: 15px;
                width: 90%;
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
        %>
        <form method="post" action="write?teaid=<%=teaid%>&couid=<%=couid%>">  
            <div class="row">
                <div class="col-md-6"><center>
                        <h1><br>编辑教学文档<br><br></h1>
                    </center>
                    <textarea name="work"class="bg-success" id="text-input"  oninput="this.editor.update()" rows="6">Type **Markdown** here.</textarea>
                    <div id="divMessage"></div>
                    <br>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;输入标题：<input type="text" name="title">
                </div>
                <div class="col-md-6"><center><h1><br>预览效果<br><br></h1></center>
                    <div id="preview" class="bg-primary" rows="6"> </div><br>

                    </h1>&emsp;<input type="submit" class="class1" value="发布"/>
                    &emsp;<a href="teaHomepage.jsp">取消并返回主页</a>
                </div>
            </div>
        </form> 
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