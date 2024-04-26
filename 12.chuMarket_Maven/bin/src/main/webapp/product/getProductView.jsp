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
			/* ########################## Style ########################## */	
			$(".ct_btn01").css('cursor', 'pointer');
			/* ########################## Style ########################## */	
			
		
			
			/* ########################## Product ########################## */
			$( ".ct_btn01:contains('����')" ).on("click" , function() 
		 	{
				///purchase/addPurchase?prodNo=${prod.prodNo}"
				$(window.location).attr("href","/purchase/addPurchase?prodNo="+$(this).attr('id'));
				//Debug..
				//alert(  $( ".ct_btn01:contains('�˻�')" ) );
			}); 
			
			$( ".ct_btn01:contains('����')" ).on("click" , function() 
		 	{
				history.go(-1);
			}); 
			/* ########################## Product ########################## */
		});
		
		function readURL(input) 
		{
			if (input.files && input.files[0]) 
			{
				var reader = new FileReader();
				reader.onload = function(e) 
				{
					document.getElementById('preview').src = e.target.result;
			 	};
			 	
				reader.readAsDataURL(input.files[0]);
			}else 
			{
			  document.getElementById('preview').src = "";
			}
		}
	</script>
	<!-- Script -->
	
	<body bgcolor="#ffffff" text="#000000">
		
		<!-- Article -->	
		<form name="detailForm" method="post">
			<div class="table-container">
				<table class="table" width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td background="/images/ct_ttl_img02.gif" width="100%" >
							<b>${ ! empty menu && menu == 'search' ? '��ǰ����ȸ' : '��ǰ����'}</b>
						</td>
					</tr>
				</table>
				<div class="container is-max-desktop" >
					<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 13px;">
						<tr>
							<td height="1" colspan="3" bgcolor="D6D6D6"></td>
						</tr>
						<tr>
							<td width="130" class="ct_write">
								���θ� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">${prod.market.marketName}</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">
								��ǰ��ȣ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">${prod.prodNo}</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">
								��ǰ�� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">${prod.prodName}</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">
								��ǰ�̹��� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">
								<img style="width:350px; height:350px;" src = "/images/uploadFiles/${upload.logiName}"/>								
							</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">
								��ǰ������ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">${prod.prodDetail}</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">��������</td>
							<td class="ct_write01">${prod.manuDate}</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">����</td>
							<td class="ct_write01">${prod.price}</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">���</td>
							<td class="ct_write01">${prod.prodStock}</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">�������</td>
							<td class="ct_write01">${prod.regDate}</td>
						</tr>
						<tr>
							<td colspan="6"z bgcolor="D6D7D6" height="1"></td>
						</tr>
					</table>
				
					<table class="table"  width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="53%"></td>
							<td align="right">
								<table border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td><a class="button ct_btn01"  id="${prod.prodNo}" style="height:40px">����</a></td>
										<td><a class="button ct_btn01" style="height:40px">����</a></td>				
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</form>
		<!-- Article -->
		
		<!-- Footer -->
		<footer>
			<jsp:include page="/layout/footer.jsp"></jsp:include>
		</footer>
		<!-- Footer -->
	</body>
</html>