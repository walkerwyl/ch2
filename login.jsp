<%@page contentType="text/html" pageEncoding="GBK"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=GBK">
        <title>Login</title>
    </head>
    <body>
    <center>
        <form action="LoginServlet" method="post">
        <table border="1">
            <tbody>
                <tr>
                    <td>ID:</td>
                    <td><input type="text" name="id" value="" /></td>
                </tr>
                <tr>
                    <td>Password:</td>
                    <td><input type="password" name="password" value="" /></td>
                </tr>
                <tr>
                    <td>Choose you identity:</td>
                    <td>
                        <input type="radio" name="identity" checked value="teacher"/>Teacher
                        <input type="radio" name="identity" value="student"/>Student
                    </td>
                </tr>
            </tbody>
        </table>
        <input type="submit" value="Submit"/>
        <input type="reset" value="Reset"/>
         </form>
    </center>
    </body>
</html>
