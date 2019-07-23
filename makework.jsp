
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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

            #text-input {
                margin-left: 3%;
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

            body {
                overflow-x: none;
            }
        </style>
        <script>
            function showFormat(obj) {
                var model = "1970-01-01 00:00:00";
                var reg = /^\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d$/;
                var flag = false;

                while (!flag) {
                    var tempDateStr = obj.value + model.substring(obj.value.length);
                    flag = reg.test(tempDateStr);
                    divMessage.innerHTML = "<font color='red'>" + tempDateStr + "</font>";

                    obj.value = (flag && checkDate(tempDateStr)) ? obj.value : obj.value.substring(0, obj.value.length - 1);
                }
            }

            function checkDate(ds) {
                var reg = /^(\d{1,4})-(\d{1,2})-(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})$/
                var mr = reg.exec(ds);
                if (!mr)
                    return false;
                var y = parseInt(mr[1]);
                var m = parseInt(mr[2]) - 1;
                var d = parseInt(mr[3]);
                var date = new Date(ds.replace(/-/, "/"));
                return ((date.getYear() == y || date.getYear() == y - 1900) &&
                        date.getMonth() == m &&
                        date.getDate() == d &&
                        date.toString() != "NaN");
            }
        </script>
    </head>
    <body>
        <%
            String teaid = request.getParameter("teaid");//获取传递过来的参数
            String couid = request.getParameter("couid");
            String classid = request.getParameter("classid");
        %>

        <div class="row">
            <div class="col-md-6">
                <form method="post" action="makework?teaid=<%=teaid%>&couid=<%=couid%>&classid=<%=classid%>">
                    <h1>编辑要发布的作业内容：</h1>             
                    <textarea name="work"class="bg-success" id="text-input"  oninput="this.editor.update()" rows="6">Type **Markdown** here.</textarea>
                    <h1>设置作业有效时段</h1>
                    截止时间：<input name="etime" type="text" value="2019-7-19 17:06:00" onkeyup="showFormat(this)"/>
                    <div id="divMessage"></div>
            </div>
            <div class="col-md-6">
                <h1>预览效果：</h1>
                <div id="preview" class="bg-primary" rows="6"> </div><br>
                请提供一个参考答案：<input type="text" name="answer" value="" />
            </div>
            <input type="submit" style="height:20px;width:40px" value="发布"/>
            <br/>
            <a href="Tea_Homepage.jsp">取消并返回</a>
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