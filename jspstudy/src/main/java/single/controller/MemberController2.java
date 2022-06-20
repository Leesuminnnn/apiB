package single.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import single.domain.MemberVo;
import single.service.MemberDao;



@WebServlet("/MemberController2")
public class MemberController2 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		String uri = request.getRequestURI();
		String pj = request.getContextPath();
		String command = uri.substring(pj.length());

		System.out.println("uri:" + uri);

		System.out.println("command: " + command);
		
		//회원가입 페이지
		
		if (command.equals("/member2/memberJoinAction.do2")) {
			System.out.println("회원가입 처리 페이지");
			String memberId = request.getParameter("memberId");
			String memberPwd = request.getParameter("memberPwd");
			String memberName = request.getParameter("memberName");
			String memberEmail = request.getParameter("memberEmail");
			String memberGender = request.getParameter("memberGender");
			String memberAddr = request.getParameter("memberAddr");
			String memberPhone = request.getParameter("memberPhone");

			String ip = InetAddress.getLocalHost().getHostAddress();

			MemberDao md = new MemberDao();
			int value = md.insertMember(memberId, memberPwd, memberName, memberEmail, memberGender, memberAddr,
					memberPhone, ip);
			
			System.out.println(value);
			
			if (value == 1) {
				response.sendRedirect(request.getContextPath() + "/member2/Login.do2");
				

			} else {
				response.sendRedirect(request.getContextPath() + "/member2/memberJoin.do2");
				 
			}

		} else if (command.equals("/member2/memberJoin.do2")) {

			System.out.println("회원가입 페이지에 들어왔음");
			System.out.println(request.getContextPath());

			RequestDispatcher rd = request.getRequestDispatcher("/member2/memberJoin.jsp");
			rd.forward(request, response);

			
			//로그인페이지
		}else if(command.equals("/member2/checkId.do2")) {
			
			String memberId = request.getParameter("memberId");
			
			int idCheck = new MemberDao().registerCheck(memberId);
			
			request.setAttribute("idCheck", idCheck);
			
			RequestDispatcher rd = request.getRequestDispatcher("/member2/checkId.jsp");
			rd.forward(request, response);
			
		}
		
		else if (command.equals("/member2/LoginAction.do2")) {
			System.out.println("로그인페이지 처리 화면에 들어왔음");
			//1. 넘어온 값을 받는다
			String memberId = request.getParameter("memberId");
			String memberPwd = request.getParameter("memberPwd");
			
//			String checkbox = request.getParameter("checkbox");
//			
//			
//			//-- 쿠키를 이용하여 id저장하기 구현 해보기
//			Cookie cookie = new Cookie("memberId", memberId);// 일단 쿠키 생성
			
		
			
//			if (checkbox != null) { // 체크박스 체크여부에 따라 쿠키 저장 확인
//				// 체크박스 체크 되었을 때
//				// 쿠키 저장
//				response.addCookie(cookie);
//			} else {
//				// 체크박스 체크 해제되었을 때
//				// 쿠키 유효시간 0으로 해서 브라우저에서 삭제하게 한다.
//				cookie.setMaxAge(0);
//				response.addCookie(cookie);
//			}
//			// id , pwd 에 null 체크 반드시 하기
//			if ((memberId != null) && (memberPwd != null)) {
//				if (memberId.equals("asdf") && memberPwd.equals("1234")) { // 로그인 성공시
//					// id 와 pwd가 일치하는 경우 index.jsp로 이동 경로설정 주의!! context 값 / 으로해놓았다.
//					response.sendRedirect("/mainindex.jsp");
//				} else { // 로그인 실패시
//					// 로그인 실패시 바로 login 화면으로 돌아가게하기
//					response.sendRedirect("/member2/Login.do2");
//				}
//			}
			
			//--
			
			
			//2.처리
			MemberDao md = new MemberDao();
			MemberVo mv = md.Login(memberId, memberPwd);

			HttpSession session = request.getSession();

			//3.이동
			if (mv != null) {
				session.setAttribute("midx", mv.getMidx());
				session.setAttribute("memberId", mv.getMemberid());
				session.setAttribute("memberName", mv.getMembername());
				session.setAttribute("memberPhone", mv.getMemberphone());
				session.setAttribute("imadmin", mv.getImadmin());
				
				System.out.println("midx:"+mv.getMidx());
				System.out.println("memberId: "+mv.getMemberid());
				System.out.println("memberName: "+mv.getMembername());
				System.out.println("memberPhone: "+mv.getMemberphone());
				System.out.println("imadmin: "+mv.getImadmin());
				if (session.getAttribute("saveUrl") != null) {
					response.sendRedirect((String) session.getAttribute("saveUrl"));
				} else {
					response.sendRedirect(request.getContextPath() + "/board2/index2.do2");
				}

			} else {
				response.sendRedirect(request.getContextPath() + "/member2/Login.do2");
			}

		}else if (command.equals("/member2/Login.do2")) {
			System.out.println("로그인 페이지에 들어왔음");
			System.out.println(request.getContextPath());

			RequestDispatcher rd = request.getRequestDispatcher("/member2/Login.jsp");
			rd.forward(request, response);

		}else if (command.equals("/member2/Logout.do2")) {
			
			HttpSession session = request.getSession();
			session.invalidate();
			
			response.sendRedirect(request.getContextPath()+"/board2/index2.do2");
			
		}
		
		// 회원 정보
		else if (command.equals("/member2/usersInfo.do2")) {
			
			MemberDao md = new MemberDao();
			ArrayList<MemberVo> alist =  md.memberSelectAll();
			
			request.setAttribute("alist", alist);
			
			RequestDispatcher rd = request.getRequestDispatcher("/member2/usersInfo.jsp");
			rd.forward(request, response);
			
		}
		//회원정보 상세보기
		else if (command.equals("/member2/userInfoView.do2")) {
			
			MemberDao md = new MemberDao();
			ArrayList<MemberVo> alist =  md.memberSelectAll();
			
			request.setAttribute("alist", alist);
			
			RequestDispatcher rd = request.getRequestDispatcher("/member2/userInfoView.jsp");
			rd.forward(request, response);
			
		}
		
		//회원정보 보기
		else if (command.equals("/member2/memberMyPage.do2")) {
			
			System.out.println("회원정보보기 들어왔음");
			//1.파라미터가 넘어옴
			String midx = request.getParameter("midx");
			int midx_ = Integer.parseInt(midx);
			System.out.println("midx : " +midx);
			//2. 처리함
			MemberDao md = new MemberDao();
			MemberVo mv = md.MemberSelectOne(midx_);
			request.setAttribute("mv", mv);		//내부적으로 자원공유	
			
			//3.이동함			
			RequestDispatcher rd = request.getRequestDispatcher("/member2/memberMyPage.jsp");					
			rd.forward(request, response);		
			
		}else if (command.equals("/member2/memberMyPageModify.do2")) {
			
			System.out.println("회원정보수정 들어왔음");
			//1.파라미터가 넘어옴
			String midx = request.getParameter("midx");
			int midx_ = Integer.parseInt(midx);
			
			//2. 처리함
			MemberDao md = new MemberDao();
			MemberVo mv = md.MemberSelectOne(midx_);
			
			request.setAttribute("mv", mv);		//내부적으로 자원공유	
			
			//3.이동함			
			RequestDispatcher rd = request.getRequestDispatcher("/member2/memberMyPageModify.jsp");					
			rd.forward(request, response);		
			
		}
		
//		//회원정보수정하기
//		else if (command.equals("/member2/memberMyPageModifyAction.do")) {
//			
//			String memberPwd = request.getParameter("memberPwd");
//			String memberAddr = request.getParameter("memberAddr");
//			String memberEmail = request.getParameter("memberEmail");
//			String memberPhone = request.getParameter("memberPhone");
//			String memberId = request.getParameter("memberId");
//			String midx = request.getParameter("midx");
//			int midx_ = Integer.parseInt(midx);
//			
//			
//			
//			MemberDao md = new MemberDao();
//			int value = md.updateMember(memberPwd, memberAddr, memberEmail, memberPhone, memberId, midx_);
//			System.out.println(value);
//			if (value ==1) {
//				response.sendRedirect(request.getContextPath()+"/member2/memberMyPage.do2");				
//			}else {
//				response.sendRedirect(request.getContextPath()+"/member2/memberMyPageModify.do2");				
//			}	
//			
//			
//		}
		
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	



















	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
