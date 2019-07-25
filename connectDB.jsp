<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!Now let's connect!</h1>
        <%
            Connection con;
            Statement sql;
            ResultSet rs;
            try{
                Class.forName("com.mysql.jdbc.Driver");
            }
            catch(Exception e){
                out.println("忘记把MySQL数据库的JDBC数据库驱动程序复制到JDK的扩展目录中");
            }
            try{
                String uri = "jdbc:mysql://localhost/OLAS_DB";
                String user = "root";
                String password = "41710020wys";
                con = DriverManager.getConnection(uri, user, password);
                sql = con.createStatement();
                

                
                rs = sql.executeQuery("SELECT * FROM student ");
                if(rs.next()){
                    out.print(rs.getString(1));
                }
                out.print("我连上了！");
            }
            catch(SQLException e){
                out.println(e);
            }
        %>
    </body>
</html>
