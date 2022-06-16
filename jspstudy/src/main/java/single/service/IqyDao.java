package single.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


import single.dbconn.Dbconn;
import single.domain.IqyVo;
import single.domain.SearchCriteria;

public class IqyDao {

	private Connection conn;
	private PreparedStatement pstmt;

	public IqyDao() {
		Dbconn db = new Dbconn();
		this.conn = db.getConnection();

	}
	//문의작성하기
	public int insertIqy(String subject, String content, String writer, String ip, int midx) {
		int value = 0;
		
		String sql = "insert into iqy (originiidx, depth, level_, subject, content, writer, ip, midx)"
				+ " select max(iidx)+1,0,0,?,?,?,?,? from iqy";
					
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, subject);
			pstmt.setString(2, content);
			pstmt.setString(3, writer);
			pstmt.setString(4, ip);
			pstmt.setInt(5, midx);
			value= pstmt.executeUpdate();
			
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
	//관리자페이지에서 견적리스트 보기
	public ArrayList<IqyVo> BoardSelectAll(SearchCriteria scri){		
		ArrayList<IqyVo> alist = new ArrayList<IqyVo>();
		ResultSet rs = null;
		String str = "";
		// 게시판 리스트 검색기능 추가
		
		if(scri.getSearchType().equals("subject")) {
			str = "and subject like concat(?)";
		}
		
		
		String sql = "SELECT * FROM iqy WHERE delyn='N' "+str+" ORDER BY originiidx DESC, depth asc limit ?,10";
		
		//conn 객체를 활용해서 pstmt를 활용해 쿼리를 실행한다.
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+scri.getKeyword()+"%");
			pstmt.setInt(2, (scri.getPage()-1)*10);
			rs = pstmt.executeQuery();
			//rs.next() = 다음 값이 존재하면 true이고 그 행으로 커서가 이동하는 메소드*
			while(rs.next()) {
				IqyVo iv = new IqyVo();
				
				iv.setIidx(rs.getInt("iidx"));
				iv.setSubject(rs.getString("subject"));
				iv.setWriter(rs.getString("writer"));
				iv.setWriteday(rs.getString("writeday"));
				iv.setLevel_(rs.getInt("level_"));		
				iv.setChecked(rs.getString("checked"));		
				alist.add(iv);
				
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
		
		return alist;
	}
	
	//문의상세보기
	public IqyVo boardSelectOne(int iidx) {
		IqyVo iv = null;
		ResultSet rs= null;
		String sql="select * from iqy where iidx=?";
		
		try {
			pstmt = conn.prepareStatement(sql);   //����ȭ ��Ŵ
			pstmt.setInt(1, iidx);
			rs  = pstmt.executeQuery();
			
			if(rs.next()) {  //�������� �����ϸ� true Ŀ���� ���������� �̵�
				iv = new IqyVo();
				
				iv.setIidx(rs.getInt("iidx"));
				iv.setOriginiidx(rs.getInt("originiidx"));
				iv.setDepth(rs.getInt("depth"));
				iv.setLevel_(rs.getInt("level_"));
				
				iv.setSubject(rs.getString("subject"));
				iv.setContent(rs.getString("content"));
				iv.setWriter(rs.getString("writer"));
				iv.setWriteday(rs.getString("writeday"));
				iv.setChecked(rs.getString("checked"));
				
			}			
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} finally {
			
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {				
				e.printStackTrace();
			}
			
		}	
		
		return iv;
	}
	//문의 수정 하기
	public int updateIqy(String subject, String content, String writer, String ip, int midx, int iidx) {
		int value=0;
		
		String sql="update iqy set subject = ?, content = ?, writer = ?, writeday = now(), ip = ?, midx = ? where iidx = ?";
				
					try {
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, subject);
						pstmt.setString(2, content);
						pstmt.setString(3, writer);
						pstmt.setString(4, ip);
						pstmt.setInt(5, midx);
						pstmt.setInt(6, iidx);
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
	
	public int checkIqy(int iidx) {
		int value = 0;
		
		String sql = "update iqy set checked = 'Y' where iidx=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, iidx);
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
	
	
	public int boardTotal(SearchCriteria scri) {
		int cnt = 0;
		ResultSet rs = null;
		
		
		// 게시판 리스트 검색기능 추가
		String str = "";
		if(scri.getSearchType().equals("subject")) {
			str = "and subject like concat(?)";
		}else {
			str = "and writer like concat(?)";
		}
		
		String sql = "select count(*) as cnt from iqy where delyn='N' "+str+" ";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+scri.getKeyword()+"%");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}
	// 답변달기
	public int replyBoard(IqyVo iv) {

		int value = 0;

		
		String sql1 = "update iqy set depth = depth+1 where originiidx = ? and depth > ?";

		String sql2 = "insert into iqy(originiidx,depth,level_,subject,content,writer,ip,midx)"
				+"values(?,?,?,?,?,?,?,?)";

		try{
			
			conn.setAutoCommit(false);	//자동커밋 기능 끔
			
			pstmt = conn.prepareStatement(sql1);
			pstmt.setInt(1, iv.getOriginiidx());
			pstmt.setInt(2, iv.getDepth());
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(sql2);
			pstmt.setInt(1, iv.getOriginiidx());
			pstmt.setInt(2, iv.getDepth()+1);
			pstmt.setInt(3, iv.getLevel_()+1);
			pstmt.setString(4, iv.getSubject());
			pstmt.setString(5, iv.getContent());
			pstmt.setString(6, iv.getWriter());
			pstmt.setString(7, iv.getIp());
			pstmt.setInt(8, iv.getMidx());
			value = pstmt.executeUpdate();
			
			conn.commit();
			
			
		}catch(SQLException e){
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}finally {
		//ㄴconn객체를 끊기 위한 구문
			try {
				conn.close();
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return value;
		
	}
	// 글 삭제하기
	public int deleteIqy(int iidx) {
		int value = 0;
		
		String sql = "update iqy set delyn = 'y', writeday = now() WHERE iidx = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, iidx);
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

}
