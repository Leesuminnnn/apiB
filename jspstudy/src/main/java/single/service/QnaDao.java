package single.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


import single.domain.SearchCriteria;
import single.dbconn.Dbconn;
import single.domain.QnaVo;

public class QnaDao {

	private Connection conn;
	private PreparedStatement pstmt;

	public QnaDao() {
		Dbconn db = new Dbconn();
		this.conn = db.getConnection();

	}
	//QnA 작성
	public int insertQna(String subject, String content, String writer, String ip, int midx) {
		int value=0;

		String sql="insert into qna(originqidx,depth,level_,subject,content,writer,ip,midx)"
				+ " select max(qidx)+1,0,0,?,?,?,?,? from qna";
		

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, subject);
			pstmt.setString(2, content);
			pstmt.setString(3, writer);
			pstmt.setString(4, ip);
			pstmt.setInt(5, midx);
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
		}return value;
	}
	
	//Qna 리스트
	public ArrayList<QnaVo> BoardSelectAll(SearchCriteria scri){
		ArrayList<QnaVo> alist = new ArrayList<QnaVo>();
		ResultSet rs = null;
		
		String str = "";
		if(scri.getSearchType().equals("subject")) {
			str = "and subject like concat(?)";
		}
		String sql="select * from qna where delyn='N' "+str+" order by originqidx desc, depth asc limit ?,10";
				
					
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+scri.getKeyword()+"%");
			pstmt.setInt(2, (scri.getPage()-1)*10);
			rs = pstmt.executeQuery();
			//rs.next() = 다음 값이 존재하면 true이고 그 행으로 커서가 이동하는 메소드*
			while(rs.next()) {
				QnaVo qv = new QnaVo();
				
				qv.setQidx(rs.getInt("qidx"));
				qv.setSubject(rs.getString("subject"));
				qv.setContent(rs.getString("content"));
				qv.setWriter(rs.getString("writer"));
				qv.setWriteday(rs.getString("writeday"));
				qv.setLevel_(rs.getInt("level_"));
				alist.add(qv);
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
		
		return alist;
	}
	// Qna 보기
		public QnaVo boardSelectOne(int qidx) {
			QnaVo qv = null;
			ResultSet rs = null;
			
			String sql = "select * from qna where qidx=?";	
			
			try {
				pstmt = conn.prepareStatement(sql);		
				pstmt.setInt(1, qidx);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {		
					qv = new QnaVo();		
					
					qv.setQidx(rs.getInt("qidx"));
					qv.setOriginqidx(rs.getInt("originqidx"));
					qv.setDepth(rs.getInt("depth"));
					qv.setLevel_(rs.getInt("level_"));
					
					qv.setSubject(rs.getString("subject"));
					qv.setContent(rs.getString("content"));
					qv.setWriter(rs.getString("writer"));
					qv.setWriteday(rs.getString("writeday"));
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
			return qv;	
		}
		
		// QnA 수정하기
		public int updateBoard(String subject, String content, String writer, String ip, int midx, int qidx) {
			int value = 0;
			
			String sql = "update qna set subject = ?, content = ?, writer = ?, writeday = now(), ip = ?, midx = ? where qidx = ?";
					
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, subject);
				pstmt.setString(2, content);
				pstmt.setString(3, writer);
				pstmt.setString(4, ip);
				pstmt.setInt(5, midx);
				pstmt.setInt(6, qidx);
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
			}return value;
			
		}
		// qna 삭제페이지
		public int deleteQna(int qidx) {
			int value = 0;
			
			String sql = "update qna set delyn = 'y', writeday = now() WHERE qidx = ?";
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, qidx);
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
		// 답변달기
		public int replyBoard(QnaVo qv) {

			int value = 0;
			String sql1 = "update qna set depth = depth+1 where originqidx = ? and depth > ?";

			String sql2 = "insert into qna(originqidx,depth,level_,subject,content,writer,ip,midx)"
					+"values(?,?,?,?,?,?,?,?)";

			try{
				// ? 부분에 대입하는것!!
				//sql구문 두개를 하나로 묶는다
				//
				conn.setAutoCommit(false);	//자동커밋 기능 끔
				
				pstmt = conn.prepareStatement(sql1);
				pstmt.setInt(1, qv.getOriginqidx());
				pstmt.setInt(2, qv.getDepth());
				pstmt.executeUpdate();
				
				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, qv.getOriginqidx());
				pstmt.setInt(2, qv.getDepth()+1);
				pstmt.setInt(3, qv.getLevel_()+1);
				pstmt.setString(4, qv.getSubject());
				pstmt.setString(5, qv.getContent());
				pstmt.setString(6, qv.getWriter());
				pstmt.setString(7, qv.getIp());
				pstmt.setInt(8, qv.getMidx());
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
		
		public int boardTotal(SearchCriteria scri) {
		int cnt = 0;
		ResultSet rs = null;
		
		
		// 검색기능
		String str = "";
		if(scri.getSearchType().equals("subject")) {
			str = "and subject like concat(?)";
		}
		
		String sql = "select count(*) as cnt from qna where delyn='N' "+str+" ";
		
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
	
	
	

}
