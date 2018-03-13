package bg.softuni.servlet.admin;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;


@WebServlet("/admin")
public class AdminAddress extends HttpServlet{

	private static final String ADMIN_ADDRESS = "0x565D9C0097EfCEafADb628e2908cC32245AaD3Dd";
	
	@Override
	public void init() {

	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException  {
		res.setContentType("text/html");
		  PrintWriter out = res.getWriter();
		  out.append(ADMIN_ADDRESS);
		  out.close();
	}
}