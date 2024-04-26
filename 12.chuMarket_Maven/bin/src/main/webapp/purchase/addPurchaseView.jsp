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
				
			
			/* ########################## User ########################## */	
			$( ".ct_btn01:contains('����')" ).on("click" , function() 
			{
				fncAddPurchase();
			});
			
			$( ".ct_btn01:contains('���')" ).on("click" , function() 
			{
				history.go(-1);
			});
			
		});	
		
		function fncAddPurchase() 
		{
			var count = document.addPurchase.tranStock.value;
			if(count == "" || count < 0)
			{
				alert("�ּ� 1�� ���Ÿ� �ؾ��մϴ�!");
				document.addPurchase.tranStock.focus();
				return;
			}
			
			document.addPurchase.submit();
		}
		
		function checkStock(value)
		{
			if(value > ${prod.prodStock})
			{
				alert('���� ${prod.prodStock}�� ���� ������ �� �ֽ��ϴ�!!');	
				document.addPurchase.tranStock.value= ${prod.prodStock};
			}
		}
	</script>
	<!-- Script -->
	
	<body>
	
		<!-- Article -->
		<form name="addPurchase" method="post" action="/purchase/addPurchase">
		<input type="hidden" name="prodNo"	value="${prod.prodNo}" />
		<input type="hidden" name="buyerId" value="${userInfo.userId}" />
			<div class="table-container">
				<table class="table" width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
					<tr>
						<td background="/images/ct_ttl_img02.gif" width="100%">
							<b>��ǰ����</b>
						</td>
					</tr>
				</table>
			
				<div class="container is-max-desktop" style="align:center;" >
					<table class="table" width="600" border="0" cellspacing="0" cellpadding="0" align="center" style="margin-top: 13px;">
						<tr>
							<td width="104" class="ct_write">
								��ǰ��ȣ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01" width="299">${prod.prodNo}</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">
								��ǰ�� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">${prod.prodName}</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">
								��ǰ������ <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">${prod.prodDetail}</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">��������</td>
							<td class="ct_write01">${prod.manuDate}</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">����</td>
							<td class="ct_write01">${prod.price}</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">�������</td>
							<td class="ct_write01">${prod.regDate}</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">
								�����ھ��̵� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">${userInfo.userId}</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">���Ź��</td>
							<td class="ct_write01">
								<div class="select is-small">
									<select name="paymentOption" class="ct_input_g" 
											style="width: 150px; height: 30px" maxLength="20">
										<option value="1" selected="selected">���ݱ���</option>
										<option value="2">�ſ뱸��</option>
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">�������̸�</td>
							<td class="ct_write01">
								<input type="text" name="receiverName" 	class="ct_input_g input" 
									style="width: 150px; height: 30px" maxLength="20" value="${userInfo.userName}" />
							</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">�����ڿ���ó</td>
							<td class="ct_write01">
								<input type="text" name="receiverPhone" class="ct_input_g input" 
									style="width: 150px; height: 30px" maxLength="20" value="${userInfo.phone}" />
							</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">�������ּ�</td>
							<td class="ct_write01">
								<input type="text" name="divyAddr" class="ct_input_g input" 
									style="width: 150px; height: 30px" maxLength="20" 	value="${userInfo.addr}" />
							</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">���ſ�û����</td>
							<td class="ct_write01">
								<input type="text" name="divyRequest" 	class="ct_input_g input" 
									style="width: 150px; height: 30px" maxLength="20" />
							</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">����������</td>
							<td width="200" class="ct_write01">
								<input type="text" readonly="readonly" name="divyDate" class="ct_input_g input"  
									style="width: 150px; height: 30px" maxLength="20"/>
								<img 	src="../images/ct_icon_date.gif" width="15" height="15"	
									onclick="show_calendar('document.addPurchase.divyDate', document.addPurchase.divyDate.value)"/>
							</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">���� ����</td>
							<td class="ct_write01">
								<input type="text" name="tranStock" id="tranStock" class="ct_input_g input" style="width: 150px; height: 30px" maxLength="20" 
									onkeyup="javascript:checkStock(this.value);" value="1"/> ��
								<br>
								�� ���ڸ� �Է� / �ִ� ${prod.prodStock}������ ���� ����
							</td>
						</tr>
						<tr>
							<td height="1" colspan="3" bgcolor="D6D6D6"></td>
						</tr>
					</table>
				
					<table class="table"  width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="53%"></td>
							<td align="center">
								<table border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td><a class="button ct_btn01" style="height:40px">����</a></td>
										<td><a class="button ct_btn01" style="height:40px">���</a></td>				
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