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
			$( ".ct_btn01:contains('�˻�')" ).on("click" , function() 
		 	{
				//Debug..
				//alert(  $( ".ct_btn01:contains('�˻�')" ) );
				fncGetList(1);
			}); 
			
			$(".pageNavi > tbody > tr > td > a").on("click" , function() 
		 	{
				fncGetList($(this).attr('id'));
			}); 
			
			$(".ct_list_pop > td:nth-child(2)").on("click" , function() 
			{
				//Debug..
				//alert(  $( ".ct_list_pop > td:nth-child(3)" ) + " ȸ��������ȸ" );
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
							<b>ȸ�� �����ȸ</b>
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
										ȸ��ID
									</option>
									<option 
										value="1" ${! empty search.searchCondition && search.searchCondition == 1 ? "selected" : "" }>
										ȸ����
									</option>
								  </select>
								</div>
								<input type="text" name="searchKeyword"  value="${search.searchKeyword }" 
									class="ct_input_g input" style="width:200px; height:40px" >
							</td>
							<td align="right" width="70">
								<button class="button ct_btn01" style="height:40px">�˻�</button>
							</td>
						</tr>
					</table>
				
					<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0" >
						<tr>
							<td colspan="11" >��ü <span style="color:red;">${resultPage.totalCount}</span> �Ǽ�, ���� <span style="color:red;">${resultPage.currentPage}</span> ������</td>
						</tr>
						<tr>
							<th align="center" class="ct_list_b" width="100">No</th>
							<th align="center" class="ct_list_b" width="150">ȸ��ID</th>
							<th align="center" class="ct_list_b" width="150">ȸ����</th>
							<th align="center" class="ct_list_b">�̸���</th>		
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