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
								<b>���� �����ȸ</b>
							</td>
						</tr>
					</table>
					<div class="container is-max-desktop" style="align:center;" >
						<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
							<tr>
								<td colspan="13" >��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>
							</tr>
							<tr>
								<th class="ct_list_b" width="30">No</th>
								<th class="ct_list_b" width="90">��ü��ȣ</th>
								<th class="ct_list_b" width="*">��ȣ��</th>
								<th class="ct_list_b" width="*">�Ұ�</th>
								<th class="ct_list_b" width="*">ȸ�����̵�</th>
								<th class="ct_list_b" width="*">���� ������</th>	
								<th class="ct_list_b">�������</th>	
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
											���� �����
											&nbsp;
											<a id="${market.manaFlag}" style="color:#4285F4">����</a>
										</c:if>
										<c:if test="${market.manaFlag == 'Y'}">
											���� �Ϸ�
											&nbsp;
											<a id="${market.manaFlag}" style="color:#4285F4">��������</a>							
										</c:if>
										<c:if test="${market.manaFlag == 'F'}">
											���� ����
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
