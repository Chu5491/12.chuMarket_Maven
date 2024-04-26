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
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
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
		$( ".ct_btn01:contains('����')" ).on("click" , function() 
	 	{
	 		$(window.location).attr("href","/user/updateUser?userId=${user.userId }");
		}); 
		/* ########################## User ########################## */
		
		
		
		/* ########################## History ########################## */
		$( ".ct_btn01:contains('Ȯ��')" ).on("click" , function() 
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
						<b>ȸ��������ȸ</b>
					</td>
				</tr>
			</table>
			
			<div class="container is-max-desktop" style="align:center;" >
				<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:13px;">
					<tr>
						<td width="130" class="ct_write">
							���̵� <img src="/images/ct_icon_red.gif" width="5" height="3" align="absmiddle"/>
						</td>
						<td class="ct_write01">${user.userId}</td>
					</tr>
					<tr>
						<td width="130" class="ct_write">
							�̸� <img src="/images/ct_icon_red.gif" width="5" height="3" align="absmiddle"/>
						</td>
						<td class="ct_write01">${user.userName}</td>
					</tr>
					<tr>
						<td width="104" class="ct_write">�ּ�</td>
						<td class="ct_write01">${user.addr }</td>
					</tr>
					<tr>
						<td width="130" class="ct_write">�޴���ȭ��ȣ</td>
						<td class="ct_write01">${user.phone}</td>
					</tr>
					<tr>
						<td width="130" class="ct_write">�̸��� </td>
						<td class="ct_write01">${user.email }</td>
					</tr>
					<tr>
						<td width="130" class="ct_write">��������</td>
						<td class="ct_write01">${user.regDate }</td>
					</tr>
				</table>
		
				<table class="table"  width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
					<tr>
						<td width="53%"></td>
						<td align="right">
							<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><button class="button ct_btn01" style="height:40px">����</button></td>
									<td><button class="button ct_btn01" style="height:40px">Ȯ��</button></td>				
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