<%
	/***************************************************
	*	�ۼ��� : �߰��
	*	�ۼ��� : 2024-03-31
	*	��  �� : ������ FrameSet ������ 
	*			 header / article / footer 
	*			 jspInclude ������� ���� 
	*			 Bulma Css FrameWork ���뿡 ����
	*			 ������ UI ����
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
				$( ".Depth03:contains('�ֱ� �� ��ǰ')" ).on("click" , function() 
			 	{
					 popWin = window.open("/history.jsp","popWin","left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
				});
				/* ########################## History ########################## */	
				
				/* ########################## userInfo########################## */		 
			 	$( ".Depth03:contains('����������ȸ')" ).on("click" , function() 
			 	{
					$(window.location).attr("href","/user/getUser?userId=${userInfo.userId}");
				});
				
			 	$( ".Depth03:contains('ȸ��������ȸ')" ).on("click" , function() 
			 	{
			 		$(window.location).attr("href","/user/listUser");
				}); 
			 	/* ########################## userInfo ########################## */	
			 	
			 	/* ########################## Product ########################## */	

			 	$( ".Depth03:contains('�ǸŻ�ǰ���')" ).on("click" , function() 
			 	{
			 		$(window.location).attr("href","/product/addProductView.jsp");
				}); 

				var role = "${userInfo.role}";
			 	if(role == "bsns")
			 	{
			 		$( ".Depth03:contains('�ǸŻ�ǰ����')" ).on("click" , function() 
			 		{
				 		$(window.location).attr("href","/market/getMarket?marketNo=${bsnsMarket.marketNo}&menu=bsns");
					}); 
			 	}else
			 	if(role == "admin")
				$( ".Depth03:contains('�ǸŻ�ǰ����')" ).on("click" , function() {
			 		$(window.location).attr("href","/product/listProduct?menu=manage");
				}); 
			 	
			 	/* ########################## Product ########################## */	
			 	
			 	/* ########################## Purchase ########################## */	
			 	$( ".Depth03:contains('�����̷���ȸ')" ).on("click" , function() 
			 	{
			 		$(window.location).attr("href","/purchase/listPurchase");
				}); 
			 	/* ########################## Purchase ########################## */	
			 	
			 	/* ########################## Market ########################## */	
			 	$( ".Depth03:contains('���� ����')" ).on("click" , function() 
			 	{
			 		$(window.location).attr("href","/market/addMarket");
				}); 
			 	
			 	$( ".Depth03:contains('���� ��û ��ȸ')" ).on("click" , function() 
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
							ȸ��������ȸ
						</a>
					</c:if>
					<c:if test="${userInfo.role == 'admin'|| userInfo.role == 'bsns'}">
						<a class="navbar-item Depth03">
							�ǸŻ�ǰ���
						</a>
						<a class="navbar-item Depth03">
							�ǸŻ�ǰ����
						</a>
					</c:if>
					<c:if test="${!empty userInfo}">
						<c:if test="${userInfo.role == 'user'}">
							<a class="navbar-item Depth03">
								�����̷���ȸ
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
									����������ȸ
								</a>
							</c:if>
							<a class="navbar-item Depth03">
								�ֱ� �� ��ǰ
							</a>
							<c:if test="${!empty userInfo}">
								<hr class="navbar-divider">
							</c:if>
							<a class="navbar-item Depth03">
								<c:if test="${!empty userInfo}">
									
									<c:if test="${userInfo.role == 'user' || userInfo.role == 'bsns'}">
										<a class="navbar-item Depth03">
											���� ����
										</a>
									</c:if>
									<c:if test="${userInfo.role == 'admin'}">
										
										<a class="navbar-item Depth03">
											���� ��û ��ȸ
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
						<h1 class="navbar-item subtitle"><b>${userInfo.userName}</b>  �� ȯ���մϴ�.</h1>
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
