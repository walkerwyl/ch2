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
            //            D:\Study\DAYIXIA\Java\homework\Login\build\web\
            String path = request.getServletContext().getRealPath("/") + "ppts/pics";
//            out.println(request.getServletContext().getRealPath("/"));
            String name = "";
            try { 
                File f = new File(path);
                if (f.isDirectory()){
                    File[] fList = f.listFiles();
                    for (int j = 0; j < fList.length; j++) {
                        File file = fList[j];
                        if (file.isFile()){
        %>
        <img src="ppts/pics/pic_<%=(j+1)%>.jpg" width="100%">page:<%=(j+1)%>
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


