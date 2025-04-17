package controller.productRegister;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ImageView
 */
@WebServlet("/imageView")
public class ImageView extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ImageView() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String filename = request.getParameter("filename");
		String path = request.getServletContext().getRealPath("upload");
		
		try {
			InputStream is = new FileInputStream(new File(path,filename));
			OutputStream out = response.getOutputStream();
			
			byte[] buff = new byte[4096];
			int len;
			while((len=is.read(buff))>0) {
				out.write(buff,0,len);
			}
			is.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}


}
