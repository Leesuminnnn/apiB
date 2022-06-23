package single.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import single.domain.SearchCriteria;
import single.dbconn.Dbconn;
import single.domain.EstmVo;

public class EstmDao {

	private Connection conn;
	private PreparedStatement pstmt;

	public EstmDao() {
		Dbconn db = new Dbconn();
		this.conn = db.getConnection();

	}
	//견적작성하기
	public int insertEstm(String writer, String esdays, String ip, String place, String memberphone, int midx) {
		int value = 0;
		
		String sql = "insert into estm (writer,esdays,ip,place,memberphone,midx) "
				+ "values(?,?,?,?,?,?)";
				
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, writer);
			pstmt.setString(2, esdays);
			pstmt.setString(3, ip);
			pstmt.setString(4, place);
			pstmt.setString(5, memberphone);
			pstmt.setInt(6, midx);
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
	public ArrayList<EstmVo> BoardSelectAll(SearchCriteria scri){
		
		ArrayList<EstmVo> alist = new ArrayList<EstmVo>();
		ResultSet rs = null;
		// 게시판 리스트 검색기능 추가
		String str = "";
		if(scri.getSearchType().equals("writer")) {
			str = "and writer like concat(?)";
		}else {
			str = "and place like concat(?)";
		}
		String sql="select * from estm where delyn='N' "+str+" order by eidx desc limit ?,10";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+scri.getKeyword()+"%");			
			pstmt.setInt(2, (scri.getPage()-1)*10);
			rs = pstmt.executeQuery();
			//rs.next() �������� �����ϸ� true�̰� �� ������ Ŀ���� �̵��ϴ� �޼ҵ�
			while(rs.next()) {
				EstmVo ev = new EstmVo();
				ev.setEidx(rs.getInt("eidx"));
				ev.setWriter(rs.getString("writer"));
				ev.setEsdays(rs.getString("esdays"));
				ev.setWriteday(rs.getString("writeday"));
				ev.setPlace(rs.getString("place"));
				ev.setChecked(rs.getString("checked"));
				ev.setPmdays(rs.getString("pmdays"));
				alist.add(ev);
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
	
	//견적상세보기
	public EstmVo boardSelectOne(int eidx) {
		EstmVo ev = null;
		ResultSet rs= null;
		String sql="select * from estm where eidx=?";
		
		try {
			pstmt = conn.prepareStatement(sql);   //����ȭ ��Ŵ
			pstmt.setInt(1, eidx);
			rs  = pstmt.executeQuery();
			
			if(rs.next()) {  //�������� �����ϸ� true Ŀ���� ���������� �̵�
				ev = new EstmVo();
				
				ev.setEidx(rs.getInt("eidx"));   
				
				ev.setWriter(rs.getString("writer"));
				ev.setWriteday(rs.getString("writeday"));
				ev.setEsdays(rs.getString("esdays"));
				ev.setPlace(rs.getString("place"));
				ev.setChecked(rs.getString("checked"));
				ev.setMemberphone(rs.getString("memberphone"));
				
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
		
		return ev;
	}
	//견적서 업데이트 하기
	public int updateEstm(int eidx) {
		int value=0;
		
		String sql="update estm set checked='Y', pmdays=now() where eidx=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, eidx);
			value= pstmt.executeUpdate();
			
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
		if(scri.getSearchType().equals("writer")) {
			str = "and writer like concat(?)";
		}else {
			str = "and place like concat(?)";
		}
		
		String sql = "select count(*) as cnt from estm where delyn='N' "+str+" ";
		
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
	
	//내가 작성한 견적서 보기
	public ArrayList<EstmVo> BoardSelectMyEList(int midx, SearchCriteria scri){
		
		ArrayList<EstmVo> myalist = new ArrayList<EstmVo>();
		ResultSet rs = null;
		
		
		String sql="select * from estm where delyn='N' and midx=? order by eidx desc limit ?,10";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(2, (scri.getPage()-1)*10);
			rs = pstmt.executeQuery();
			//rs.next() �������� �����ϸ� true�̰� �� ������ Ŀ���� �̵��ϴ� �޼ҵ�
			while(rs.next()) {
				EstmVo ev = new EstmVo();
				ev.setMidx(rs.getInt("midx"));
				
				ev.setEidx(rs.getInt("eidx"));
				ev.setWriter(rs.getString("writer"));
				ev.setEsdays(rs.getString("esdays"));
				ev.setWriteday(rs.getString("writeday"));
				ev.setPlace(rs.getString("place"));
				ev.setChecked(rs.getString("checked"));
				ev.setPmdays(rs.getString("pmdays"));
				myalist.add(ev);
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
		
		return myalist;
	}
	public int boardTotal2(SearchCriteria scri) {
		int cnt = 0;
		ResultSet rs = null;
		
		
		// 게시판 리스트 검색기능 추가
		String str = "";
		if(scri.getSearchType().equals("check")) {
			str = "and check like concat(?)";
		}else {
			str = "and un_check like concat(?)";
		}
		
		String sql = "select count(*) as cnt from estm where delyn='N' "+str+" ";
		
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
