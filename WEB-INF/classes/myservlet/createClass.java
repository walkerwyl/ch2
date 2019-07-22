package myservlet;

import java.io.File;
import java.io.FileInputStream;

import java.io.IOException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Collection;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

@WebServlet(name = "createClass", urlPatterns = "/createClass")
//使用注解@MultipartConfig将一个Servlet标识为支持文件上传
@MultipartConfig//标识Servlet支持文件上传
public class createClass extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        //存储路径
        String savePath = request.getServletContext().getRealPath("/WEB-INF/classes/uploadFile");
        //获取上传的文件集合
        Collection<Part> parts = request.getParts();
        //上传单个文件

        if (parts.size() == 1) {
            //Servlet3.0将multipart/form-data的POST请求封装成Part，通过Part对上传的文件进行操作。
            Part part = request.getPart("file");//通过表单file控件(<input type="file" name="file">)的名字直接获取Part对象
            //Servlet3没有提供直接获取文件名的方法,需要从请求头中解析出来
            //获取请求头，请求头的格式：form-data; name="file"; filename="snmp4j--api.zip"

            String header = part.getHeader("content-disposition");
            //获取文件名
            String fileName = getFileName(header);
            
            //把文件写到指定路径
            part.write(savePath + File.separator + fileName);
            //读取文件分析
            File file = new File(savePath, fileName);
            writedb(file, response);
            file.delete();
            
            
           
        }
    }

    public void writedb(File file, HttpServletResponse response) throws IOException {

        ResultSet class_rs;
        ResultSet tea_rs;

        try {
            XSSFWorkbook workbook = new XSSFWorkbook(new FileInputStream(file));
            XSSFSheet sheet = workbook.getSheetAt(0);
            int rowLength = sheet.getLastRowNum();
            //连接数据库
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://112.74.58.75:3306/OLAS_DB?useUnicode=true&characterEncoding=UTF-8", "root", "41710020wys");
            Statement sql = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            //获取教师ID
            String tea_ID;
            String[] ss = sheet.getRow(3).getCell(3).getStringCellValue().split("：");
            String tea_name = ss[1];//任课教师：name
            tea_rs = sql.executeQuery("select * from teacher");
            tea_rs.next();//每个rs即取即用，否则会关闭
            while (!tea_rs.isLast()) {
                if (tea_name.equals(tea_rs.getString(1))) {
                    break;
                }
                tea_rs.next();
            }
            tea_ID = tea_rs.getString(2);
            tea_rs.close();
            //处理课程名称 
            ss = sheet.getRow(2).getCell(4).getStringCellValue().split("：");
            String cou_name = ss[1];
            //课程名称对应ID
            String cou_ID, class_ID, maxClassID;
            //获取课程和班级ID
            class_rs = sql.executeQuery("select * from class");
            while (class_rs.next()) {
                if (cou_name.equals(class_rs.getString(3))) {
                    break;
                }
            }
            cou_ID = class_rs.getString(1);
            class_rs.absolute(1);
            maxClassID = class_rs.getString(2);
            while (class_rs.next()) {
                if (Integer.valueOf(class_rs.getString(2)) >= Integer.valueOf(maxClassID)) {
                    maxClassID = class_rs.getString(2);
                }
            }
            class_ID = String.valueOf(Integer.valueOf(maxClassID) + 1);
            //插入信息
            PreparedStatement ps = con.prepareStatement("insert into class values(?,?,?,?)");
            ps.setString(1, cou_ID);
            ps.setString(2, class_ID);
            ps.setString(3, cou_name);
            ps.setString(4, tea_ID);
            ps.executeUpdate();
            //学生信息
            String stu_ID, stu_name;
            ps = con.prepareStatement("insert into info values(?,?,0,0,0,0,0,?)");
            for (int i = 5; i < rowLength ; i++) {
                XSSFCell cell = sheet.getRow(i).getCell(1);
                if (cell.getStringCellValue().length()>5) {
                    stu_ID = sheet.getRow(i).getCell(1).getStringCellValue();
                    stu_name = sheet.getRow(i).getCell(2).getStringCellValue();
                    ps.setString(1, class_ID);
                    ps.setString(2, stu_ID);
                    ps.setString(3, stu_name);
                    ps.executeUpdate();
                } else {
                    break;
                }
            }
            response.sendRedirect("Tea_Homepage.jsp?create=yes");
        } catch (Exception ex) {
           try {
                response.sendRedirect("Tea_Homepage.jsp?create=no");
            } catch (IOException ex1) {
                Logger.getLogger(createClass.class.getName()).log(Level.SEVERE, null, ex1);
            }
           
        }
    }

    public String getFileName(String header) {
        /**
         * String[] tempArr1 =
         * header.split(";");代码执行完之后，在不同的浏览器下，tempArr1数组里面的内容稍有区别
         * 火狐或者google浏览器下：tempArr1={form-data,name="file",filename="snmp4j--api.zip"}
         * IE浏览器下：tempArr1={form-data,name="file",filename="E:\snmp4j--api.zip"}
         */
        String[] tempArr1 = header.split(";");
        /**
         * 火狐或者google浏览器下：tempArr2={filename,"snmp4j--api.zip"}
         * IE浏览器下：tempArr2={filename,"E:\snmp4j--api.zip"}
         */
        String[] tempArr2 = tempArr1[2].split("=");
        //获取文件名，兼容各种浏览器的写法
        String fileName = tempArr2[1].substring(tempArr2[1].lastIndexOf("\\") + 1).replaceAll("\"", "");

        return fileName;
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        this.doGet(request, response);
    }

}
