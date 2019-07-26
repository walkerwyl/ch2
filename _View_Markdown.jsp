<%@page import="java.sql.PreparedStatement"%>
<%@page import="myservlet.DB"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>MarkDown</title>
		<!--适配手机-->
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<link rel="shortcut icon" href="http://admin.zrstt.cn/group1/M00/00/00/rB_YCFsQ_OmAP6VFAAAQvtuENdk882.ico">
		<!--使用bootstrap的样式，比较好看-->
		<link href="http://cdn.bootcss.com/bootstrap/3.3.1/css/bootstrap.min.css" rel="stylesheet">
		<style>
			#text-input {
				margin-left: 0%;
				padding: 0px;
				height: 0px;
				width: 0%;
				border: none;
				resize: none;
			}
			
			#preview {
                                margin-left: 20%;
				padding: 15px;
				width: 60%;
				border: none;
				height: 400px;
				overflow-y:auto; 
				overflow-x:auto;
			}
			
			body {
				overflow-x: none;
			}
		</style>
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

	<body>
                <%
                    String Tea_ID = request.getParameter("teaid");
                    String Cou_ID = request.getParameter("couid");
                    String Sou_Name = request.getParameter("souname");
					String souid= request.getParameter("souid");
					String classid= request.getParameter("classid");
					
					SimpleDateFormat df = new SimpleDateFormat("HH:mm:ss");
					Date startTime = new Date();
					String start = df.format(startTime);
					String target = "calcTime?start=" + start + "&souid=" + souid +"&classid="+ classid;
					
                    String path = request.getServletContext().getRealPath("/") + "upload/"+Tea_ID+"/"+Cou_ID+"/source/"+Sou_Name;
                    
                    FileReader reader = new FileReader(path);
                    BufferedReader bufferedReader = new BufferedReader(reader);
                    StringBuffer txt = new StringBuffer();
                    String temp = null;
                    while((temp = bufferedReader.readLine()) != null) {
                        txt.append(temp);
                        txt.append("\n");
                    }
                    reader.close();
                    bufferedReader.close();
                %>
		<center>
			<h1><%=Sou_Name%></h1>
		</center>

        
        <form action=<%=target%> method="post">
        	<input type="submit" value="保存并提交进度" onclick="ShowConfirmClose(false);">
			<input type=button value="打开网页异常关闭提示" onclick="ShowConfirmClose(true);">
        </form>
		<div class="row">
                    <textarea class="bg-success" id="text-input" oninput="this.editor.update()" rows="6"><%=txt%></textarea>
                    <div id="preview" class="bg-primary" rows="6"> </div>
		</div>
		<script src="https://cdn.bootcss.com/markdown.js/0.5.0/markdown.min.js"></script>
		<script>
			function Editor(input, preview) {
				this.update = function() {
					preview.innerHTML = markdown.toHTML(input.value);
				};
				input.editor = this;
				this.update();
			}
			var $ = function(id) {
				return document.getElementById(id);
			};
			new Editor($("text-input"), $("preview"));
		</script>
	</body>

        
        
</html>

