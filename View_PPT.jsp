<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<!DOCTYPE html>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View PPT</title>
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
    <body style="background-color:rgba(241,241,241,.98)">
        <%    
			String Tea_ID = request.getParameter("teaid");
            String Cou_ID = request.getParameter("couid");
            String Sou_Name = request.getParameter("souname");
			String[] tmp = Sou_Name.split("\\.");	
			String souid= request.getParameter("souid");
            String classid= request.getParameter("classid");	

			SimpleDateFormat df = new SimpleDateFormat("HH:mm:ss");
			Date startTime = new Date();
			String start = df.format(startTime);
			String target = "calcTime?start=" + start + "&souid=" + souid +"&classid="+ classid;			

        	String path = request.getServletContext().getRealPath("/") + "upload/"+Tea_ID+"/"+Cou_ID+"/source/"+tmp[0]+"pics";
            try { 
                File f = new File(path);
                if (f.isDirectory()){
                    File[] fList = f.listFiles();
                    for (int j = 0; j < fList.length; j++) {
                        File file = fList[j];
                        if (file.isFile()){
				String picpath = "upload/"+Tea_ID+"/"+Cou_ID+"/source/"+tmp[0]+"pics/pic_"+String.valueOf(j+1)+".jpg";
        %>
		        <br>page:<%=(j+1)%><br><img src=<%=picpath%> width="70%" ><form action=<%=target%> method="post">
        			<input type="submit" value="保存并提交进度" class="class1" onclick="ShowConfirmClose(false);">
				<input type=button value="打开网页异常关闭提示" class="class1" onclick="ShowConfirmClose(true);">
           	 	</form>

        <%
                        }
                    }
                }
            } catch (Exception e){
                    System.out.print(e);
            }
        %>
    </body>
</html>


