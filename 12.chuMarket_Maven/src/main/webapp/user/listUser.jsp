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
<html>

	<!-- header -->
	<header>
		<jsp:include page="/layout/header.jsp"></jsp:include>
	</header>
	<!-- header -->
	
	<!-- Script -->
	<script type="text/javascript">
		$(function() 
		{
			/* ########################## Style ########################## */	
			$(".ct_btn01").css('cursor', 'pointer');
			$(".pageNavi > tbody > tr > td > a").css('cursor', 'pointer');
			$(".ct_list_pop > td:nth-child(2)").css('cursor', 'pointer');
			/* ########################## Style ########################## */	
			
			/* ########################## User ########################## */
			$( ".ct_btn01:contains('검색')" ).on("click" , function() 
		 	{
				//Debug..
				//alert(  $( ".ct_btn01:contains('검색')" ) );
				fncGetList(1);
			}); 
			
			$(".pageNavi > tbody > tr > td > a").on("click" , function() 
		 	{
				fncGetList($(this).attr('id'));
			}); 
			
			$(".ct_list_pop > td:nth-child(2)").on("click" , function() 
			{
				//Debug..
				//alert(  $( ".ct_list_pop > td:nth-child(3)" ) + " 회원정보조회" );
		 		$(window.location).attr("href","/user/getUser?userId="+$(this).text().trim());
			}); 
			/* ########################## User ########################## */
		});
	</script>
	<!-- Script -->
	
	<body bgcolor="#ffffff" text="#000000">
	
		<!-- Article -->
		<div style="width:98%; margin-left:10px;">
			<form name="detailForm" action="/user/listUser" method="post">
			<div class="table-container">
				<table class="table" width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td background="/images/ct_ttl_img02.gif" width="100%">
							<b>회원 목록조회</b>
						</td>
					</tr>
				</table>
				
				<div class="container is-max-desktop" >
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td align="right">
								<div class="select">
								  <select name="searchCondition" class="ct_input_g" style="height:40px">
								    <option 
										value="0" ${! empty search.searchCondition && search.searchCondition == 0 ? "selected" : "" }>
										회원ID
									</option>
									<option 
										value="1" ${! empty search.searchCondition && search.searchCondition == 1 ? "selected" : "" }>
										회원명
									</option>
								  </select>
								</div>
								<input type="text" name="searchKeyword"  value="${search.searchKeyword }" 
									class="ct_input_g input" style="width:200px; height:40px" >
							</td>
							<td align="right" width="70">
								<button class="button ct_btn01" style="height:40px">검색</button>
							</td>
						</tr>
					</table>
				
					<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0" >
						<tr>
							<td colspan="11" >전체 <span style="color:red;">${resultPage.totalCount}</span> 건수, 현재 <span style="color:red;">${resultPage.currentPage}</span> 페이지</td>
						</tr>
						<tr>
							<th align="center" class="ct_list_b" width="100">No</th>
							<th align="center" class="ct_list_b" width="150">회원ID</th>
							<th align="center" class="ct_list_b" width="150">회원명</th>
							<th align="center" class="ct_list_b">이메일</th>		
						</tr>
							<c:set var="i" value="0"/>
							<c:forEach var="user" items="${list}">
								<c:set var="i" value="${ i+1 }" />
								<tr class="ct_list_pop">
									<td align="center">${i}</td>
									<td align="center">
										<a id="${user.userId}"style="color:#4285F4">
											${user.userId }
										</a>
									</td>
									<td align="center">${user.userName }</td>
									<td align="center">${user.email }
									</td>		
								</tr>
							</c:forEach>
						<tr>
							<td colspan="4" bgcolor="D6D7D6" height="1"></td>
						</tr>
					</table>
				</div>
				
				<!-- PageNavigation Start... -->
				<table class="table pageNavi" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
					<tr>
						<td align="center">
						   <input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage }"/>
							${resultPage.paging}
				    	</td>
					</tr>
				</table>
				<!-- PageNavigation End... -->
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