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
        <title>�鿴��Դ</title>
    </head>
    <body>
        �γ�����<br><br>
        <%
            try{
                PreparedStatement ps1= DB.dbCon().prepareStatement("select * from class where Class_ID=?");
                PreparedStatement ps2= DB.dbCon().prepareStatement("select * from source where Cou_ID=? and Tea_ID=?");
                PreparedStatement ps3= DB.dbCon().prepareStatement("select * from teacher where Tea_ID=?");
                
                Iterator<info_bean> it = StudentBean.infos.iterator();
                    while (it.hasNext()) {
                        info_bean n = it.next();
                        ps1.setString(1, n.getClass_ID());
                        ResultSet rs1 = ps1.executeQuery();
                        
                        while(rs1.next()){
                            out.print("<br>�γ̣�");
                            out.print(rs1.getString(3));
                            out.print("������ʦ��");
                            
                            ps3.setString(1, rs1.getString(4));
                            ResultSet rs3 = ps3.executeQuery();
                            rs3.next();
                            out.print(rs3.getString(1));
                            
                            out.print("�����༶ID��");
                            out.print(rs1.getString(2));
                            out.print("<br>");
                            
                            ps2.setString(1, rs1.getString(1));
                            ps2.setString(2, rs1.getString(4));
                            ResultSet rs2 = ps2.executeQuery();
                            while(rs2.next()){
                                out.print("<PRE>��Դ���ƣ�");
                                out.print(rs2.getString(6));
                                out.print("�����ͣ�");
                                out.print(rs2.getInt(3));
                                out.print("����Դ�����������");
                                out.print(rs2.getInt(5));
                                if(rs2.getInt(3) == 0){
                                    out.print("<a href=View_Markdown.jsp?teaid="+rs1.getString(4)+"&couid="+rs1.getString(1)+"&souname="+rs2.getString(6)+">�鿴��Դ</a>");
                                }
                                else if(rs2.getInt(3) == 1){
                                    out.print("<a href=View_PPT.jsp?teaid="+rs1.getString(4)+"&couid="+rs1.getString(1)+"&souname="+rs2.getString(6)+">�鿴��Դ</a>");
                                }
                                else{
                                    out.print("<a href=View_Video.jsp?teaid="+rs1.getString(4)+"&couid="+rs1.getString(1)+"&souname="+rs2.getString(6)+">�鿴��Դ</a>");
                                }
                                out.print("</PRE>");
                            }
                        }
                    }
            }catch(Exception e){
                out.print(e);
            };
        %>
    </body>
</html>
