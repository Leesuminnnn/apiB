package jspstudy.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import jspstudy.dbconn.Dbconn;
import jspstudy.domain.MemberVo;

public class MemberDao {
	
	private Connection conn;
	private PreparedStatement pstmt;
	
	public MemberDao() {
		Dbconn db = new Dbconn();
		this.conn = db.getConnection();		
	}
	
	public int insertMember(String memberId, String memberPwd, String memberName, String memberGender, String memberAddr, String memberJumin, String memberPhone, String hobby, String memberEmail, String ip){
		int value = 0;
			
		//구문을 실행한다
		String sql = "insert into b_member(memberid,memberpwd,membername,membergender,memberaddr,memberjumin,memberphone,memberhobby,memberemail,memberip)"
				+" values(?,?,?,?,?,?,?,?,?,?)";

		//구문을 실행하고 리턴값으로 실행되었으면 1 아니면 0을 벨류 변수에 담는다.
		
		
		//연결객체를 통해서 Statement 구문객체를 생성해서 stmt에 담는다
		// try/catch 구문을 써서 예외처리
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setString(2, memberPwd);
			pstmt.setString(3, memberName);
			pstmt.setString(4, memberGender);
			pstmt.setString(5, memberAddr);
			pstmt.setString(6, memberJumin);
			pstmt.setString(7, memberPhone);
			pstmt.setString(8, hobby);
			pstmt.setString(9, memberEmail);
			pstmt.setString(10, ip);
			value = pstmt.executeUpdate();
			
			
		}catch(Exception e){
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


	public ArrayList<MemberVo> memberSelectAll(){
		// MemberVo 여러 객체를 담는 ArrayList 클래스를 객체 생성한다.
		ArrayList<MemberVo> alist = new ArrayList<MemberVo>();
		ResultSet rs = null;
		
		// 쿼리 구문을 문자열로 만들어 놓는다.
		// 기본적인 정렬방식 - 1번째 게시물이 밑으로 가는 방식
		String sql = "select * from b_member where delyn='N' order by midx desc";
		
		
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
				mv.setMembername(rs.getString("memberName"));
				mv.setMemberphone(rs.getString("memberphone"));
				mv.setWriteday(rs.getString("writeday"));
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
	
	//로그인
	
	public MemberVo memberLogin(String memberId, String memberPwd) {
		MemberVo mv = null;
		ResultSet rs = null;
		
		String sql = "select * from b_member where delyn='N' and memberid=? and memberpwd=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setString(2, memberPwd);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				mv = new MemberVo();
				mv.setMidx(rs.getInt("midx"));
				mv.setMemberid(rs.getString("memberId"));
				mv.setMembername(rs.getString("memberName"));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				rs.close();
				conn.close();				
				pstmt.close();
				} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return mv;
		
	}
	
	


}
