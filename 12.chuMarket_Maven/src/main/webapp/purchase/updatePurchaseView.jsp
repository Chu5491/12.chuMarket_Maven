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
	<script>
		function checkStock(value)
		{
			if(value > ${pur.purchaseProd.prodStock + pur.tranStock})
			{
				alert('현재 ${pur.purchaseProd.prodStock + pur.tranStock}개 까지 구매할 수 있습니다!!');	
				document.updatePurchase.tranStock.value= ${pur.purchaseProd.prodStock + pur.tranStock};
			}
		}
	</script>
	<!-- Script -->
	
	<body bgcolor="#ffffff" text="#000000">
		
		<!-- Article -->
		<form name="updatePurchase" method="post" action="/purchase/updatePurchase?tranNo=${pur.tranNo}">
			<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="15" height="37">
						<img src="/images/ct_ttl_img01.gif"  width="15" height="37"/>
					</td>
					<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">구매정보수정</td>
								<td width="20%" align="right">&nbsp;</td>
							</tr>
						</table>
					</td>
					<td width="12" height="37">
						<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
					</td>
				</tr>
			</table>
		
			<table width="600" border="0" cellspacing="0" cellpadding="0"	align="center" style="margin-top: 13px;">
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">구매자아이디</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						${pur.buyer.userId}
					</td>
					<input type="hidden" name="buyerId" value="${pur.buyer.userId}">
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">구매방법</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<select name="paymentOption" class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20">
							<option value="1" ${paymentOption == "1" ? 'selected' : ''}>현금구매</option>
							<option value="2" ${paymentOption == "2" ? 'selected' : ''}>신용구매</option>
						</select>
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">구매자이름</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="text" name="receiverName" 	class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${pur.receiverName}" />
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">구매자 연락처</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="text" name="receiverPhone" class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${pur.receiverPhone}" />
					</td>
				</tr>
			
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">구매자주소</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="text" name="divyAddr" class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${pur.divyAddr}" />
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">구매요청사항</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="text" name="divyRequest" 	class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${pur.divyRequest}" />
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">배송희망일자</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td width="200" class="ct_write01">
						<input type="text" readonly="readonly" name="divyDate" class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20" value="${pur.divyDate}">
						<img src="../images/ct_icon_date.gif" width="15" height="15"	
							onclick="show_calendar('document.updatePurchase.divyDate','document.updatePurchase.divyDate.value')"/>
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">구매 수량</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="text" name="tranStock" id="tranStock" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20" 
							onkeyup="javascript:checkStock(this.value);" value="${pur.tranStock }"/> 개
						<br><br>
						※ 숫자만 입력 / 최대 ${pur.purchaseProd.prodStock + pur.tranStock}개까지 구매 가능
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
			</table>
		
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
				<tr>
					<td width="53%"></td>
					<td align="right">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
								<input type="submit" value="수정"/>
							</td>
							<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
							</td>
							<td width="30"></td>
							<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
								<a href="javascript:history.go(-1)">취소</a>
							</td>
							<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
							</td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
		</form>
		<!-- Article -->
		
		<!-- Footer -->
		<footer>
			<jsp:include page="/layout/footer.jsp"></jsp:include>
		</footer>
		<!-- Footer -->
	</body>
</html>