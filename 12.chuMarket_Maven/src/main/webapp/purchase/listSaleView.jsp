<%
	/***************************************************
	*	�ۼ��� : �߰��
	*	�ۼ��� : 2024-03-31
	*	��  �� : ������ FrameSet ������ 
	*			 header / article / footer 
	*			 jspInclude ������� ���� 
	*			 Bulma Css FrameWork ���뿡 ����
	*			 ������ UI ����
	*	
	*	��  �� : �ش� �������� �˾�â���� �۵���
	*			 �ٸ� �������� �ڵ��� ���̰� ����
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
		<title>���� �����ȸ</title>
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
							<b>���� �����ȸ</b>
						</td>
					</tr>
				</table>
				<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
					<tr>
						<th class="ct_list_b" width="100">No</th>
						<th class="ct_list_b" width="150">ȸ��ID</th>
						<th class="ct_list_b" width="150">ȸ����</th>
						<th class="ct_list_b">��ȭ��ȣ</th>
						<th class="ct_list_b">���ż���</th>
						<th class="ct_list_b">�����Ȳ</th>
						<th class="ct_list_b">��������</th>
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
								<td align="left">${pur.tranStock} ��</td>
								<td align="left">
									<c:if test="${pur.tranCode == '1'}">
										�ǸſϷ�
									</c:if>
									<c:if test="${pur.tranCode == '2'}">
										�����
									</c:if>
									<c:if test="${pur.tranCode == '3'}">
										��ۿϷ�
									</c:if>
								</td>
								<td align="left">
									<c:if test="${pur.tranCode == '1'}">
										<a id="${pur.tranNo}" style="color:#4285F4" >
								  			����ϱ�
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
							<td colspan="7" height="3" align="center"><h3>���� ��ǰ�� ���� ������ �����ϴ�!</h3></td>
						</tr>
					</c:if>
				</table>
			</form>
		</div>
		<!-- Article -->
	</body>
</html>