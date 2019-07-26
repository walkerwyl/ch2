<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="mybean.student_bean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="StudentBean" type="mybean.student_bean" scope="session"/>
<html>
	<head>
		<meta charset="UTF-8">
		<title>MarkDown</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<link rel="shortcut icon" href="http://admin.zrstt.cn/group1/M00/00/00/rB_YCFsQ_OmAP6VFAAAQvtuENdk882.ico">
		<link href="http://cdn.bootcss.com/bootstrap/3.3.1/css/bootstrap.min.css" rel="stylesheet">
		<style>
		.class1{
                border-radius:5px;
                border:2px;
                width: 40pt;
                height: 25pt;
                color:white;
                background-color: #009788;
                font-size:13px;
                padding: 10px;
                resize: none;
            	}
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
			
                        #write-text {
				margin-left: 20%;
				padding: 15px;
				height: 600px;
				width: 60%;
				border: none;
				resize: none;
			}
                        
			body {
				overflow-x: none;
			}
		</style>
	</head>

	<body style="background-color:rgba(241,241,241,.98)">
                <%
                    String Name = request.getParameter("name");
                    String Tea_ID = request.getParameter("teaid");
                    String Cou_ID = request.getParameter("couid");
                    String Class_ID = request.getParameter("classid");
		    String Stu_ID = request.getParameter("id");
                    
                    String path = request.getServletContext().getRealPath("/") + "upload/"+Tea_ID+"/"+Cou_ID+"/"+Class_ID+"/"+Name+"/work.txt";
                    String timepath = request.getServletContext().getRealPath("/") + "upload/"+Tea_ID+"/"+Cou_ID+"/"+Class_ID+"/"+Name+"/time.txt";
                    
                    FileReader timereader = new FileReader(timepath);
                    BufferedReader timebufferedReader = new BufferedReader(timereader);
                    StringBuffer time = new StringBuffer();
                    String tmp = null;
                    while((tmp = timebufferedReader.readLine()) != null) {
                        time.append(tmp);
                    }
                    timereader.close();
                    timebufferedReader.close();
                    String end = new String(time);
                    
                    SimpleDateFormat sdf = new SimpleDateFormat();
                    sdf.applyPattern("yyyy-MM-dd-HH-mm-ss");
                    Date date = new Date();
                    String now = sdf.format(date);
                    
                    String isovertime = "true";

                    try{
                        if(sdf.parse(now).getTime()<sdf.parse(end).getTime()){//转成long类型比较
                            isovertime = "false";
                        }
                    }catch(Exception e){
                        out.print(e);
                    }
                    
		    String target = "HomeworkServlet?isovertime="+isovertime+"&workname="+Name+"&teaid="+Tea_ID+"&couid="+Cou_ID+"&classid="+Class_ID;

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
                
                
		<div class="row">
                    <textarea class="bg-success" id="text-input" oninput="this.editor.update()" rows="6"><%=txt%></textarea>
                    <div id="preview" class="bg-primary" rows="6"> </div>
		</div>
                <div class="row">
                    <form action = <%=target%> method="post" >
                        <textarea name="work" class="bg-success" id="write-text" rows="6">
			</textarea>
                        <input type="submit" class="class1" value="提交">
                    </form>
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

