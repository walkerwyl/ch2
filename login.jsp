<%@page contentType="text/html" pageEncoding="GBK"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=GBK">
        <title>Login</title>
        <style>
            .header {
                position: absolute;
                top: 100px;
                right:200px;
                background-color: transparent;
                padding: 20px;
                text-align: center;

            }
            #tab {
                position: absolute;
                top: 200px;
                right:200px;
                width:350px;
                opacity: 0.7;
            }
        </style>
    </head>

    <body style="background-size:100% 100% ; background-attachment: fixed" background="pic/bg1.jpg">

    <center>
        <div class="header">

            <font size="10" face="����">��ӭ��½</font><font size="10" face="Times New Roman">OLAS</font>
        </div>
        <form   action="LoginServlet" method="post" >
            <table id="tab"  style="border:3px solid #a9c9e2;background:#eff7ff" cellpadding="3" >
                <tbody>
                    <tr>  
                        <th><font size="4" color="black" >ID:</font></th>

                        <td><input type="text" name="id" value="" style="font-size:16px"/></td>
                    </tr>
                    <tr>
                        <th><font size="4" color="black" >Password:</font></th>

                        <td><input type="password" name="password" value="" style="font-size:16px"/></td>
                    </tr>
                    <tr>
                        <th><font size="4" color="black" >ѡ���������</font></th>
                        <td>
                            <input type="radio" name="identity" checked value="teacher"/><font size="3" color="black" >��ʦ</font>
                            <input type="radio" name="identity" value="student"/><font size="3" color="black" >ѧ��</font>
                        </td>
                    </tr>
                    <tr>
                        <th>  </th>
                        <td>
                            <input type="submit"  style="width:60px;height:30px;vertical-align:middle;margin:8px;line-height:18px;font-size:18px;" value="��¼"/>
                            <input type="reset"  style="width:60px;height:30px;vertical-align:middle;margin:8px;line-height:18px;font-size:18px;" value="���"/>
                        </td>
                    </tr>
                    <tr>
                        <th>  </th>
                        <td>
                            <a href="Register.jsp"><font size="3" color="black" >���û�������ע��</font></a>
                        </td>
                    </tr>
                </tbody>
            </table>

        </form>

    </center>
</body>
</html>
