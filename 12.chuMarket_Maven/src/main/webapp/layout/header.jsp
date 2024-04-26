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
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
	<head>
		<title>Model2 MVC Shop</title>
		<link href="/css/bulma.min.css" rel="stylesheet" type="text/css">
		<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="/javascript/jquery-2.1.4.min.js"></script>
		<script type="text/javascript" src="/javascript/calendar.js"></script>
		<script type="text/javascript" src="/javascript/common.js"></script>
		<script type="text/javascript">
			$(function() 
			{
				/* ########################## Style ########################## */	
				$(".Depth03").css('cursor', 'pointer');
				/* ########################## Style ########################## */	
				
				/* ########################## Main ########################## */
				$( ".Depth03:contains('Model2 MVC Shop')" ).on("click" , function() 
			 	{
			 		$(window.parent.document.location).attr("href","/");
				}); 
				/* ########################## Main ########################## */
				
				
			 	/* ########################## login / logout ########################## */	
			 	$( ".Depth03:contains('Log in')" ).on("click" , function() 
			 	{
			 		$(document.location).attr("href","/user/loginView.jsp");
				}); 
				
				$( ".Depth03:contains('Sign up')" ).on("click" , function() 
			 	{
			 		$(document.location).attr("href","/user/addUser");
				}); 
				
				$( ".Depth03:contains('LogOut')" ).on("click" , function() 
			 	{
			 		$(window.location).attr("href","/user/logout");
				}); 
			 	/* ########################## login / logout ########################## */	

				/* ########################## History ########################## */	
				$( ".Depth03:contains('최근 본 상품')" ).on("click" , function() 
			 	{
					 popWin = window.open("/history.jsp","popWin","left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
				});
				/* ########################## History ########################## */	
				
				/* ########################## userInfo########################## */		 
			 	$( ".Depth03:contains('개인정보조회')" ).on("click" , function() 
			 	{
					$(window.location).attr("href","/user/getUser?userId=${userInfo.userId}");
				});
				
			 	$( ".Depth03:contains('회원정보조회')" ).on("click" , function() 
			 	{
			 		$(window.location).attr("href","/user/listUser");
				}); 
			 	/* ########################## userInfo ########################## */	
			 	
			 	/* ########################## Product ########################## */	

			 	$( ".Depth03:contains('판매상품등록')" ).on("click" , function() 
			 	{
			 		$(window.location).attr("href","/product/addProductView.jsp");
				}); 

				var role = "${userInfo.role}";
			 	if(role == "bsns")
			 	{
			 		$( ".Depth03:contains('판매상품관리')" ).on("click" , function() 
			 		{
				 		$(window.location).attr("href","/market/getMarket?marketNo=${bsnsMarket.marketNo}&menu=bsns");
					}); 
			 	}else
			 	if(role == "admin")
				$( ".Depth03:contains('판매상품관리')" ).on("click" , function() {
			 		$(window.location).attr("href","/product/listProduct?menu=manage");
				}); 
			 	
			 	/* ########################## Product ########################## */	
			 	
			 	/* ########################## Purchase ########################## */	
			 	$( ".Depth03:contains('구매이력조회')" ).on("click" , function() 
			 	{
			 		$(window.location).attr("href","/purchase/listPurchase");
				}); 
			 	/* ########################## Purchase ########################## */	
			 	
			 	/* ########################## Market ########################## */	
			 	$( ".Depth03:contains('입점 문의')" ).on("click" , function() 
			 	{
			 		$(window.location).attr("href","/market/addMarket");
				}); 
			 	
			 	$( ".Depth03:contains('입점 신청 조회')" ).on("click" , function() 
			 	{
			 		$(window.location).attr("href","/market/listMarket");
				}); 
			 	/* ########################## Market ########################## */	
			});	
		</script>
	</head>

	<body topmargin="0" leftmargin="0">
		<nav class="navbar" role="navigation" aria-label="main navigation">
			<div class="navbar-brand">
				<h1 class="navbar-item Depth03 title">Model2 MVC Shop</h1>
				<a role="button" class="navbar-burger" aria-label="menu" aria-expanded="false" data-target="navbarBasicExample">
					<span aria-hidden="true"></span>
					<span aria-hidden="true"></span>
					<span aria-hidden="true"></span>
					<span aria-hidden="true"></span>
					<span aria-hidden="true"></span>
					<span aria-hidden="true"></span>
					<span aria-hidden="true"></span>
					<span aria-hidden="true"></span>
					<span aria-hidden="true"></span>
				</a>
			</div>
		
			<div id="navbarBasicExample" class="navbar-menu">
				<div class="navbar-start">
					<c:if test="${userInfo.role == 'admin'}">
						<a class="navbar-item Depth03">
							회원정보조회
						</a>
					</c:if>
					<c:if test="${userInfo.role == 'admin'|| userInfo.role == 'bsns'}">
						<a class="navbar-item Depth03">
							판매상품등록
						</a>
						<a class="navbar-item Depth03">
							판매상품관리
						</a>
					</c:if>
					<c:if test="${!empty userInfo}">
						<c:if test="${userInfo.role == 'user'}">
							<a class="navbar-item Depth03">
								구매이력조회
							</a>
						</c:if>
					</c:if>
					<div class="navbar-item has-dropdown is-hoverable">
						<a class="navbar-link">
							More
						</a>
				
						<div class="navbar-dropdown">
							<c:if test="${!empty userInfo}">
								<a class="navbar-item Depth03">
									개인정보조회
								</a>
							</c:if>
							<a class="navbar-item Depth03">
								최근 본 상품
							</a>
							<c:if test="${!empty userInfo}">
								<hr class="navbar-divider">
							</c:if>
							<a class="navbar-item Depth03">
								<c:if test="${!empty userInfo}">
									
									<c:if test="${userInfo.role == 'user' || userInfo.role == 'bsns'}">
										<a class="navbar-item Depth03">
											입점 문의
										</a>
									</c:if>
									<c:if test="${userInfo.role == 'admin'}">
										
										<a class="navbar-item Depth03">
											입점 신청 조회
										</a>
									</c:if>
								</c:if>
							</a>
						</div>
					</div>
				</div>
				<c:if test="${userInfo == null}">
					<div class="navbar-end">
						<div class="navbar-item">
							<div class="buttons">
								<a class="button is-primary Depth03">
									Sign up
								</a>
								<a class="button is-light Depth03">
									Log in
								</a>
							</div>
						</div>
					</div>
				</c:if>
				<c:if test="${userInfo != null}">
					<div class="navbar-end">
						<h1 class="navbar-item subtitle"><b>${userInfo.userName}</b>  님 환영합니다.</h1>
					</div>
					<div class="buttons">
						<a class="button is-primary Depth03">
							LogOut
						</a>
					</div>
				</c:if>
			</div>
		</nav>
	</body>
</html>
