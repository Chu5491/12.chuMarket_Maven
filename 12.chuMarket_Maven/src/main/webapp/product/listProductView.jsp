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
			$( ".ct_btn01:contains('�˻�')" ).on("click" , function() 
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
						alert("ǰ���� ��ǰ�Դϴ�.");
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
							<b>${menu =='search' ? '��ǰ �����ȸ' : '��ǰ ����'}</b>
						</td>
					</tr>
				</table>
				
				<div class="container is-max-desktop" >
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td align="right">
								<div class="select">
									<select name="searchCondition" class="ct_input_g" style="height:40px">
										<option value="no" ${! empty search.searchCondition && search.searchCondition == 'no' ? 'selected' : ""}>��ǰ��ȣ</option>
										<option value="name" ${! empty search.searchCondition && search.searchCondition == 'name' ? 'selected' : ""}>��ǰ��</option>
										<option value="price" ${! empty search.searchCondition && search.searchCondition == 'price' ? 'selected' : ""}>��ǰ����</option>
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
											<button class="button ct_btn01" style="height:40px">�˻�</button>
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
							<td colspan="13" >��ü <span style="color:red;">${resultPage.totalCount}</span> �Ǽ�, ���� <span style="color:red;">${resultPage.currentPage}</span> ������</td>
						</tr>
						<tr>
							<th align="center" class="ct_list_b" width="100">No</th>
							<th class="ct_list_b" width="150">��ǰ��</th>
							<th class="ct_list_b" width="150">����</th>
							<th class="ct_list_b">�����</th>	
							<th class="ct_list_b">���θ�</th>	
							<th class="ct_list_b">�������</th>	
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
										������
									</c:if>
									<c:if test="${prod.prodStock > 0}">
										<c:if test="${menu != 'manage' || menu != 'bsns'}">
											<c:if test="${prod.prodStock <= 5}">
												<b style="color:red;">ǰ���ӹ�</b> 
											</c:if>
											<c:if test="${prod.prodStock > 5}">
												<b style="color:green;">�Ǹ���</b>
											</c:if>
										</c:if>
										<c:if test="${menu == 'manage' || menu == 'bsns'}">
											��� : ${prod.prodStock} �� ����
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