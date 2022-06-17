package single.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import single.dbconn.Dbconn;
import single.domain.MemberVo;

public class MemberDao {
	


	private Connection conn;
	private PreparedStatement pstmt;

	public MemberDao() {
		Dbconn db = new Dbconn();
		this.conn = db.getConnection();
		
		
		
		
		
		
		}
		
	

	//회원가입
	public int insertMember(String memberId, String memberPwd, String memberName, String memberEmail, String memberGender, String memberAddr, String memberPhone, String ip) {


		int value = 0;

		String sql = "insert into users(memberid,memberpwd,membername,memberemail,membergender,memberaddr,memberphone,memberip)"
				+ "values(?,?,?,?,?,?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setString(2, memberPwd);
			pstmt.setString(3, memberName);
			pstmt.setString(4, memberEmail);
			pstmt.setString(5, memberGender);
			pstmt.setString(6, memberAddr);
			pstmt.setString(7, memberPhone);
			pstmt.setString(8, ip);
			value = pstmt.executeUpdate();
		} catch (SQLException e) {

			e.printStackTrace();
		}finally {

			try {
				conn.close();
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return value;
	}
	// 아이디 중복체크
	public int registerCheck(String memberId) {
		int idCheck = 0;
		String sql = "select count(*) from users where memberid = ?";
		ResultSet rs = null;
		
		try {
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, memberId);
			 
			 rs = pstmt.executeQuery();
			 
			 rs.next();
			 
			 idCheck=rs.getInt(1);
			
	    } catch(SQLException e) {
				 e.printStackTrace();
				 return -1;
		
		}finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
				} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		
		
		return idCheck;
	}
	
	
	
	//로그인
	public MemberVo Login(String memberId, String memberPwd) {
		MemberVo mv = null;
		ResultSet rs = null;
		
		String sql = "select * from users where delyn='N' and memberid=? and memberpwd=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setString(2, memberPwd);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				mv = new MemberVo();
				mv.setMidx(rs.getInt("midx"));
				mv.setMemberid(rs.getString("memberId"));
				mv.setMembername(rs.getString("memberName"));
				mv.setMemberphone(rs.getString("memberPhone"));
				mv.setImadmin(rs.getString("imadmin"));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
				} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return mv;
		
	}
	//회원정보보기
	public MemberVo MemberSelectOne(int midx) {
		MemberVo mv = null;
		ResultSet rs = null;
		
		String sql="select * from users where midx=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, midx);
			rs  = pstmt.executeQuery();
			
			if (rs.next()) {				
				mv = new MemberVo();
				mv.setMidx(rs.getInt("midx"));
				mv.setMemberid(rs.getString("memberid"));
				mv.setMemberpwd(rs.getString("memberpwd"));
				mv.setMemberemail(rs.getString("memberemail"));
				mv.setMemberaddr(rs.getString("memberaddr"));
				mv.setMemberphone(rs.getString("memberphone"));
				mv.setWriteday(rs.getString("writeday"));
				mv.setMembergender(rs.getString("membergender"));
				mv.setMembername(rs.getString("membername"));
			}
		} catch (SQLException e) {			
			e.printStackTrace();
		}finally {
			
			try {
				rs.close();
				pstmt.close();
				conn.close();

			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		
		return mv;
	}

	//회원정보업데이트
	public int updateMember(String memberPwd, String memberAddr, String memberEmail, String memberPhone, String memberId, int midx) {
		
		int value = 0;
		String sql = "update users set memberpwd=?, memberaddr=?, memberemail=?, memberphone=?, memberid=? where midx=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberPwd);
			pstmt.setString(2, memberAddr);
			pstmt.setString(3, memberEmail);
			pstmt.setString(4, memberPhone);
			pstmt.setString(5, memberId);
			pstmt.setInt(6, midx);
			value = pstmt.executeUpdate();
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			
			try {
				pstmt.close();
				conn.close();

			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		
		return value;
		
	}
	
	public ArrayList<MemberVo> memberSelectAll(){
		// MemberVo 여러 객체를 담는 ArrayList 클래스를 객체 생성한다.
		ArrayList<MemberVo> alist = new ArrayList<MemberVo>();
		ResultSet rs = null;
		
		// 쿼리 구문을 문자열로 만들어 놓는다.
		// 기본적인 정렬방식 - 1번째 게시물이 밑으로 가는 방식
		String sql = "select * from users where delyn='N'and imadmin='N' order by midx desc";
		
		
		try{
			//연결객체에 있는 prepareStatement 메소드를 실행해서 sql문자열을 담아 구문 객체를 만든다.
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				//반복할때마다 객체 생성한다.
				MemberVo mv = new MemberVo();
				//rs에 담아놓은 컬럼값들을 mv에 옮겨담는다.
				//왜 4가지만? = 보이는부분이라서
				mv.setMidx(rs.getInt("midx"));
				mv.setMemberid(rs.getString("memberid"));
				mv.setMembername(rs.getString("membername"));
				mv.setMemberphone(rs.getString("memberphone"));
				mv.setMemberemail(rs.getString("memberemail"));
				mv.setWriteday(rs.getString("writeday"));
				mv.setMembergender(rs.getString("membergender"));
				//alist에 값을 담는 객체를 추가한다.
				alist.add(mv);
			}
		
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				rs.close();
				pstmt.close();			
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}			
		}
		
		return alist;
	}
	
	


	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
