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
	<!-- Header -->
	<header>
		<jsp:include page="/layout/header.jsp"></jsp:include>
	</header>
	<!-- Header -->
	
	<!-- Script -->
	<script type="text/javascript" src="../javascript/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	$(function() 
	{
		/* ########################## Style ########################## */	
		$(".ct_btn01").css('cursor', 'pointer');
		/* ########################## Style ########################## */	
		
		
		/* ########################## User ########################## */
		$( ".ct_btn01:contains('수정')" ).on("click" , function() 
	 	{
	 		$(window.location).attr("href","/user/updateUser?userId=${user.userId }");
		}); 
		/* ########################## User ########################## */
		
		
		
		/* ########################## History ########################## */
		$( ".ct_btn01:contains('확인')" ).on("click" , function() 
	 	{
			history.go(-1);
		}); 
		/* ########################## History ########################## */
	});
	</script>
	<!-- Script -->
	
	<body bgcolor="#ffffff" text="#000000">
	
		<!-- Article -->
		<div class="table-container">
			<table class="table"  width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td background="/images/ct_ttl_img02.gif" width="100%">
						<b>회원정보조회</b>
					</td>
				</tr>
			</table>
			
			<div class="container is-max-desktop" style="align:center;" >
				<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:13px;">
					<tr>
						<td width="130" class="ct_write">
							아이디 <img src="/images/ct_icon_red.gif" width="5" height="3" align="absmiddle"/>
						</td>
						<td class="ct_write01">${user.userId}</td>
					</tr>
					<tr>
						<td width="130" class="ct_write">
							이름 <img src="/images/ct_icon_red.gif" width="5" height="3" align="absmiddle"/>
						</td>
						<td class="ct_write01">${user.userName}</td>
					</tr>
					<tr>
						<td width="104" class="ct_write">주소</td>
						<td class="ct_write01">${user.addr }</td>
					</tr>
					<tr>
						<td width="130" class="ct_write">휴대전화번호</td>
						<td class="ct_write01">${user.phone}</td>
					</tr>
					<tr>
						<td width="130" class="ct_write">이메일 </td>
						<td class="ct_write01">${user.email }</td>
					</tr>
					<tr>
						<td width="130" class="ct_write">가입일자</td>
						<td class="ct_write01">${user.regDate }</td>
					</tr>
				</table>
		
				<table class="table"  width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
					<tr>
						<td width="53%"></td>
						<td align="right">
							<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><button class="button ct_btn01" style="height:40px">수정</button></td>
									<td><button class="button ct_btn01" style="height:40px">확인</button></td>				
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<!-- Article -->
		
		<!-- Footer -->
		<footer>
			<jsp:include page="/layout/footer.jsp"></jsp:include>
		</footer>
		<!-- Footer -->
	</body>
</html>