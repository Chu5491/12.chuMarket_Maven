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
			$(".ct_list_pop > td:nth-child(3) > a").css('cursor', 'pointer');
			$(".ct_list_pop > td:nth-child(7) > a").css('cursor', 'pointer');
			/* ########################## Style ########################## */	
			
			
			/* ########################## Paging ########################## */
			$(".pageNavi > tbody > tr > td > a").on("click" , function() 
		 	{
				fncGetList($(this).attr('id'));
			}); 
			/* ########################## Paging ########################## */
			
			
			/* ########################## Product ########################## */
			$(".ct_list_pop > td:nth-child(3) > a").on("click" , function() 
			{
				var marketNo   = $(this).parent().parent().children('td:eq(1)').text().trim();
				$(window.location).attr("href","/market/getMarket?marketNo="+ marketNo + "&menu=manage");
		 		
			}); 
			
			$(".ct_list_pop > td:nth-child(7) > a").on("click" , function() 
			{
				var marketNo   = $(this).parent().parent().children('td:eq(1)').text().trim();
				var userId 	   = $(this).parent().parent().children('td:eq(1)').attr('id');
				var marketFlag = $(this).attr('id');
				
		 		$(window.location).attr("href","market/updateMarket?marketNo="+ marketNo +"&manaFlag="+ marketFlag +"&userId="+ userId);
			}); 
			/* ########################## Product ########################## */
		});
	</script>
	<!-- Script -->
	
	<body bgcolor="#ffffff" text="#000000">
		
		<!-- Article -->
		<div style="width:98%; margin-left:10px;">
			<form name="detailForm" action="/market/listMarket" method="post">
				<div class="table-container">
					<table class="table" width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td background="/images/ct_ttl_img02.gif" width="100%">
								<b>입점 목록조회</b>
							</td>
						</tr>
					</table>
					<div class="container is-max-desktop" style="align:center;" >
						<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
							<tr>
								<td colspan="13" >전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
							</tr>
							<tr>
								<th class="ct_list_b" width="30">No</th>
								<th class="ct_list_b" width="90">업체번호</th>
								<th class="ct_list_b" width="*">상호명</th>
								<th class="ct_list_b" width="*">소개</th>
								<th class="ct_list_b" width="*">회원아이디</th>
								<th class="ct_list_b" width="*">영업 시작일</th>	
								<th class="ct_list_b">현재상태</th>	
							</tr>
							<c:forEach var="market" items="${list}" >
								<c:set var="i" value="${ i+1 }" />
								<tr class="ct_list_pop">
									<td align="center">${i}</td>
									<td align="left" id="${market.userId}">
										${market.marketNo}
									</td>
									<td align="left">
										<a style="color:#4285F4">${market.marketName}</a>
									</td>
									<td align="left">${market.marketIntro}</td>
									<td align="left">${market.userId}</td>
									<td align="left">${market.openDate }</td>
									<td align="left" >
										<c:if test="${market.manaFlag == 'W'}">
											승인 대기중
											&nbsp;
											<a id="${market.manaFlag}" style="color:#4285F4">승인</a>
										</c:if>
										<c:if test="${market.manaFlag == 'Y'}">
											승인 완료
											&nbsp;
											<a id="${market.manaFlag}" style="color:#4285F4">영업정지</a>							
										</c:if>
										<c:if test="${market.manaFlag == 'F'}">
											영업 정지
										</c:if>
									</td>	
								</tr>
							</c:forEach>
							<tr>
								<td colspan="13" bgcolor="D6D7D6" height="1"></td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="pageNavi table" style="margin-top:10px;">
							<tr>
								<td align="center">
									<input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}"/>
									${resultPage.paging}
						    	</td>
							</tr>
						</table>
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
