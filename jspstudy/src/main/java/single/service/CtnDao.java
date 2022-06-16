package single.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import single.domain.SearchCriteria;
import single.dbconn.Dbconn;
import single.domain.CtnVo;

public class CtnDao {

	private Connection conn;
	private PreparedStatement pstmt;

	public CtnDao() {
		Dbconn db = new Dbconn();
		this.conn = db.getConnection();

	}
	//시공사례작성
	public int insertCtn(String subject,String content,String writer,String ip,int midx, String filename, String tag) {
		int value=0;
		
		String sql="insert into ctn(subject,content,writer,ip,midx,filename,tag)"
		+" VALUES(?,?,?,?,?,?,?)";
		

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, subject);
			pstmt.setString(2, content);
			pstmt.setString(3, writer);
			pstmt.setString(4, ip);
			pstmt.setInt(5, midx);
			pstmt.setString(6, filename);
			pstmt.setString(7, tag);
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
	
	//시공사례리스트
	public ArrayList<CtnVo> BoardSelectAll(SearchCriteria scri){
		ArrayList<CtnVo> alist = new ArrayList<CtnVo>();
		ResultSet rs = null;
		
		String str = "";
		if(scri.getSearchType().equals("subject")) {
			str = "and subject like concat(?)";
		}else {
			str = "and tag like concat(?)";
		}
		String sql="select * from ctn where delyn='N' "+str+" order by cidx desc limit ?,10";
					
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+scri.getKeyword()+"%");
			pstmt.setInt(2, (scri.getPage()-1)*10);
			rs = pstmt.executeQuery();
			//rs.next() �������� �����ϸ� true�̰� �� ������ Ŀ���� �̵��ϴ� �޼ҵ�
			while(rs.next()) {
				CtnVo cv = new CtnVo();
				
				cv.setCidx(rs.getInt("cidx"));
				cv.setSubject(rs.getString("subject"));
				cv.setContent(rs.getString("content"));
				cv.setWriter(rs.getString("writer"));
				cv.setWriteday(rs.getString("writeday"));
				cv.setTag(rs.getString("tag"));
				cv.setFilename(rs.getString("filename"));
				alist.add(cv);
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
		
		String sql = "select count(*) as cnt from ctn where delyn='N' "+str+" ";
		
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
	//시공사례 보기
	public CtnVo boardSelectOne(int cidx) {
		CtnVo cv = null;
		ResultSet rs = null;
		
		String sql = "select * from ctn where cidx=?";	
		
		try {
			pstmt = conn.prepareStatement(sql);		
			pstmt.setInt(1, cidx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {		
				cv = new CtnVo();		
				
				cv.setCidx(rs.getInt("cidx"));
				
				cv.setSubject(rs.getString("subject"));
				cv.setContent(rs.getString("content"));
				cv.setWriter(rs.getString("writer"));
				cv.setWriteday(rs.getString("writeday"));
				cv.setFilename(rs.getString("filename"));
				cv.setTag(rs.getString("tag"));
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
		}return cv;
			
	}
	//시공사례 수정하기
	public int updateBoard(String subject, String content, String writer, String ip, int midx, int cidx) {
		int value = 0;
		
		String sql = "update ctn set subject = ?, content = ?, writer = ?, writeday = now(), ip = ?, midx = ? where cidx = ?";
				
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, subject);
			pstmt.setString(2, content);
			pstmt.setString(3, writer);
			pstmt.setString(4, ip);
			pstmt.setInt(5, midx);
			pstmt.setInt(6, cidx);
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
	// 시공사례 삭제페이지
	public int deleteCtn(int cidx) {
		int value = 0;
		
		String sql = "update ctn set delyn = 'y', writeday = now() WHERE cidx = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cidx);
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
