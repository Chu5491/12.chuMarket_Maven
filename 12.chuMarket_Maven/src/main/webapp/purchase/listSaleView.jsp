<%
	/***************************************************
	*	작성자 : 추경운
	*	작성일 : 2024-03-31
	*	내  용 : 기존의 FrameSet 형식을 
	*			 header / article / footer 
	*			 jspInclude 방식으로 수정 
	*			 Bulma Css FrameWork 적용에 따른
	*			 페이지 UI 수정
	*	
	*	주  의 : 해당 페이지는 팝업창에서 작동됨
	*			 다른 페이지와 코드의 차이가 존재
	****************************************************/
%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Script -->
<link href="/css/bulma.min.css" rel="stylesheet" type="text/css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/javascript/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	$(function() 
	{
		var menu = '${menu}';
		
		/* ########################## Style ########################## */	
		$(".ct_btn01").css('cursor', 'pointer');
		$(".pageNavi > tbody > tr > td > a").css('cursor', 'pointer');
		$(".ct_list_pop > td:nth-child(1)").css('cursor', 'pointer');
		$(".ct_list_pop > td:nth-child(2)").css('cursor', 'pointer');
		$(".ct_list_pop > td:nth-child(7) > a").css('cursor', 'pointer');
		/* ########################## Style ########################## */	
	
		
		/* ########################## User ########################## */
		$(".ct_list_pop > td:nth-child(1)").on("click" , function() 
		{
	 		$(window.location).attr("href","/purchase/getPurchase?tranNo="+$(this).attr('id'));
		}); 
		/* ########################## User ########################## */
		
		
		/* ########################## Product ########################## */
		$(".ct_list_pop > td:nth-child(2)").on("click" , function() 
		{
	 		$(window.location).attr("href","/user/getUser?userId="+$(this).text().trim());
		}); 
		/* ########################## Product ########################## */
		
		
		/* ########################## Purchase ########################## */
		$(".ct_list_pop > td:nth-child(7) > a").on("click" , function() 
		{
	 		$(window.location).attr("href","/purchase/updateTranCode?tranNo="+$(this).attr('id')+"&menu=sale");
		}); 
		/* ########################## Purchase ########################## */
	});
</script>
<!-- Script -->

<!DOCTYPE html>
<html>
	<head>
		<title>구매 목록조회</title>
		<meta charset="euc-kr">
		<link rel="stylesheet" href="/css/admin.css" type="text/css">
	</head>

	<body bgcolor="#ffffff" text="#000000">
	
		<!-- Article -->
		<div style="width: 98%; margin-left: 10px;">
			<form name="detailForm" action="/purchase/listPurchase" method="post">
				<table class="table" width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-top: 12px;">
							<b>구매 목록조회</b>
						</td>
					</tr>
				</table>
				<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
					<tr>
						<th class="ct_list_b" width="100">No</th>
						<th class="ct_list_b" width="150">회원ID</th>
						<th class="ct_list_b" width="150">회원명</th>
						<th class="ct_list_b">전화번호</th>
						<th class="ct_list_b">구매수량</th>
						<th class="ct_list_b">배송현황</th>
						<th class="ct_list_b">정보수정</th>
					</tr>
					<c:if test="${! empty list }">
						<c:forEach var="pur" items="${list}">
						<c:set var="i" value="${i+1}"/>
							<tr class="ct_list_pop">
								<td align="left" id="${pur.tranNo}">
									<a style="color:#4285F4">
										${i}
									</a>
								</td>
								<td align="left">
									<a style="color:#4285F4">
										${pur.buyer.userId}
									</a>
								</td>
								<td align="left">
									${pur.buyer.userName}
								</td>
								<td align="left">${pur.receiverPhone}</td>
								<td align="left">${pur.tranStock} 개</td>
								<td align="left">
									<c:if test="${pur.tranCode == '1'}">
										판매완료
									</c:if>
									<c:if test="${pur.tranCode == '2'}">
										배송중
									</c:if>
									<c:if test="${pur.tranCode == '3'}">
										배송완료
									</c:if>
								</td>
								<td align="left">
									<c:if test="${pur.tranCode == '1'}">
										<a id="${pur.tranNo}" style="color:#4285F4" >
								  			배송하기
								  		</a>
									</c:if>
								</td>
							</tr>
						</c:forEach>
						<tr>
							<td colspan="7" bgcolor="D6D7D6" height="1"></td>
						</tr>
					</c:if>
					<c:if test="${empty list }">
						<tr>
							<td colspan="7" height="3" align="center"><h3>현재 상품은 구매 정보가 없습니다!</h3></td>
						</tr>
					</c:if>
				</table>
			</form>
		</div>
		<!-- Article -->
	</body>
</html>