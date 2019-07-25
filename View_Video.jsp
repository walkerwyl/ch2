<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
	<style>
	.class1{
                	 border-radius:5px;
               	 border:2px;
             	 width: 120pt;
            	 height: 28pt;
            	 color:white;
             	 background-color: #1e9eff;
               	 font-size:13px;
               	 padding: 10px;
               	 resize: none;
            }

	</style>
        <meta http-equiv="Content-Type" content="text/html; charset=GBK">
        <title>View video</title>
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
    <body onload="ShowConfirmClose(true);" style="background-color:rgba(241,241,241,.98)">
        <div class="video">
	<%		
		String Tea_ID = request.getParameter("teaid");
                String Cou_ID = request.getParameter("couid");
                String Sou_Name = request.getParameter("souname");
                String souid= request.getParameter("souid");
                String classid= request.getParameter("classid");

                    
                String path = "upload/"+Tea_ID+"/"+Cou_ID+"/source/"+Sou_Name;

	SimpleDateFormat df = new SimpleDateFormat("HH:mm:ss");
        Date startTime = new Date();
        String start = df.format(startTime);
        String target = "calcTime?start=" + start + "&souid=" + souid +"&classid="+ classid;

        %>
	<form action=<%=target%> method="post">
        	<input type="submit" value="保存并提交进度" class="class1" onclick="ShowConfirmClose(false);">
		<input type=button value="打开网页异常关闭提示" class="class1" onclick="ShowConfirmClose(true);">
        </form>

            <video src=<%=path%> width="80%" autoplay controls="controls">
            Your browser does'n support video
            </video>
        </div>
    </body>
</html>
