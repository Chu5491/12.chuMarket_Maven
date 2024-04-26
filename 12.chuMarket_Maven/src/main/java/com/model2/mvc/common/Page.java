package com.model2.mvc.common;

public class Page 
{
	///Field
	private int currentPage;	// 현재페이지
	private int totalCount;		// 총 게시물 수
	private int pageUnit;		// 하단 페이지 번호 화면에 보여지는 수
	private int pageSize;		// 한 페이지당 보여지는 게시물수
	private int maxPage;		// 최대 페이지 번호(전체 페이지)
	private int beginUnitPage;	// 화면에 보여지는 페이지 번호의 최소수
	private int endUnitPage;	// 화면에 보여지는 페이지 번호의 최대수
	private String paging = "";
	
	///Constructor
	public Page() 
	{
		
	}
	
	public Page( int currentPage, int totalCount,	int pageUnit, int pageSize ) 
	{
		this.totalCount = totalCount;
		this.pageUnit 	= pageUnit;
		this.pageSize 	= pageSize;
		
		this.maxPage 	 = (pageSize == 0) ? totalCount :  (totalCount-1)/pageSize +1;
		this.currentPage = ( currentPage > maxPage) ? maxPage : currentPage;
		
		this.beginUnitPage = ( (currentPage-1) / pageUnit ) * pageUnit +1 ;
		
		if( maxPage <= pageUnit )
		{
			this.endUnitPage = maxPage;
			
		}else
		{
			this.endUnitPage = beginUnitPage + (pageUnit -1);
			
			if( maxPage <= endUnitPage)
			{
				this.endUnitPage = maxPage;
			}
		}
		
	}
	
	public String getPaging()
	{
		
		if(getCurrentPage() <= getPageUnit() )
		{
			paging += "◀ 이전";	
		}else
		{
			paging += "<a id='" + (getCurrentPage()-1) + "'>◀ 이전</a>";
		}

		for(int i = getBeginUnitPage(); i<= getEndUnitPage() ;i++)
		{
			if(i == getCurrentPage())
	    	{ 
				paging += "<a id='"+ i +"' style='color:red; font-size:15px;'>";
				paging += "<b> "+ i +" </b>";
				paging += "</a>";
	    	}else
	    	{ 
	    		paging += "<a id='"+ i +"'>";
	    		paging += "<b style='font-size:15px;'> "+ i +" </b>";
	    		paging += "</a>";
			} 
		 }

		if(getEndUnitPage() >= getMaxPage())
		{ 
			paging += "이후 ▶";
		}else
		{
				paging += "<a id='"+ (getEndUnitPage()+1) +"'>이후 ▶</a>";
		}
		
		return paging;
	}
	
	///Mehtod
	public int getCurrentPage() 
	{
		return currentPage;
	}
	
	public void setCurrentPage(int currentPage) 
	{
		this.currentPage = currentPage;
	}
	
	public int getTotalCount() 
	{
		return totalCount;
	}
	
	public void setTotalCount(int totalCount) 
	{
		this.totalCount = totalCount;
	}
	
	public int getPageUnit() 
	{
		return pageUnit;
	}
	
	public void setPageUnit(int pageUnit) 
	{
		this.pageUnit = pageUnit;
	}
	
	public int getPageSize() 
	{
		return pageSize;
	}
	
	public void setPageSize(int pageSize) 
	{
		this.pageSize = pageSize;
	}
	
	public int getMaxPage() 
	{
		return maxPage;
	}
	
	public void setMaxPage(int maxPage) 
	{
		this.maxPage = maxPage;
	}
	
	public int getBeginUnitPage() 
	{
		return beginUnitPage;
	}
	
	public void setBeginUnitPage(int beginUnitPage) 
	{
		this.beginUnitPage = beginUnitPage;
	}
	
	public int getEndUnitPage() 
	{
		return endUnitPage;
	}
	
	public void setEndUnitPage(int endUnitPage) 
	{
		this.endUnitPage = endUnitPage;
	}
	
	@Override
	public String toString() 
	{
		return "Page [currentPage=" + currentPage + ", totalCount="
				+ totalCount + ", pageUnit=" + pageUnit + ", pageSize="
				+ pageSize + ", maxPage=" + maxPage + ", beginUnitPage="
				+ beginUnitPage + ", endUnitPage=" + endUnitPage + "]";
	}
}