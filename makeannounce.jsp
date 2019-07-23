
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
            String teaid = request.getParameter("teaid");//获取传递过来的参数
            String couid = request.getParameter("couid");
            String classid = request.getParameter("classid");
        %>
        <div class="row">
            <div class="col-md-6">
                <h1>编辑要发布的通知内容：</h1>            
                <form method="post" action="makeannounce?teaid=<%=teaid%>&couid=<%=couid%>&classid=<%=classid%>">
                    <textarea  name="ann" cols="80" rows="20">Start here.</textarea>
                    <br>
                    <input type="submit" style="height:20px;width:40px" value="发布"/>
                    <br/>
                    <a href="Tea_Homepage.jsp">取消并返回</a>
                </form>
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

