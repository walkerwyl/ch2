<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="myservlet.DB"%>
<%@page import="java.util.Iterator"%>
<%@page import="mybean.student_bean"%>
<%@page import="mybean.info_bean"%>
<%@page contentType="text/html" pageEncoding="GBK"%>
<!DOCTYPE html>
<jsp:useBean id="StudentBean" type="mybean.student_bean" scope="session"/>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=GBK">
        <title>ѧ����ҳ</title>
    </head>
    <body>
        <br><a href="ChangePassword.jsp">�޸�����>>>>>></a>
        ����:<jsp:getProperty name="StudentBean" property="name"/>
        �Ա�:<jsp:getProperty name="StudentBean" property="gender"/>
        
        <%
            PreparedStatement ps1,ps2;
            ResultSet rs1,rs2;
            ps1 = DB.dbCon().prepareStatement("select * from class where Class_ID=?");
            Iterator<info_bean> it = StudentBean.infos.iterator();	
                while (it.hasNext()) {
                    info_bean n = it.next();
                    ps1.setString(1, n.getClass_ID());
                    rs1 = ps1.executeQuery();
                    while(rs1.next()){
                    out.print("<br>�γ̣�");
                    out.print(rs1.getString(3));
                    out.print("������ʦ��");
                    
                    ps2= DB.dbCon().prepareStatement("select * from teacher where Tea_ID=?");
                    ps2.setString(1,rs1.getString(4));
                    rs2 = ps2.executeQuery();
                        while(rs2.next()){
                            out.print(rs2.getString(1));
                    
                            out.print("�����༶ID��");
                            out.print(rs1.getString(2));
                            out.print("<br>ѧϰ���:   ѧϰʱ�䣺");
                            out.print(n.getMy_Time());
                            out.print("     ѧϰ������");
                            out.print(n.getMy_Count());
                            out.print("<PRE>��ҵ1��  �ɼ���");
                            out.print(n.getWork1());
                            out.print("  <a href=Do_Homework.jsp?name=work1&teaid="+rs1.getString(4)+"&couid="+rs1.getString(1)+"&classid="+n.getClass_ID()+">д��ҵ</a>");
                            out.print("<br>��ҵ2��  �ɼ���");
                            out.print(n.getWork2());
                            out.print("  <a href=Do_Homework.jsp?name=work2&teaid="+rs1.getString(4)+"&couid="+rs1.getString(1)+"&classid="+n.getClass_ID()+">д��ҵ</a>");
                            out.print("<br>��ҵ3��  �ɼ���");
                            out.print(n.getWork3());
                            out.print("  <a href=Do_Homework.jsp?name=work3&teaid="+rs1.getString(4)+"&couid="+rs1.getString(1)+"&classid="+n.getClass_ID()+">д��ҵ</a>");
                            out.print("<br><a href=View_Markdown.jsp>�鿴֪ͨ</a>");
                            out.print("</PRE>");
                        }
                    }
                }
            out.print("<a href=View_Sources.jsp>�鿴��ѧ��Դ</a>"); 
        %>
    </body>
</html>