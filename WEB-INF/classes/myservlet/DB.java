package myservlet;

import java.sql.Connection;
import java.sql.DriverManager;

public class DB {
    public static Connection dbCon(){
        Connection con = null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://112.74.58.75:3306/OLAS_DB?characterEncoding=gb2312", "root","41710020wys");
        }
        catch(Exception e){
//            System.out.printf("err");
        };
        return con;
    }
}
