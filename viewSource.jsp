<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>浏览时间</title>
	<script language="javascript" type="text/javascript">
	function ConfirmClose() {
		window.event.returnValue = '';
	}
 
	function ShowConfirmClose(blnValue) {
		if(blnValue) {
			document.body.onbeforeunload = ConfirmClose;
		} else {
			document.body.onbeforeunload = null;
		}
	}
	</script>
    </head>
    <body onload="ShowConfirmClose(true);">
        <h1>Hello World!</h1>
        <%
        SimpleDateFormat df = new SimpleDateFormat("HH:mm:ss");
        Date startTime = new Date();
        String start = df.format(startTime);
        String target = "calcTime?start=" + start;
        %>
        <%=start%>
        <form action=<%=target%> method="post">
            <input type="submit" value="保存并提交进度" onclick="ShowConfirmClose(false);">
            <input type=button value="打开网页异常关闭提示" onclick="ShowConfirmClose(true);">
        </form>
    </body>
</html>
<!--https://blog.csdn.net/chs_jdmdr/article/details/7363431-->
