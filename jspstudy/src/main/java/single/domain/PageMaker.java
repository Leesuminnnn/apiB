package single.domain;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

public class PageMaker {
	
	private int totalCount;		// ��ü ������ ����
	private int startPage;		// ù��° ��ȣ
	private int endPage;		// ��������° ��ȣ
	private boolean prev;		// ���� ��ư
	private boolean next;		// ���� ��ư
	private int displayPageNum = 10;
	private SearchCriteria scri;
	
	
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}
	public SearchCriteria getScri() {
		return scri;
	}
	public void setScri(SearchCriteria scri) {
		this.scri = scri;
	}
	// ���������� �������� ���� ���� ��ư ���� �����ϴ� �޼ҵ�
	
	public void calcData() {
		// 10 20 30
							//ceil  => �ø�ó��
		endPage = (int)(Math.ceil(scri.getPage()/(double)displayPageNum)*displayPageNum);
		
		startPage = (endPage-displayPageNum)+1;
		
		int tempEndPage = (int)(Math.ceil(totalCount/(double)scri.getPerPageNum()));
		
		if(endPage > tempEndPage) {
			endPage = tempEndPage;
				
		}
		
		prev = startPage == 1 ? false:true;
		next = endPage*scri.getPerPageNum() >= totalCount ? false:true;
	}

	public String encoding(String keyword) {
		String str = "";	
			
		try {
			if (keyword != null) {
				str = URLEncoder.encode(keyword, "UTF-8");
			}
		} catch (UnsupportedEncodingException e) {
			
			e.printStackTrace();
		}
		
		System.out.println("str"+str);
		return str;
	}
	
	
	
	
	
}
