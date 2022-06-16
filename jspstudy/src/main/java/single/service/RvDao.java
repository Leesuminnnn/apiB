package single.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import single.domain.SearchCriteria;
import single.dbconn.Dbconn;
import single.domain.RvVo;

public class RvDao {

	private Connection conn;
	private PreparedStatement pstmt;

	public RvDao() {
		Dbconn db = new Dbconn();
		this.conn = db.getConnection();

	}
	//고객후기 작성
	public int insertRv(String subject, String content, String star, String tag, String writer, String ip, int midx, String filename) {
		int value=0;
		
		String sql="insert into rv(subject,content,star,tag,writer,ip,midx,filename) "
				+ "VALUES(?,?,?,?,?,?,?,?)";		
		

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, subject);
			pstmt.setString(2, content);
			pstmt.setString(3, star);
			pstmt.setString(4, tag);
			pstmt.setString(5, writer);
			pstmt.setString(6, ip);
			pstmt.setInt(7, midx);
			pstmt.setString(8, filename);
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
	
	//고객후기리스트
	public ArrayList<RvVo> BoardSelectAll(SearchCriteria scri){
		ArrayList<RvVo> alist = new ArrayList<RvVo>();
		ResultSet rs = null;
		
		String str = "";
		if(scri.getSearchType().equals("subject")) {
			str = "and subject like concat(?)";
		}else {
			str = "and tag like concat(?)";
		}
		String sql="select * from rv where delyn='N' "+str+" order by ridx desc limit ?,10";
					
					
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+scri.getKeyword()+"%");
			pstmt.setInt(2, (scri.getPage()-1)*10);
			rs = pstmt.executeQuery();
			//rs.next() = 다음 값이 존재하면 true이고 그 행으로 커서가 이동하는 메소드*
			while(rs.next()) {
				RvVo rv = new RvVo();
				
				rv.setRidx(rs.getInt("ridx"));
				rv.setSubject(rs.getString("subject"));
				rv.setContent(rs.getString("content"));
				rv.setWriter(rs.getString("writer"));
				rv.setWriteday(rs.getString("writeday"));
				rv.setStar(rs.getString("star"));
				rv.setTag(rs.getString("tag"));
				rv.setFilename(rs.getString("filename"));
				alist.add(rv);
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
	public int boardTotal(SearchCriteria scri) {
		int cnt = 0;
		ResultSet rs = null;
		
		
		// 검색기능
		String str = "";
		if(scri.getSearchType().equals("subject")) {
			str = "and subject like concat(?)";
		}else {
			str = "and tag like concat(?)";
		}
		
		String sql = "select count(*) as cnt from rv where delyn='N' "+str+" ";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+scri.getKeyword()+"%");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			
			try {
				rs.close();
				pstmt.close();
			//	conn.close();
			} catch (SQLException e) {				
				e.printStackTrace();
			}
				
		}
		return cnt;
	}
	// 고객후기 보기
	public RvVo boardSelectOne(int ridx) {
		RvVo rv = null;
		ResultSet rs = null;
		
		String sql = "select * from rv where ridx=?";	
		
		try {
			pstmt = conn.prepareStatement(sql);		
			pstmt.setInt(1, ridx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {		
				rv = new RvVo();		
				
				rv.setRidx(rs.getInt("ridx"));
				
				rv.setSubject(rs.getString("subject"));
				rv.setContent(rs.getString("content"));
				rv.setWriter(rs.getString("writer"));
				rv.setWriteday(rs.getString("writeday"));
				rv.setStar(rs.getString("star"));
				rv.setFilename(rs.getString("filename"));
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
		}return rv;
			
	}
	//고객후기 수정하기
	public int updateBoard(String subject, String content, String writer, String ip, int midx, int ridx) {
		int value = 0;
		
		String sql = "update rv set subject = ?, content = ?, writer = ?, writeday = now(), ip = ?, midx = ? where ridx = ?";
				
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, subject);
			pstmt.setString(2, content);
			pstmt.setString(3, writer);
			pstmt.setString(4, ip);
			pstmt.setInt(5, midx);
			pstmt.setInt(6, ridx);
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
	// 고객후기 삭제페이지
	public int deleteRv(int ridx) {
		int value = 0;
		
		String sql = "update rv set delyn = 'y', writeday = now() WHERE ridx = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ridx);
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
