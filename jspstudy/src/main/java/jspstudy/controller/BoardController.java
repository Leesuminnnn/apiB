package jspstudy.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.InetAddress;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jspstudy.domain.BoardVo;
import jspstudy.domain.PageMaker;
import jspstudy.domain.SearchCriteria;
import jspstudy.service.BoardDao;



@WebServlet("/BoardController")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;  
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//boardWriteok.jsp에 있어야할 기능들
		//한글깨짐 방지
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		//가상 경로로 온 request가 있으면 처리
		//전체 가상경로를 처리하는 부분--
		String uri = request.getRequestURI();
		String pj = request.getContextPath();
		String command = uri.substring(pj.length());
		
		int sizeLimit = 1024*1024*15;
		String uploadPath = "D:\\eclipse-jee-2022-03-R-win32-x86_64\\workspace\\jspstudy\\src\\main\\webapp\\";
		String saveFolder = "images";
		String saveFullPath = uploadPath+saveFolder;
		
		
		
		//System.out.println("command : "+ command);
		//--
		
		//글쓰기
		if(command.equals("/board/boardWrite.do")) {
			System.out.println("글쓰기 화면에 들어왔음");
			RequestDispatcher rd = request.getRequestDispatcher("/board/boardWrite.jsp");
			rd.forward(request, response);
			
			
		}else if(command.equals("/board/boardWriteAction.do")) {
			System.out.println("글쓰기 처리 화면으로 들어왔음");
			
			MultipartRequest multipartRequest = null;
			multipartRequest = new MultipartRequest(request, saveFullPath, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());
			
			
			
			
			String subject = multipartRequest.getParameter("subject");
			String content = multipartRequest.getParameter("content");
			String writer = multipartRequest.getParameter("writer");
			
			// 열거자인 저장될 파일을 담는 객체생성
			Enumeration files = multipartRequest.getFileNames();
			// 담긴 객체의 파일 이름을 얻는다
			String file = (String)files.nextElement();
			// 넘어오는 객체중에 해당되는 파일 이름으로 되어있는 파일 이름을 추출한다 (저장되는 파일이름)
			String fileName = multipartRequest.getFilesystemName(file);
			// 원본의 파일이름
			String originFileName = multipartRequest.getOriginalFileName(file);
			
			
			
			
			
		//	System.out.println(subject+";"+content+";"+writer);
			
			//ip추출
			String ip = InetAddress.getLocalHost().getHostAddress();
			
		//	int midx = 2;
			HttpSession session = request.getSession();
			int midx = (int)session.getAttribute("midx");
			
			BoardDao bd = new BoardDao();

			
			int value = bd.insertBoard(subject, content, writer, ip, midx, fileName);
			
			if(value == 1) {
				response.sendRedirect(request.getContextPath()+"/board/boardList.do");
			}else{
				response.sendRedirect(request.getContextPath()+"/board/boardWrite.do");
			}
			
		}
		// 글 목록 보기
		else if(command.equals("/board/boardList.do")) {
			System.out.println("글목록 보기 화면으로 들어왔음");
			
			String page = request.getParameter("page");
			if(page == null) page = "1";
			int pagex = Integer.parseInt(page);
			
			// 검색기능
			String keyword = request.getParameter("keyword");
			if(keyword == null) keyword = "";
					
			String searchType = request.getParameter("searchType");	
			if(searchType == null) searchType = "subject";
			
			SearchCriteria scri = new SearchCriteria();
			scri.setPage(pagex);
			scri.setSearchType(searchType);
			scri.setKeyword(keyword);
			
			// 처리
			BoardDao bd = new BoardDao();
			int cnt = bd.boardTotal(scri);
			
			
			PageMaker pm = new PageMaker();
			pm.setScri(scri);
			pm.setTotalCount(cnt);
			
			
			ArrayList<BoardVo> alist = bd.BoardSelectAll(scri);
			
			request.setAttribute("alist", alist);
			request.setAttribute("pm", pm);
			
			
			//이동
			RequestDispatcher rd = request.getRequestDispatcher("/board/boardList.jsp");
			rd.forward(request, response);
			
			
			
		}
		//글 상세 보기
		else if(command.equals("/board/boardContent.do")) {
			System.out.println("글상세보기 화면으로 들어왔음");

			
			
			//bidx를 넘겼으니까 bidx를 받아야함
			//1. 넘어온 값을 받는다
			String bidx = request.getParameter("bidx");		//스트링형을 인트형으로 형변환
			int bidx_ = Integer.parseInt(bidx);
			
			System.out.println("bidx : " + bidx);
			
			//2. 처리한다
			BoardDao bd = new BoardDao();
			BoardVo bv = bd.boardSelectOne(bidx_);
			request.setAttribute("bv", bv);		//내부에 같은 위치에서 자원을 공유한다

			
			//3. 이동한다
			RequestDispatcher rd = request.getRequestDispatcher("/board/boardContent.jsp");
			rd.forward(request, response);
			
			
			
			
			
			
		}
		
		// 글 수정하기 
		else if(command.equals("/board/boardModify.do")) {
			System.out.println("글수정하기 화면으로 들어왔음");
			
			//===========ModifyAction이 아닌 Modify에 있어야 함=======
			
			//bidx를 넘겼으니까 bidx를 받아야함
			//1. 넘어온 값을 받는다
			String bidx = request.getParameter("bidx");		//스트링형을 인트형으로 형변환
			int bidx_ = Integer.parseInt(bidx);
			
			System.out.println("bidx : " + bidx);
			
			//2. 처리한다
			BoardDao bd = new BoardDao();
			BoardVo bv = bd.boardSelectOne(bidx_);
			request.setAttribute("bv", bv);		//내부에 같은 위치에서 자원을 공유한다

			
			//3. 이동한다				
			
			RequestDispatcher rd = request.getRequestDispatcher("/board/boardModify.jsp");
			rd.forward(request, response);
			
			//===================================================
		}
		
		
		else if(command.equals("/board/boardModifyAction.do")) {
			System.out.println("글수정하기 처리 화면으로 들어왔음");
			
			String subject = request.getParameter("subject");
			String content = request.getParameter("content");
			String writer = request.getParameter("writer");
			String bidx = request.getParameter("bidx");
			int bidx_ = Integer.parseInt(bidx);
			
			System.out.println("subject : " + subject);
			System.out.println("content : " + content);
			System.out.println("writer : " + writer);
			System.out.println("bidx : " + bidx);
						
			String ip = InetAddress.getLocalHost().getHostAddress();
		//	int midx = 2;
			HttpSession session = request.getSession();
			int midx = (int)session.getAttribute("midx");
			
			
			BoardDao bd = new BoardDao();
			int value = bd.updateBoard(subject, content, writer, ip, midx, bidx_);
			System.out.println(value);
			
			
			if(value == 1) {
				response.sendRedirect(request.getContextPath()+"/board/boardContent.do?bidx="+bidx);
			}else{
				response.sendRedirect(request.getContextPath()+"/board/boardModify.do?bidx="+bidx);
			}
			

	
		}
		//글삭제
		else if(command.equals("/board/boardDelete.do")) {
			System.out.println("글삭제 화면으로 들어왔음");
			
			//bidx를 넘겼으니까 bidx를 받아야함
			//1. 넘어온 값을 받는다
			String bidx = request.getParameter("bidx");		//스트링형을 인트형으로 형변환
			
			int bidx_ = Integer.parseInt(bidx);
			
			
			System.out.println("bidx : " + bidx);
			
			
			BoardDao bd = new BoardDao();
			BoardVo bv = bd.boardSelectOne(bidx_);
			request.setAttribute("bv", bv);		//내부에 같은 위치에서 자원을 공유한다
			
			RequestDispatcher rd = request.getRequestDispatcher("/board/boardDelete.jsp");
			rd.forward(request, response);
		}
		
		else if(command.equals("/board/boardDeleteAction.do")) {
			System.out.println("글삭제 처리 화면으로 들어왔음");
			
			
			String bidx = request.getParameter("bidx");
			int bidx_ = Integer.parseInt(bidx);
			
			
			System.out.println("bidx : " + bidx);
			
			BoardDao bd = new BoardDao();
			int value = bd.deleteBoard(bidx_);
			System.out.println(value);
			
			
			if (value ==1) {
				response.sendRedirect(request.getContextPath()+"/board/boardList.do");				
			}else {
				response.sendRedirect(request.getContextPath()+"/board/boardContent.do?bidx="+bidx);				
			}
			
		}

		
		//답변하기
		else if(command.equals("/board/boardReply.do")) {
			System.out.println("답변달기 화면으로 들어왔음");
			//bidx를 넘겼으니까 bidx를 받아야함
			//1. 넘어온 값을 받는다
			String bidx = request.getParameter("bidx");		//스트링형을 인트형으로 형변환		
			String originbidx = request.getParameter("originbidx");
			String depth = request.getParameter("depth");
			String level_ = request.getParameter("level_");
			
			//2.넘어온 값을 화면에 뿌려준다
			BoardVo bv = new BoardVo();
			bv.setBidx(Integer.parseInt(bidx));
			bv.setOriginbidx(Integer.parseInt(originbidx));
			bv.setDepth(Integer.parseInt(depth));
			bv.setLevel_(Integer.parseInt(level_));
			
			request.setAttribute("bv", bv);
			
			RequestDispatcher rd = request.getRequestDispatcher("/board/boardReply.jsp");
			rd.forward(request, response);
		
		}else if(command.equals("/board/boardReplyAction.do")) {
			System.out.println("답변달기 처리 화면으로 들어왔음");
			
			String bidx = request.getParameter("bidx");			
			String originbidx = request.getParameter("originbidx");
			String depth = request.getParameter("depth");
			String level_ = request.getParameter("level_");
			String subject = request.getParameter("subject");
			String content = request.getParameter("content");
			String writer = request.getParameter("writer");
			String ip = InetAddress.getLocalHost().getHostAddress();			
		//	int midx = 2;
			HttpSession session = request.getSession();
			int midx = (int)session.getAttribute("midx");

			BoardVo bv = new BoardVo();
			bv.setBidx(Integer.parseInt(bidx));
			bv.setOriginbidx(Integer.parseInt(originbidx));
			bv.setDepth(Integer.parseInt(depth));
			bv.setLevel_(Integer.parseInt(level_));
			bv.setSubject(subject);
			bv.setContent(content);
			bv.setWriter(writer);
			bv.setIp(ip);
			bv.setMidx(midx);
			
			System.out.println("bidx : " + bidx);
			System.out.println("originbidx : " + originbidx);
			System.out.println("depth : " + depth);
			System.out.println("level_ : " + level_);
			System.out.println("subject : " + subject);
			System.out.println("content : " + content);
			System.out.println("writer : " + writer);
			System.out.println("ip : " + ip);
			System.out.println("midx : " + midx);
			
			
			BoardDao bd = new BoardDao();
			int value = bd.replyBoard(bv);
			
			
			if(value == 1) {
				response.sendRedirect(request.getContextPath()+"/board/boardList.do");
			}else{
				response.sendRedirect(request.getContextPath()+"/board/boardContent.do?bidx="+bidx);
			}
			
		// 첨부파일 다운로드
		}else if(command.equals("/board/fileDownload.do")) {
			
			String filename = request.getParameter("filename");
			// 파일의 전체경로
			String filePath = saveFullPath+File.separator+filename;
			Path source = Paths.get(filePath);
			
			String mimeType = Files.probeContentType(source);
			// 파일형식을 헤더 정보에 담는다
			if(mimeType == null) {
				mimeType = "application/octet-stream";
			}
			response.setContentType(mimeType);
			
			String encodingFileName = new String(filename.getBytes("UTF-8"));
			// 첨부해서 다운로드 되는 파일을 헤더 정보에 담는다
			response.setHeader("content-Disposition", "attachment;fileName="+encodingFileName);
			// 해당 위치에 있는 파일을 읽어드린다
			FileInputStream fileInputStream = new FileInputStream(filePath);
			// 파일쓰기 위한 스트림
			ServletOutputStream servletOutStream = response.getOutputStream();
			
			byte[] b = new byte[4096];
			
			int read = 0;
			
			while((read = fileInputStream.read(b, 0, b.length))!=- 1) {
				// 파일쓰기
				servletOutStream.write(b, 0, read);
				
			}
			// 출력
			servletOutStream.flush();
			servletOutStream.close();
			fileInputStream.close();
			
		}
		
		
		
		
		
		
		
		
		
		
	

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		doGet(request, response);
	}

}
