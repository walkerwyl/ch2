<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View PPT</title>
    </head>
    <body>
        <%    
		String Tea_ID = request.getParameter("teaid");
                String Cou_ID = request.getParameter("couid");
                String Sou_Name = request.getParameter("souname");

        	String path = request.getServletContext().getRealPath("/") + "upload/"+Tea_ID+"/"+Cou_ID+"/source/"+Sou_Name+"pics";
            try { 
                File f = new File(path);
                if (f.isDirectory()){
                    File[] fList = f.listFiles();
                    for (int j = 0; j < fList.length; j++) {
                        File file = fList[j];
                        if (file.isFile()){
				String picpath = "upload/"+Tea_ID+"/"+Cou_ID+"/source/"+Sou_Name+"pics/pic_"+String.valueOf(j+1)+".jpg";
        %>
        <img src=<%=picpath%> width="100%">page:<%=(j+1)%>
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


