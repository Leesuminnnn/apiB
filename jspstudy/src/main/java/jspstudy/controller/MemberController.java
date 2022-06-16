package jspstudy.controller;

import java.io.IOException;
//import java.io.PrintWriter;
import java.net.InetAddress;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jspstudy.domain.MemberVo;
import jspstudy.service.MemberDao;

@WebServlet("/MemberController")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
		//memberjoinOk.jsp 에 있던 기능들을 여기에 옮겨놓음
		//한글깨짐 방지
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String uri = request.getRequestURI();
		//System.out.println("uri:"+uri);
		String pj = request.getContextPath();
		String command = uri.substring(pj.length());
		
		System.out.println("command:"+command);
		
		if(command.equals("/member/memberJoinAction.do")) {
			
			String memberId = request.getParameter("memberId");
			String memberPwd = request.getParameter("memberPwd");
			String memberName = request.getParameter("memberName");
			String memberEmail = request.getParameter("memberEmail");
			String memberPhone = request.getParameter("memberPhone");
			String memberJumin = request.getParameter("memberJumin");
			String memberGender = request.getParameter("memberGender");
			String memberAddr = request.getParameter("memberAddr");
			String[] memberHobby = request.getParameterValues("memberHobby");

			
			String hobby="";
			for(int i = 0; i<memberHobby.length;i++){
				hobby = hobby +","+ memberHobby[i];
				
			}

			//오류 수정 
			//취미를 선택하면 쉼표가 앞에 오는 현상이 발견됨 -> substring을 사용해서 앞에 한글자를 잘랐다
			hobby = hobby.substring(1);


			//ip 구현
			String ip = InetAddress.getLocalHost().getHostAddress();


			MemberDao md = new MemberDao();

			int value = md.insertMember(memberId, memberPwd, memberName, memberGender, memberAddr, memberJumin, memberPhone, hobby, memberEmail, ip);

//			PrintWriter out = response.getWriter();
			//입력이 되었으면
			if(value == 1){
				// * location 방식을 sendRedirect 방식으로 변경
				response.sendRedirect(request.getContextPath()+"/member/memberList.do");
			//	out.println("<script>alert('회원가입이 완료되었습니다.'); location.href='"+request.getContextPath()+"'</script>");
			
			//입력이 안되어있으면	
			}else{
				response.sendRedirect(request.getContextPath()+"/member/memberjoin.do");
			//	out.println("<script>alert('회원가입에 실패하였습니다.'); location.href='./memberJoin.jsp'</script>");
				}


					//내부페이지를 감추고 .jsp가 아닌 .do로 보여준다
		}else if (command.equals("/member/memberJoin.do")) {
			
			RequestDispatcher rd = request.getRequestDispatcher("/member/memberJoin.jsp");
			rd.forward(request, response);
			
		}else if (command.equals("/member/memberList.do")) {
			
			MemberDao md = new MemberDao();
			ArrayList<MemberVo> alist =  md.memberSelectAll();
			
			request.setAttribute("alist", alist);
			
			RequestDispatcher rd = request.getRequestDispatcher("/member/memberList.jsp");
			rd.forward(request, response);
			
		}else if(command.equals("/member/memberLogin.do")) {
			System.out.println("로그인 화면으로 들어왔음");
			
			
			RequestDispatcher rd = request.getRequestDispatcher("/member/memberLogin.jsp");
			rd.forward(request, response);
			
			
			
		}else if(command.equals("/member/memberLoginAction.do")) {
			System.out.println("로그인 처리 화면으로 들어왔음");
		
			// 1. 넘어온값
			String memberId = request.getParameter("memberId");
			String memberPwd = request.getParameter("memberPwd");			
			
			// 2. 처리
			MemberDao md = new MemberDao();
			MemberVo mv = md.memberLogin(memberId, memberPwd);
			System.out.println("mv : " + mv);
			
			HttpSession session = request.getSession();
			
			
			// 3. 이동
			if(mv != null) {
				session.setAttribute("midx", mv.getMidx());
				session.setAttribute("memberId", mv.getMemberid());
				session.setAttribute("memberName", mv.getMembername());
				
				if(session.getAttribute("saveUrl") != null) {
					response.sendRedirect((String)session.getAttribute("saveUrl"));
				}else {
					response.sendRedirect(request.getContextPath()+ "/member/memberList.do");	
				}				
			}else {
				response.sendRedirect(request.getContextPath()+ "/member/memberLogin.do");	
				
			}
		
			
		
		}else if(command.equals("/member/memberLogout.do")) {
			HttpSession session = request.getSession();
			session.invalidate();
			response.sendRedirect(request.getContextPath()+"/");
			
			
		}
		
	}
	
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	
	}
	
	

	
}
