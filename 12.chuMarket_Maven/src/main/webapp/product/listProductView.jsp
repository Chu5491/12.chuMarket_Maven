<%
	/***************************************************
	*	작성자 : 추경운
	*	작성일 : 2024-03-31
	*	내  용 : 기존의 FrameSet 형식을 
	*			 header / article / footer 
	*			 jspInclude 방식으로 수정 
	*			 Bulma Css FrameWork 적용에 따른
	*			 페이지 UI 수정
	****************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<!-- Header -->
	<header>
		<jsp:include page="/layout/header.jsp"></jsp:include>
	</header>
	<!-- Header -->
	
	<!-- Script -->
	<script type="text/javascript">
		$(function() 
		{
			var menu = '${menu}';
			
			/* ########################## Style ########################## */	
			$(".ct_btn01").css('cursor', 'pointer');
			$(".pageNavi > tbody > tr > td > a").css('cursor', 'pointer');
			$(".ct_list_pop > td:nth-child(2)").css('cursor', 'pointer');
			$(".ct_list_pop > td:nth-child(5)").css('cursor', 'pointer');
			/* ########################## Style ########################## */	
			
			
			/* ########################## Paging ########################## */
			$(".pageNavi > tbody > tr > td > a").on("click" , function() 
		 	{
				fncGetList($(this).attr('id'));
			}); 
			/* ########################## Paging ########################## */
			
			
			/* ########################## Search ########################## */
			$( ".ct_btn01:contains('검색')" ).on("click" , function() 
		 	{
				fncGetList(1);
			}); 
			/* ########################## Search ########################## */
			
			
			/* ########################## Product ########################## */
			$(".ct_list_pop > td:nth-child(2)").on("click" , function() 
			{
				var stock = $(this).parent().children('td:nth-child(11)').attr('id');

				if(menu == "manage" || menu == "bsns")
				{
					$(window.location).attr("href","/product/getProduct?prodNo="+$(this).attr('id')+"&menu="+menu);
				}else
				{
					if(stock == 0)
					{
						alert("품절된 상품입니다.");
					}else
					{
						$(window.location).attr("href","/product/getProduct?prodNo="+$(this).attr('id')+"&menu="+menu);
					}
				}
		 		
			}); 
			
			$(".ct_list_pop > td:nth-child(5)").on("click" , function() 
			{
		 		$(window.location).attr("href","/market/getMarket?marketNo="+$(this).attr('id')+"&menu="+menu);
			}); 
			/* ########################## Product ########################## */
		});
	</script>
	<!-- Script -->
	
	<body bgcolor="#ffffff" text="#000000">
		
		<!-- Article -->
		<div style="width:98%; margin-left:10px;">
			<form name="detailForm" action="/product/listProduct?menu=${menu}" method="post">
			<div class="table-container">
				<table class="table" width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td background="/images/ct_ttl_img02.gif" width="100%">
							<b>${menu =='search' ? '상품 목록조회' : '상품 관리'}</b>
						</td>
					</tr>
				</table>
				
				<div class="container is-max-desktop" >
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td align="right">
								<div class="select">
									<select name="searchCondition" class="ct_input_g" style="height:40px">
										<option value="no" ${! empty search.searchCondition && search.searchCondition == 'no' ? 'selected' : ""}>상품번호</option>
										<option value="name" ${! empty search.searchCondition && search.searchCondition == 'name' ? 'selected' : ""}>상품명</option>
										<option value="price" ${! empty search.searchCondition && search.searchCondition == 'price' ? 'selected' : ""}>상품가격</option>
									</select>
								</div>
								<input type="text" name="searchKeyword"  value="${search.searchKeyword }" 
									class="ct_input_g input" style="width:200px; height:40px" >
							</td>
							<td align="right" width="70">
								<table border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="17" height="23">
											<img src="/images/ct_btnbg01.gif" width="17" height="23">
										</td>
										<td align="right" width="70">
											<button class="button ct_btn01" style="height:40px">검색</button>
										</td>
										<td width="14" height="23">
											<img src="/images/ct_btnbg03.gif" width="14" height="23">
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				
					<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
						<tr>
							<td colspan="13" >전체 <span style="color:red;">${resultPage.totalCount}</span> 건수, 현재 <span style="color:red;">${resultPage.currentPage}</span> 페이지</td>
						</tr>
						<tr>
							<th align="center" class="ct_list_b" width="100">No</th>
							<th class="ct_list_b" width="150">상품명</th>
							<th class="ct_list_b" width="150">가격</th>
							<th class="ct_list_b">등록일</th>	
							<th class="ct_list_b">쇼핑몰</th>	
							<th class="ct_list_b">현재상태</th>	
						</tr>
						<c:forEach var="prod" items="${list}" >
							<c:set var="i" value="${ i+1 }" />
							<tr class="ct_list_pop">
								<td align="center">${i}</td>
								<td align="left" id="${prod.prodNo}">
									<a style="color:#4285F4">
										${prod.prodName}
									</a>
								</td>
								<td align="left">${prod.price}</td>
								<td align="left">${prod.regDate}</td>
								<td align="left" id="${prod.market.marketNo}">
									<a style="color:#4285F4">
										${prod.market.marketName}
									</a>
								</td>
								<td align="left" id="${prod.prodStock}">
									<c:if test="${prod.prodStock <= 0}">
										재고없음
									</c:if>
									<c:if test="${prod.prodStock > 0}">
										<c:if test="${menu != 'manage' || menu != 'bsns'}">
											<c:if test="${prod.prodStock <= 5}">
												<b style="color:red;">품절임박</b> 
											</c:if>
											<c:if test="${prod.prodStock > 5}">
												<b style="color:green;">판매중</b>
											</c:if>
										</c:if>
										<c:if test="${menu == 'manage' || menu == 'bsns'}">
											재고 : ${prod.prodStock} 개 남음
										</c:if>
									</c:if>
								</td>	
							</tr>
						</c:forEach>
						<tr>
							<td colspan="6"z bgcolor="D6D7D6" height="1"></td>
						</tr>
					</table>
				
					<!-- PageNavigation Start... -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="pageNavi table" style="margin-top:10px;">
						<tr>
							<td align="center">
							   <input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage }"/>
								${resultPage.paging}
					    	</td>
						</tr>
					</table>
					<!-- PageNavigation End... -->
				</div>	
			</div>
			</form>
		</div>
		<!-- Article -->
		
		<!-- Footer -->
		<footer>
			<jsp:include page="/layout/footer.jsp"></jsp:include>
		</footer>
		<!-- Footer -->
		
	</body>
</html>