package myservlet;

import myservlet.DB;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import mybean.teacher_bean;

@WebServlet(name="UploadServlet",urlPatterns="/UploadServlet")
@MultipartConfig
public class UploadServlet extends HttpServlet {
        @Override
        public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            HttpSession session = request.getSession();
            teacher_bean teacher = (teacher_bean)session.getAttribute("TeacherBean");
            String Tea_ID = teacher.getTea_ID();
            String Cou_ID = (String)session.getAttribute("cou_id"); 
			String fileName = "";
            
            request.setCharacterEncoding("utf-8");
            response.setCharacterEncoding("utf-8");
            response.setContentType("text/html;charset=utf-8");
            //存储路径
//            String savePath = "/tmp/uploadFile/" + Tea_ID + "/" + Cou_ID;
            String savePath =  request.getServletContext().getRealPath( "/upload/" + Tea_ID + File.separator + Cou_ID + File.separator + "source" );

		File f = new File(savePath);
		if(!f.exists()){
			f.mkdirs();
		}

//            String savePath = "/tmp/uploadFile";
			session.removeAttribute("cou_id");
            //获取上传的文件集合
            Collection<Part> parts = request.getParts();
            //上传单个文件
            if (parts.size()==1) {
                //Servlet3.0将multipart/form-data的POST请求封装成Part，通过Part对上传的文件进行操作。
//                Part part = parts[0];//从上传的文件集合中获取Part对象
                Part part = request.getPart("file");//通过表单file控件(<input type="file" name="file">)的名字直接获取Part对象
                //Servlet3没有提供直接获取文件名的方法,需要从请求头中解析出来
                //获取请求头，请求头的格式：form-data; name="file"; filename="snmp4j--api.zip"
                String header = part.getHeader("content-disposition");
                //获取文件名
                fileName = getFileName(header);
                //把文件写到指定路径
                part.write(savePath+File.separator+fileName);

		String[] tmp = fileName.split("\\.");
		int newType = 3;
		if(tmp[1] == "txt")		newType = 0;
		else if(tmp[1] == "mp4")	newType = 2;
		else				newType = 1;	

		try{
			PreparedStatement ps = DB.dbCon().prepareStatement("SELECT * FROM source");
			ResultSet rs = ps.executeQuery();

			int maxSou_ID= 1;
			while(rs.next()){
				int tmpSou_ID = Integer.parseInt( rs.getString(4) );
				if(tmpSou_ID > maxSou_ID){
					maxSou_ID = tmpSou_ID;
				}
			}	
			maxSou_ID = maxSou_ID + 1;

			ps = DB.dbCon().prepareStatement("INSERT INTO source VALUES(?,?,?,?,?,?,?)");
			ps.setString(1, Tea_ID);	
			ps.setString(2, Cou_ID);	
			//ps.setInt(3, newType );
			ps.setInt(3, 0);
			ps.setString(4, Integer.toString( maxSou_ID ) );
			ps.setInt(5, newType);	
			ps.setString(6, fileName);	
			ps.setInt(7, 0);	
			ps.executeUpdate();
			
		}
		catch(Exception e){}
		
		boolean isppt = false;
        String suffixname = null;
        if (fileName != null && fileName.indexOf(".") != -1) {
            suffixname = fileName.substring(fileName.indexOf("."));
            if (suffixname.equals(".ppt")) {
                isppt = true;
            }
        } else {
            isppt = false;
        }
		
		f = new File( savePath + File.separator + fileName );
		try {
            FileInputStream in = new FileInputStream(f);
            SlideShow ppt = new SlideShow(in);
            in.close();
            Dimension pgsize = ppt.getPageSize();
            org.apache.poi.hslf.model.Slide[] slide = ppt.getSlides();
			
            for (int i = 0; i < slide.length; i++) {
                System.out.print("第" + i + "页。");

                TextRun[] truns = slide[i].getTextRuns();
                for ( int k=0;k<truns.length;k++){
                   RichTextRun[] rtruns = truns[k].getRichTextRuns();
                  for(int l=0;l<rtruns.length;l++){
                        int index = rtruns[l].getFontIndex();
                        String name = rtruns[l].getFontName();
                        rtruns[l].setFontIndex(1);
                        rtruns[l].setFontName("宋体");
//                        System.out.println(rtruns[l].getText());
                   }
                }
                BufferedImage img = new BufferedImage(pgsize.width,pgsize.height, BufferedImage.TYPE_INT_RGB);

                Graphics2D graphics = img.createGraphics();
                graphics.setPaint(Color.BLUE);
                graphics.fill(new Rectangle2D.Float(0, 0, pgsize.width, pgsize.height));
                slide[i].draw(graphics);

                // 这里设置图片的存放路径和图片的格式(jpeg,png,bmp等等),注意生成文件路径
                FileOutputStream out = new FileOutputStream(savePath + File.separator + "ppts/pics/pic_"+ (i + 1) + ".jpg");
                javax.imageio.ImageIO.write(img, "jpg", out);
                out.close();

            }
            //System.out.println("success!!");
            //return true;
        } catch (FileNotFoundException e) {
            //System.out.println(e);
            // System.out.println("Can't find the image!");
        } catch (IOException e) {
        }
		
		


            }else {
                //一次性上传多个文件
                for (Part part : parts) {//循环处理上传的文件
                    //获取请求头，请求头的格式：form-data; name="file"; filename="snmp4j--api.zip"
                    String header = part.getHeader("content-disposition");
                    //获取文件名
                    fileName = getFileName(header);
                    //把文件写到指定路径
                    part.write(savePath+File.separator+fileName);
                }
            }
            PrintWriter out = response.getWriter();
            out.println("上传成功");
            out.println(fileName);
            out.flush();
            out.close();
    }
        public String getFileName(String header) {
        /**
         * String[] tempArr1 = header.split(";");代码执行完之后，在不同的浏览器下，tempArr1数组里面的内容稍有区别
         * 火狐或者google浏览器下：tempArr1={form-data,name="file",filename="snmp4j--api.zip"}
         * IE浏览器下：tempArr1={form-data,name="file",filename="E:\snmp4j--api.zip"}
         */
        String[] tempArr1 = header.split(";");
        /**
         *火狐或者google浏览器下：tempArr2={filename,"snmp4j--api.zip"}
         *IE浏览器下：tempArr2={filename,"E:\snmp4j--api.zip"}
         */
        String[] tempArr2 = tempArr1[2].split("=");
        //获取文件名，兼容各种浏览器的写法
        String fileName = tempArr2[1].substring(tempArr2[1].lastIndexOf("\\")+1).replaceAll("\"", "");
        return fileName;
    }
        
    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
        public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            this.doGet(request, response);
    }
        
}
