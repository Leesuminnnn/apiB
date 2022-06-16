package single.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/FrontController2")
public class FrontController2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String uri = request.getRequestURI();
		String pj = request.getContextPath();
		String command = uri.substring(pj.length());
		
		System.out.println("uri:"+uri);
		
		String[] subpath = command.split("/");
		String location = subpath[1];
		
		if(location.equals("member2")) {
			MemberController2 mc = new MemberController2();
			mc.doGet(request, response);
			
		}else if(location.equals("board2")) {
			BoardController2 bc = new BoardController2();
			bc.doGet(request, response);
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
