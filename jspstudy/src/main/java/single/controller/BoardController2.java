package single.controller;



import java.io.IOException;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


import single.service.*;
import single.domain.*;
import single.domain.PageMaker;
import single.domain.SearchCriteria;
@WebServlet("/BoardController2")
public class BoardController2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 한글깨짐 방지
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		//가상 경로로 온 request가 있으면 처리
		//전체 가상경로를 처리하는 부분--
		String uri = request.getRequestURI();
		String pj = request.getContextPath();
		String command = uri.substring(pj.length());

		System.out.println("uri:" + uri);

		System.out.println("command: " + command);
//		String uploadPath = "D:\\eclipse-jee-2022-03-R-win32-x86_64\\workspace\\jspstudy\\src\\main\\webapp\\";
		String uploadPath = "C:\\Users\\715\\git\\apiB\\jspstudy\\src\\main\\webapp\\";
//		String uploadPath = "http://tomcat/webapps/ROOT/";
		String saveFolder ="images";	
		String saveFullPath = uploadPath+saveFolder; 
		
		
	
		//견적신청페이지
		if (command.equals("/board2/estimatewrite.do2")){
			System.out.println("견적신청작성페이지");
			RequestDispatcher rd = request.getRequestDispatcher("/board2/estimatewrite.jsp");
			rd.forward(request, response);
			
		}else if (command.equals("/board2/estimatewriteAction.do2")) {
			System.out.println("견적신청작성페이지처리화면");
			
			int sizeLimit = 1024*1024*15;
			
			MultipartRequest multi = null;
			multi = new MultipartRequest(request, saveFullPath, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());
			
			String writer = multi.getParameter("writer");
			String esdays = multi.getParameter("esdays");
			String place = multi.getParameter("place");
			String memberphone = multi.getParameter("memberphone");
			
			String ip = InetAddress.getLocalHost().getHostAddress();
			
			HttpSession session = request.getSession();
			int midx = (int)session.getAttribute("midx");
			//String memberphone = (String)session.getAttribute("memberphone");
			//String memberphone = request.getParameter("memberphone");
			
			EstmDao ed = new EstmDao();
			int value = ed.insertEstm(writer, esdays, ip, place, memberphone, midx);
			System.out.println(value);
			if (value ==1) {
				response.sendRedirect(request.getContextPath()+"/board2/index2.do2");				
			}else {
				//response.sendRedirect(request.getContextPath()+"/board2/MyEstm.do2?midx="+midx);		
				response.sendRedirect(request.getContextPath()+"/board2/estimatewrite.do2");			
			}			
		} //관리자페이지
		else if (command.equals("/board2/admin.do2")) {
			
			System.out.println("관리자페이지 들어왔음");
			System.out.println(request.getContextPath());
			MemberDao md = new MemberDao();
			ArrayList<MemberVo> alist =  md.memberSelectAll();
			
			request.setAttribute("alist", alist);
			

			RequestDispatcher rd = request.getRequestDispatcher("/board2/admin.jsp");
			rd.forward(request, response);
			
		}
		
		//견적리스트
		else if (command.equals("/board2/estimatelist.do2")) {
			System.out.println("견적리스트화면");
			
				
			//처리			
			
			//
			String page = request.getParameter("page");
			if(page == null) page = "1";
			int pagex = Integer.parseInt(page);
			
			String keyword = request.getParameter("keyword");
			if(keyword == null) keyword = "";
					
			String searchType = request.getParameter("searchType");	
			if(searchType == null) searchType = "subject";
			
			SearchCriteria scri = new SearchCriteria();
			scri.setPage(pagex);
			scri.setKeyword(keyword);
			scri.setSearchType(searchType);
	
			//처리			
			EstmDao ed = new EstmDao();
			int cnt = ed.boardTotal(scri);
			
			PageMaker pm = new PageMaker();
			pm.setScri(scri);
			pm.setTotalCount(cnt);
			
			//
			
			ArrayList<EstmVo> alist = ed.BoardSelectAll(scri);
			request.setAttribute("alist", alist);   //데이터(자원) 공유
			request.setAttribute("pm", pm);
			
			

			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/estimatelist.jsp");
			rd.forward(request, response);
			
			
			
		}
		// 내가 작성항 견적리스트
		else if (command.equals("/board2/MyEstm.do2")) {
			System.out.println("내가 작성한 견적리스트화면");
			
			//처리
			String page = request.getParameter("page");
			if(page == null) page = "1";
			int pagex = Integer.parseInt(page);
			
			String keyword = request.getParameter("keyword");
			if(keyword == null) keyword = "";
					
			String searchType = request.getParameter("searchType");	
			if(searchType == null) searchType = "subject";
			
			SearchCriteria scri = new SearchCriteria();
			scri.setPage(pagex);
			scri.setKeyword(keyword);
			scri.setSearchType(searchType);
	
			//처리			
			EstmDao ed = new EstmDao();
			int cnt = ed.boardTotal(scri);
			
			PageMaker pm = new PageMaker();
			pm.setScri(scri);
			pm.setTotalCount(cnt);
			
			//
			
			ArrayList<EstmVo> myalist = ed.BoardSelectAll(scri);
			request.setAttribute("myalist", myalist);   //데이터(자원) 공유
			request.setAttribute("pm", pm);
			
			

			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/MyEstm.jsp");
			rd.forward(request, response);
		}
				
		
		else if (command.equals("/board2/estimatecontent.do2")) {
			System.out.println("견적상세보기화면");
			
			String eidx = request.getParameter("eidx");
			int eidx_ = Integer.parseInt(eidx);
			
			
			EstmDao ed =new EstmDao();
			EstmVo ev = ed.boardSelectOne(eidx_);
			request.setAttribute("ev", ev);		 
			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/estimatecontent.jsp");
			rd.forward(request, response);
		}else if (command.equals("/board2/estimatepm.do2")) {
			System.out.println("견적서 결제화면");
			
			String eidx = request.getParameter("eidx");
			int eidx_ = Integer.parseInt(eidx);

			EstmDao ed = new EstmDao();
			EstmVo ev = ed.boardSelectOne(eidx_);
			
			request.setAttribute("ev", ev);		 
			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/estimatepm.jsp");
			rd.forward(request, response);
		}else if (command.equals("/board2/estimatepmAction.do2")) {			
			System.out.println("견적서 결제화면 처리");
			
			String eidx = request.getParameter("eidx");
			int eidx_ = Integer.parseInt(eidx);
			
			EstmDao ed = new EstmDao();
			int value = ed.updateEstm(eidx_);
			
			System.out.println(value);
			if (value ==1) {
				response.sendRedirect(request.getContextPath()+"/board2/estimatelist.do2");				
			}else {
				response.sendRedirect(request.getContextPath()+"/board2/estimatecontent.do2?eidx="+eidx);				
			}		
		}
		
		/* 시공사례 */		
		else if (command.equals("/board2/ctn.do2")) {
			System.out.println("시공사례 리스트화면");
			
			String page = request.getParameter("page");
			if(page == null) page = "1";
			int pagex = Integer.parseInt(page);
			
			String keyword = request.getParameter("keyword");
			if(keyword == null) keyword = "";
					
			String searchType = request.getParameter("searchType");	
			if(searchType == null) searchType = "subject";
			
			SearchCriteria scri = new SearchCriteria();
			scri.setPage(pagex);
			scri.setKeyword(keyword);
			scri.setSearchType(searchType);
	
			//처리			
			CtnDao cd = new CtnDao();
			int cnt = cd.boardTotal(scri);
			//System.out.println("cnt"+cnt);
			PageMaker pm = new PageMaker();
			pm.setScri(scri);
			pm.setTotalCount(cnt);
			
			
			ArrayList<CtnVo> alist = cd.BoardSelectAll(scri);
			
			request.setAttribute("alist", alist);
			request.setAttribute("pm", pm);
			
			
			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/ctn.jsp");
			rd.forward(request, response);
			
		}else if (command.equals("/board2/ctnwrite.do2")){
			
			System.out.println("시공사례작성페이지");
			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/ctnwrite.jsp");
			rd.forward(request, response);
			
		}else if (command.equals("/board2/ctnwriteAction.do2")) {
			
			System.out.println("시공사례작성페이지처리화면");
			int sizeLimit = 1024*1024*15;
			
			MultipartRequest multi = null;
			multi = new MultipartRequest(request, saveFullPath, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());
			
			//열거자에 저장될 파일을 담는 객체를 생성한다
			Enumeration files = multi.getFileNames();
			//담긴 파일의 객체의 파일 이름을 얻는다
			String file = (String)files.nextElement();
			//저장되는 파일이름
			String fileName = multi.getFilesystemName(file);
			//원래 파일이름
			String originFileName = multi.getOriginalFileName(file);
			

			String subject = multi.getParameter("subject");
			String content = multi.getParameter("content");
			String writer = multi.getParameter("writer");
			String tag = multi.getParameter("tag");
			String ip = InetAddress.getLocalHost().getHostAddress();
			
			HttpSession session = request.getSession();
			int midx = (int)session.getAttribute("midx");
			
			CtnDao cd = new CtnDao();
			
			int value = cd.insertCtn(subject,content,writer,ip,midx,fileName,tag);
			
			System.out.println(value);
			if (value ==1) {
				response.sendRedirect(request.getContextPath()+"/board2/ctn.do2");				
			}else {		
				response.sendRedirect(request.getContextPath()+"/board2/ctnwrite.do2");			
			}			
		}
		//시공사례상세보기
		else if(command.equals("/board2/ctnview.do2")) {
			System.out.println("시공사례상세보기페이지");

			String cidx = request.getParameter("cidx");	
			int cidx_ = Integer.parseInt(cidx);
			
			System.out.println("cidx : " + cidx);
			
			CtnDao cd = new CtnDao();
			CtnVo cv = cd.boardSelectOne(cidx_);
			request.setAttribute("cv", cv);		

			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/ctnview.jsp");
			rd.forward(request, response);
			
		}
		//시공사례 수정하기
		else if(command.equals("/board2/ctnmodify.do2")) {
			System.out.println("시공사례수정하기페이지");
				
			String cidx = request.getParameter("cidx");		
			int cidx_ = Integer.parseInt(cidx);
			
			System.out.println("cidx : " + cidx);


			CtnDao cd = new CtnDao();
			CtnVo cv = cd.boardSelectOne(cidx_);
			request.setAttribute("cv", cv);		



				
			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/ctnmodify.jsp");
			rd.forward(request, response);
			
			//===================================================
		}
		
		else if(command.equals("/board2/ctnmodifyAction.do2")) {
			System.out.println("시공사례수정하기 처리페이지");
			
			String subject = request.getParameter("subject");
			String content = request.getParameter("content");
			String writer = request.getParameter("writer");
			String cidx = request.getParameter("cidx");
			int cidx_ = Integer.parseInt(cidx);
			
			System.out.println("subject : " + subject);
			System.out.println("content : " + content);
			System.out.println("writer : " + writer);
			System.out.println("cidx : " + cidx);
						
			String ip = InetAddress.getLocalHost().getHostAddress();
			HttpSession session = request.getSession();
			int midx = (int)session.getAttribute("midx");
			
			
			CtnDao cd = new CtnDao();
			int value = cd.updateBoard(subject, content, writer, ip, midx, cidx_);
			System.out.println(value);
			
			
			if(value == 1) {
				response.sendRedirect(request.getContextPath()+"/board2/ctnview.do2?cidx="+cidx);
			}else{
				response.sendRedirect(request.getContextPath()+"/board2/ctnmodify.do2?cidx="+cidx);
			}
			

	
		}
		//시공사례 삭제
		else if(command.equals("/board2/ctndelete.do2")) {
			System.out.println("시공사례 삭제페이지");
			
			String cidx = request.getParameter("cidx");		
			
			int cidx_ = Integer.parseInt(cidx);
			
			
			System.out.println("cidx : " + cidx);			
			
			CtnDao cd = new CtnDao();
			CtnVo cv = cd.boardSelectOne(cidx_);
			request.setAttribute("cv", cv);		
			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/ctndelete.jsp");
			rd.forward(request, response);
		}
		//시공사례 삭체처리페이지
		else if(command.equals("/board2/ctndeleteAction.do2")) {
			System.out.println("시공사례 삭제 처리 페이지");
			
			
			String cidx = request.getParameter("cidx");
			int cidx_ = Integer.parseInt(cidx);
			
			
			System.out.println("cidx : " + cidx);
			
			CtnDao cd = new CtnDao();
			int value = cd.deleteCtn(cidx_);
			System.out.println(value);
			
			
			if(value == 1) {
				response.sendRedirect(request.getContextPath()+"/board2/ctn.do2");
			}else{
				response.sendRedirect(request.getContextPath()+"/board2/ctnview.do2?cidx="+cidx);
				
			}
			
		}
		//메인화면
		else if(command.equals("/board2/index2.do2")) {
			System.out.println("메인페이지");
			
			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/index2.jsp");
			rd.forward(request, response);
			
			
		}
		
		// 고객후기화면
		
		else if (command.equals("/board2/rvList.do2")) {
			System.out.println("고객후기 리스트화면");
			
			String page = request.getParameter("page");
			if(page == null) page = "1";
			int pagex = Integer.parseInt(page);
			
			String keyword = request.getParameter("keyword");
			if(keyword == null) keyword = "";
					
			String searchType = request.getParameter("searchType");	
			if(searchType == null) searchType = "subject";
			
			SearchCriteria scri = new SearchCriteria();
			scri.setPage(pagex);
			scri.setKeyword(keyword);
			scri.setSearchType(searchType);
	
			//처리			
			RvDao rvd = new RvDao();
			int cnt = rvd.boardTotal(scri);
			
			PageMaker pm = new PageMaker();
			pm.setScri(scri);
			pm.setTotalCount(cnt);
			
			
			ArrayList<RvVo> alist = rvd.BoardSelectAll(scri);
			
			request.setAttribute("alist", alist);
			request.setAttribute("pm", pm);
			
			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/rvList.jsp");
			rd.forward(request, response);
			
		}
		
		else if (command.equals("/board2/rvwrite.do2")){
			
			System.out.println("고객후기작성페이지");
			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/rvwrite.jsp");
			rd.forward(request, response);
			
		}else if (command.equals("/board2/rvwriteAction.do2")) {
			
			System.out.println("고객후기작성페이지처리화면");
			int sizeLimit = 1024*1024*15;
			MultipartRequest multipartRequest = null;
			multipartRequest = new MultipartRequest(request, saveFullPath, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());
			
			//열거자에 저장될 파일을 담는 객체를 생성한다
			Enumeration files = multipartRequest.getFileNames();
			//담긴 파일의 객체의 파일 이름을 얻는다
			String file = (String)files.nextElement();
			//저장되는 파일이름
			String fileName = multipartRequest.getFilesystemName(file);
			//원래 파일이름
			String originFileName = multipartRequest.getOriginalFileName(file);
			

			String subject = multipartRequest.getParameter("subject");
			String content = multipartRequest.getParameter("content");
			String star = multipartRequest.getParameter("star");
			String writer = multipartRequest.getParameter("writer");
			String tag = multipartRequest.getParameter("tag");
			String ip = InetAddress.getLocalHost().getHostAddress();
			
			HttpSession session = request.getSession();
			int midx = (int)session.getAttribute("midx");
			
			RvDao rvd = new RvDao();
			
			int value = rvd.insertRv(subject,content,star,tag,writer,ip,midx,fileName);
			
			System.out.println(value);
			if (value ==1) {
				response.sendRedirect(request.getContextPath()+"/board2/rvList.do2");				
			}else {		
				response.sendRedirect(request.getContextPath()+"/board2/rvwrite.do2");			
			}			
		}
		//고객후기 상세보기
		
		else if(command.equals("/board2/rvView.do2")) {
			System.out.println("고객후기상세보기페이지");

			String ridx = request.getParameter("ridx");	
			int ridx_ = Integer.parseInt(ridx);
			
			System.out.println("ridx : " + ridx);
			
			RvDao rvd = new RvDao();
			RvVo rv = rvd.boardSelectOne(ridx_);
			request.setAttribute("rv", rv);		

			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/rvView.jsp");
			rd.forward(request, response);
			
		}
		//리뷰 수정하기
		else if(command.equals("/board2/rvModify.do2")) {
			System.out.println("고객후기 수정하기 화면으로 들어왔음");
			
			//===========ModifyAction이 아닌 Modify에 있어야 함=======
			
			//qidx를 넘겼으니까 qidx를 받아야함
			//1. 넘어온 값을 받는다
			String ridx = request.getParameter("ridx");		//스트링형을 인트형으로 형변환
			int ridx_ = Integer.parseInt(ridx);
			
			System.out.println("ridx : " + ridx);
			
			//2. 처리한다
			RvDao rvd = new RvDao();
			RvVo rv = rvd.boardSelectOne(ridx_);
			request.setAttribute("rv", rv);		//내부에 같은 위치에서 자원을 공유한다

			
			//3. 이동한다				
			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/rvModify.jsp");
			rd.forward(request, response);
			
			//===================================================
		}
		
		else if(command.equals("/board2/rvModifyAction.do2")) {
			System.out.println("rv 수정하기 처리 화면으로 들어왔음");
			
			String subject = request.getParameter("subject");
			String content = request.getParameter("content");
			String writer = request.getParameter("writer");
			String ridx = request.getParameter("ridx");
			int ridx_ = Integer.parseInt(ridx);
			
			System.out.println("subject : " + subject);
			System.out.println("content : " + content);
			System.out.println("writer : " + writer);
			System.out.println("ridx : " + ridx);
						
			String ip = InetAddress.getLocalHost().getHostAddress();
			HttpSession session = request.getSession();
			int midx = (int)session.getAttribute("midx");
			
			
			RvDao rvd = new RvDao();
			int value = rvd.updateBoard(subject, content, writer, ip, midx, ridx_);
			System.out.println(value);
			
			
			if(value == 1) {
				response.sendRedirect(request.getContextPath()+"/board2/rvView.do2?ridx="+ridx);
			}else{
				response.sendRedirect(request.getContextPath()+"/board2/rvModify.do2?ridx="+ridx);
			}
			

			
		}
		//리뷰삭제
		else if(command.equals("/board2/rvDelete.do2")) {
			System.out.println("rv삭제 화면으로 들어왔음");
			
			//1. 넘어온 값을 받는다
			String ridx = request.getParameter("ridx");		//스트링형을 인트형으로 형변환
			
			int ridx_ = Integer.parseInt(ridx);
			
			
			System.out.println("ridx : " + ridx);
			
			
			RvDao rvd = new RvDao();
			RvVo rv = rvd.boardSelectOne(ridx_);
			request.setAttribute("rv", rv);		//내부에 같은 위치에서 자원을 공유한다
			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/rvDelete.jsp");
			rd.forward(request, response);
		}
		
		else if(command.equals("/board2/rvDeleteAction.do2")) {
			System.out.println("rv 삭제 처리 화면으로 들어왔음");
			
			
			String ridx = request.getParameter("ridx");
			int ridx_ = Integer.parseInt(ridx);
			
			
			System.out.println("ridx : " + ridx);
			
			RvDao rvd = new RvDao();
			int value = rvd.deleteRv(ridx_);
			System.out.println(value);
			
			
			if(value == 1) {
				response.sendRedirect(request.getContextPath()+"/board2/rvList.do2");
			}else{
				response.sendRedirect(request.getContextPath()+"/board2/rvView.do2?ridx="+ridx);
				
			}
			
		}
		
		// 고객센터
		else if(command.equals("/board2/help.do2")) {
			System.out.println("고객센터페이지");
			RequestDispatcher rd = request.getRequestDispatcher("/board2/help.jsp");
			rd.forward(request, response);
			
			
		}
		//1:1문의하기
		else if(command.equals("/board2/iqy.do2")) {
			System.out.println("1:1문의하기 페이지");
			RequestDispatcher rd = request.getRequestDispatcher("/board2/iqy.jsp");
			rd.forward(request, response);
			
		
		}
		//1:1문의하기 작성
		else if(command.equals("/board2/iqywrite.do2")) {
			System.out.println("1:1문의하기 작성페이지");
			RequestDispatcher rd = request.getRequestDispatcher("/board2/iqywrite.jsp");
			rd.forward(request, response);
			
			
		}
		else if (command.equals("/board2/iqywriteAction.do2")) {
			System.out.println("1:1문의하기 작성 처리페이지");
			String subject = request.getParameter("subject");
			String content = request.getParameter("content");
			String writer = request.getParameter("writer");
			String ip = InetAddress.getLocalHost().getHostAddress();
			
			HttpSession session = request.getSession();
			int midx = (int)session.getAttribute("midx");
			
			IqyDao id = new IqyDao();
			int value = id.insertIqy(subject, content, writer, ip, midx);
			System.out.println(value);
			if (value ==1) {
				response.sendRedirect(request.getContextPath()+"/board2/iqy.do2");				
			}else {
				//response.sendRedirect(request.getContextPath()+"/board2/MyEstm.do2?midx="+midx);		
				response.sendRedirect(request.getContextPath()+"/board2/iqywrite.do2");			
			}			
		}
		//1:1문의하기 리스트
		else if (command.equals("/board2/iqylist.do2")) {
			System.out.println("iqy 리스트화면");
			
			String page = request.getParameter("page");
			if(page == null) page = "1";
			int pagex = Integer.parseInt(page);
			
			String keyword = request.getParameter("keyword");
			if(keyword == null) keyword = "";
					
			String searchType = request.getParameter("searchType");	
			if(searchType == null) searchType = "subject";
			
			SearchCriteria scri = new SearchCriteria();
			scri.setPage(pagex);
			scri.setKeyword(keyword);
			scri.setSearchType(searchType);
	
			//처리			
			IqyDao id = new IqyDao();
			int cnt = id.boardTotal(scri);
			
			PageMaker pm = new PageMaker();
			pm.setScri(scri);
			pm.setTotalCount(cnt);
			
			
			ArrayList<IqyVo> alist = id.BoardSelectAll(scri);
			
			request.setAttribute("alist", alist);
			request.setAttribute("pm", pm);
			
			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/iqylist.jsp");
			rd.forward(request, response);
			
		}
		//--
		//1:1문의하기 상세보기
		else if(command.equals("/board2/iqyView.do2")) {
			System.out.println("문의하기상세보기 화면으로 들어왔음");

			//iidx를 넘겼으니까 iidx를 받아야함
			//1. 넘어온 값을 받는다
			String iidx = request.getParameter("iidx");		//스트링형을 인트형으로 형변환
			int iidx_ = Integer.parseInt(iidx);
			
			System.out.println("iidx : " + iidx);
			
			//2. 처리한다
			IqyDao id = new IqyDao();
			IqyVo iv = id.boardSelectOne(iidx_);
			request.setAttribute("iv", iv);		//내부에 같은 위치에서 자원을 공유한다

			
			//3. 이동한다
			RequestDispatcher rd = request.getRequestDispatcher("/board2/iqyView.jsp");
			rd.forward(request, response);
			
			
		}else if(command.equals("/board2/iqyModify.do2")) {
			System.out.println("iqy수정하기 화면으로 들어왔음");
			
			//===========ModifyAction이 아닌 Modify에 있어야 함=======
			
			//qidx를 넘겼으니까 qidx를 받아야함
			//1. 넘어온 값을 받는다
			String iidx = request.getParameter("iidx");		//스트링형을 인트형으로 형변환
			int iidx_ = Integer.parseInt(iidx);
			
			System.out.println("iidx : " + iidx);
			
			//2. 처리한다
			IqyDao id = new IqyDao();
			IqyVo iv = id.boardSelectOne(iidx_);
			request.setAttribute("iv", iv);		//내부에 같은 위치에서 자원을 공유한다

			
			//3. 이동한다				
			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/iqyModify.jsp");
			rd.forward(request, response);
			
			//===================================================
		}
		
		else if(command.equals("/board2/iqyModifyAction.do2")) {
			System.out.println("iqy 수정하기 처리 화면으로 들어왔음");
			
			String subject = request.getParameter("subject");
			String content = request.getParameter("content");
			String writer = request.getParameter("writer");
			String iidx = request.getParameter("iidx");
			int iidx_ = Integer.parseInt(iidx);
			
			System.out.println("subject : " + subject);
			System.out.println("content : " + content);
			System.out.println("writer : " + writer);
			System.out.println("iidx : " + iidx);
						
			String ip = InetAddress.getLocalHost().getHostAddress();
		//	int midx = 2;
			HttpSession session = request.getSession();
			int midx = (int)session.getAttribute("midx");
			
			
			IqyDao id = new IqyDao();
			int value = id.updateIqy(subject, content, writer, ip, midx, iidx_);
			System.out.println(value);
			
			
			if(value == 1) {
				response.sendRedirect(request.getContextPath()+"/board2/iqyView.do2?iidx="+iidx);
			}else{
				response.sendRedirect(request.getContextPath()+"/board2/iqyModify.do2?iidx="+iidx);
			}
			

	
		}
		
		//답변하기
		else if(command.equals("/board2/iqyReply.do2")) {
			System.out.println("iqy 답변달기 화면으로 들어왔음");
		
			//1. 넘어온 값을 받는다
			String iidx = request.getParameter("iidx");		//스트링형을 인트형으로 형변환		
			String originiidx = request.getParameter("originiidx");
			String depth = request.getParameter("depth");
			String level_ = request.getParameter("level_");
			String checked = request.getParameter("checked");
			
			//2.넘어온 값을 화면에 뿌려준다
			IqyVo iv = new IqyVo();
			iv.setIidx(Integer.parseInt(iidx));
			iv.setOriginiidx(Integer.parseInt(originiidx));
			iv.setDepth(Integer.parseInt(depth));
			iv.setLevel_(Integer.parseInt(level_));
			iv.setChecked(request.getParameter(checked));
			
			request.setAttribute("iv", iv);
			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/iqyReply.jsp");
			rd.forward(request, response);
		
		}else if(command.equals("/board2/iqyReplyAction.do2")) {
			System.out.println("iqy 답변 처리 화면으로 들어왔음");
			
			String iidx = request.getParameter("iidx");			
			String originiidx = request.getParameter("originiidx");
			String depth = request.getParameter("depth");
			String level_ = request.getParameter("level_");
			String subject = request.getParameter("subject");
			String content = request.getParameter("content");
			String writer = request.getParameter("writer");
			String ip = InetAddress.getLocalHost().getHostAddress();			
		//	int midx = 2;
			HttpSession session = request.getSession();
			int midx = (int)session.getAttribute("midx");
	
			IqyVo iv = new IqyVo();
			iv.setIidx(Integer.parseInt(iidx));
			iv.setOriginiidx(Integer.parseInt(originiidx));
			iv.setDepth(Integer.parseInt(depth));
			iv.setLevel_(Integer.parseInt(level_));
			iv.setSubject(subject);
			iv.setContent(content);
			iv.setWriter(writer);
			iv.setIp(ip);
			iv.setMidx(midx);
			
			System.out.println("iidx : " + iidx);
			System.out.println("originiidx : " + originiidx);
			System.out.println("depth : " + depth);
			System.out.println("level_ : " + level_);
			System.out.println("subject : " + subject);
			System.out.println("content : " + content);
			System.out.println("writer : " + writer);
			System.out.println("ip : " + ip);
			System.out.println("midx : " + midx);
			
			
			IqyDao id = new IqyDao();
			int value = id.replyBoard(iv);
			System.out.println(value);
			
			if(value == 1) {
				response.sendRedirect(request.getContextPath()+"/board2/iqylist.do2");
			}else{
				response.sendRedirect(request.getContextPath()+"/board2/iqylist.do2");
				}
			
		
		}

		//글삭제
				else if(command.equals("/board2/iqyDelete.do2")) {
					System.out.println("iqy삭제 화면으로 들어왔음");
					
					//bidx를 넘겼으니까 bidx를 받아야함
					//1. 넘어온 값을 받는다
					String iidx = request.getParameter("iidx");		//스트링형을 인트형으로 형변환
					
					int iidx_ = Integer.parseInt(iidx);
					
					
					System.out.println("iidx : " + iidx);
					
					
					IqyDao id = new IqyDao();
					IqyVo iv = id.boardSelectOne(iidx_);
					request.setAttribute("iv", iv);		//내부에 같은 위치에서 자원을 공유한다
					
					RequestDispatcher rd = request.getRequestDispatcher("/board2/iqyDelete.jsp");
					rd.forward(request, response);
				}
				
				else if(command.equals("/board2/iqyDeleteAction.do2")) {
					System.out.println("iqy 삭제 처리 화면으로 들어왔음");
					
					
					String iidx = request.getParameter("iidx");
					int iidx_ = Integer.parseInt(iidx);
					
					
					System.out.println("iidx : " + iidx);
					
					IqyDao id = new IqyDao();
					int value = id.deleteIqy(iidx_);
					System.out.println(value);
					
					
					if(value == 1) {
						response.sendRedirect(request.getContextPath()+"/board2/iqylist.do2");
					}else{
						response.sendRedirect(request.getContextPath()+"/board2/iqyView.do2?iidx="+iidx);
						
					}
					
				}
		//--------------------
		else if(command.equals("/board2/qnaModifyAction.do2")) {
			System.out.println("qna 수정하기 처리 화면으로 들어왔음");
			
			String subject = request.getParameter("subject");
			String content = request.getParameter("content");
			String writer = request.getParameter("writer");
			String qidx = request.getParameter("qidx");
			int qidx_ = Integer.parseInt(qidx);
			
			System.out.println("subject : " + subject);
			System.out.println("content : " + content);
			System.out.println("writer : " + writer);
			System.out.println("qidx : " + qidx);
						
			String ip = InetAddress.getLocalHost().getHostAddress();
		//	int midx = 2;
			HttpSession session = request.getSession();
			int midx = (int)session.getAttribute("midx");
			
			
			QnaDao qd = new QnaDao();
			int value = qd.updateBoard(subject, content, writer, ip, midx, qidx_);
			System.out.println(value);
			
			
			if(value == 1) {
				response.sendRedirect(request.getContextPath()+"/board2/qnaView.do2?qidx="+qidx);
			}else{
				response.sendRedirect(request.getContextPath()+"/board2/qnaModify.do2?qidx="+qidx);
			}
			

	
		}
		
		//--
		
		//QnA 작성페이지
		else if (command.equals("/board2/qnawrite.do2")){
			
			System.out.println("Qna 작성페이지");
			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/qnawrite.jsp");
			rd.forward(request, response);
			
		}else if (command.equals("/board2/qnawriteAction.do2")) {
			System.out.println("Qna 작성 처리페이지");
			String subject = request.getParameter("subject");
			String content = request.getParameter("content");
			String writer = request.getParameter("writer");
			String ip = InetAddress.getLocalHost().getHostAddress();
			
			HttpSession session = request.getSession();
			int midx = (int)session.getAttribute("midx");
			
			QnaDao qd = new QnaDao();
			int value = qd.insertQna(subject, content, writer, ip, midx);
			System.out.println(value);
			if (value ==1) {
				response.sendRedirect(request.getContextPath()+"/board2/qna.do2");				
			}else {
				//response.sendRedirect(request.getContextPath()+"/board2/MyEstm.do2?midx="+midx);		
				response.sendRedirect(request.getContextPath()+"/board2/qnawrite.do2");			
			}			
		}
		// Qna 리스트
		else if (command.equals("/board2/qna.do2")) {
			System.out.println("QnA 리스트화면");
			
			String page = request.getParameter("page");
			if(page == null) page = "1";
			int pagex = Integer.parseInt(page);
			
			String keyword = request.getParameter("keyword");
			if(keyword == null) keyword = "";
					
			String searchType = request.getParameter("searchType");	
			if(searchType == null) searchType = "subject";
			
			SearchCriteria scri = new SearchCriteria();
			scri.setPage(pagex);
			scri.setKeyword(keyword);
			scri.setSearchType(searchType);
	
			//처리			
			QnaDao qd = new QnaDao();
			int cnt = qd.boardTotal(scri);
			
			PageMaker pm = new PageMaker();
			pm.setScri(scri);
			pm.setTotalCount(cnt);
			
			
			ArrayList<QnaVo> alist = qd.BoardSelectAll(scri);
			
			request.setAttribute("alist", alist);
			request.setAttribute("pm", pm);
			
			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/qna.jsp");
			rd.forward(request, response);
			
		}
		
		//QNa 상세 보기
		else if(command.equals("/board2/qnaView.do2")) {
			System.out.println("Qna상세보기 화면으로 들어왔음");

			//qidx를 넘겼으니까 qidx를 받아야함
			//1. 넘어온 값을 받는다
			String qidx = request.getParameter("qidx");		//스트링형을 인트형으로 형변환
			int qidx_ = Integer.parseInt(qidx);
			
			System.out.println("qidx : " + qidx);
			
			//2. 처리한다
			QnaDao qd = new QnaDao();
			QnaVo qv = qd.boardSelectOne(qidx_);
			request.setAttribute("qv", qv);		//내부에 같은 위치에서 자원을 공유한다

			
			//3. 이동한다
			RequestDispatcher rd = request.getRequestDispatcher("/board2/qnaView.jsp");
			rd.forward(request, response);
			
			
		}
		
		// QnA 수정하기 
		else if(command.equals("/board2/qnaModify.do2")) {
			System.out.println("qna수정하기 화면으로 들어왔음");
			
			//===========ModifyAction이 아닌 Modify에 있어야 함=======
			
			//qidx를 넘겼으니까 qidx를 받아야함
			//1. 넘어온 값을 받는다
			String qidx = request.getParameter("qidx");		//스트링형을 인트형으로 형변환
			int qidx_ = Integer.parseInt(qidx);
			
			System.out.println("qidx : " + qidx);
			
			//2. 처리한다
			QnaDao qd = new QnaDao();
			QnaVo qv = qd.boardSelectOne(qidx_);
			request.setAttribute("qv", qv);		//내부에 같은 위치에서 자원을 공유한다

			
			//3. 이동한다				
			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/qnaModify.jsp");
			rd.forward(request, response);
			
			//===================================================
		}
		
		//글삭제
		else if(command.equals("/board2/qnaDelete.do2")) {
			System.out.println("qna삭제 화면으로 들어왔음");
			
			//bidx를 넘겼으니까 bidx를 받아야함
			//1. 넘어온 값을 받는다
			String qidx = request.getParameter("qidx");		//스트링형을 인트형으로 형변환
			
			int qidx_ = Integer.parseInt(qidx);
			
			
			System.out.println("qidx : " + qidx);
			
			
			QnaDao qd = new QnaDao();
			QnaVo qv = qd.boardSelectOne(qidx_);
			request.setAttribute("qv", qv);		//내부에 같은 위치에서 자원을 공유한다
			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/qnaDelete.jsp");
			rd.forward(request, response);
		}
		
		else if(command.equals("/board2/qnaDeleteAction.do2")) {
			System.out.println("qna 삭제 처리 화면으로 들어왔음");
			
			
			String qidx = request.getParameter("qidx");
			int qidx_ = Integer.parseInt(qidx);
			
			
			System.out.println("qidx : " + qidx);
			
			QnaDao qd = new QnaDao();
			int value = qd.deleteQna(qidx_);
			System.out.println(value);
			
			
			if(value == 1) {
				response.sendRedirect(request.getContextPath()+"/board2/qna.do2");
			}else{
				response.sendRedirect(request.getContextPath()+"/board2/qnaView.do2?qidx="+qidx);
				
			}
			
		}
		//답변하기
		else if(command.equals("/board2/qnaReply.do2")) {
			System.out.println("답변달기 화면으로 들어왔음");
			//1. 넘어온 값을 받는다
			String qidx = request.getParameter("qidx");		//스트링형을 인트형으로 형변환		
			String originqidx = request.getParameter("originqidx");
			String depth = request.getParameter("depth");
			String level_ = request.getParameter("level_");
			
			//2.넘어온 값을 화면에 뿌려준다
			QnaVo qv = new QnaVo();
			qv.setQidx(Integer.parseInt(qidx));
			qv.setOriginqidx(Integer.parseInt(originqidx));
			qv.setDepth(Integer.parseInt(depth));
			qv.setLevel_(Integer.parseInt(level_));
			
			request.setAttribute("qv", qv);
			
			RequestDispatcher rd = request.getRequestDispatcher("/board2/qnaReply.jsp");
			rd.forward(request, response);
		
		}else if(command.equals("/board2/qnaReplyAction.do2")) {
			System.out.println("답변달기 처리 화면으로 들어왔음");
			
			String qidx = request.getParameter("qidx");			
			String originqidx = request.getParameter("originqidx");
			String depth = request.getParameter("depth");
			String level_ = request.getParameter("level_");
			String subject = request.getParameter("subject");
			String content = request.getParameter("content");
			String writer = request.getParameter("writer");
			String ip = InetAddress.getLocalHost().getHostAddress();			
		//	int midx = 2;
			HttpSession session = request.getSession();
			int midx = (int)session.getAttribute("midx");
	
			QnaVo qv = new QnaVo();
			qv.setQidx(Integer.parseInt(qidx));
			qv.setOriginqidx(Integer.parseInt(originqidx));
			qv.setDepth(Integer.parseInt(depth));
			qv.setLevel_(Integer.parseInt(level_));
			qv.setSubject(subject);
			qv.setContent(content);
			qv.setWriter(writer);
			qv.setIp(ip);
			qv.setMidx(midx);
			
			System.out.println("qidx : " + qidx);
			System.out.println("originqidx : " + originqidx);
			System.out.println("depth : " + depth);
			System.out.println("level_ : " + level_);
			System.out.println("subject : " + subject);
			System.out.println("content : " + content);
			System.out.println("writer : " + writer);
			System.out.println("ip : " + ip);
			System.out.println("midx : " + midx);
			
			
			QnaDao qd = new QnaDao();
			int value = qd.replyBoard(qv);
			System.out.println(value);
			
			if(value == 1) {
				response.sendRedirect(request.getContextPath()+"/board2/qna.do2");
			}else{
				response.sendRedirect(request.getContextPath()+"/board2/qnaView.do2?qidx="+qidx);
				}
			
		
		}

				
		
	}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
