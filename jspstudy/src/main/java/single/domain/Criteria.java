package single.domain;

public class Criteria {

	private int page;			// ������ ��ȣ
	private int perPageNum;		// ȭ�鿡 ����Ʈ ��� ����
	
	
	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
		
	}


	public int getPage() {
		return page;
	}


	public void setPage(int page) {
		
		if(page <= 1) {
			this.page = 1;
			return;			
		}
		
		this.page = page;
	}


	public int getPerPageNum() {
		return perPageNum;
	}


	public void setPerPageNum(int perPageNum) {
		this.perPageNum = perPageNum;
	}
	
}
