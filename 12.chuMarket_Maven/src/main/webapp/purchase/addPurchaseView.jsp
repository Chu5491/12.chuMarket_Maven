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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
			$( ".ct_btn01:contains('구매')" ).on("click" , function() 
			{
				fncAddPurchase();
			});
			
			$( ".ct_btn01:contains('취소')" ).on("click" , function() 
			{
				history.go(-1);
			});
			
		});	
		
		function fncAddPurchase() 
		{
			var count = document.addPurchase.tranStock.value;
			if(count == "" || count < 0)
			{
				alert("최소 1개 구매를 해야합니다!");
				document.addPurchase.tranStock.focus();
				return;
			}
			
			document.addPurchase.submit();
		}
		
		function checkStock(value)
		{
			if(value > ${prod.prodStock})
			{
				alert('현재 ${prod.prodStock}개 까지 구매할 수 있습니다!!');	
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
							<b>상품구매</b>
						</td>
					</tr>
				</table>
			
				<div class="container is-max-desktop" style="align:center;" >
					<table class="table" width="600" border="0" cellspacing="0" cellpadding="0" align="center" style="margin-top: 13px;">
						<tr>
							<td width="104" class="ct_write">
								상품번호 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01" width="299">${prod.prodNo}</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">
								상품명 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">${prod.prodName}</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">
								상품상세정보 <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">${prod.prodDetail}</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">제조일자</td>
							<td class="ct_write01">${prod.manuDate}</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">가격</td>
							<td class="ct_write01">${prod.price}</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">등록일자</td>
							<td class="ct_write01">${prod.regDate}</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">
								구매자아이디 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">${userInfo.userId}</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">구매방법</td>
							<td class="ct_write01">
								<div class="select is-small">
									<select name="paymentOption" class="ct_input_g" 
											style="width: 150px; height: 30px" maxLength="20">
										<option value="1" selected="selected">현금구매</option>
										<option value="2">신용구매</option>
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">구매자이름</td>
							<td class="ct_write01">
								<input type="text" name="receiverName" 	class="ct_input_g input" 
									style="width: 150px; height: 30px" maxLength="20" value="${userInfo.userName}" />
							</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">구매자연락처</td>
							<td class="ct_write01">
								<input type="text" name="receiverPhone" class="ct_input_g input" 
									style="width: 150px; height: 30px" maxLength="20" value="${userInfo.phone}" />
							</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">구매자주소</td>
							<td class="ct_write01">
								<input type="text" name="divyAddr" class="ct_input_g input" 
									style="width: 150px; height: 30px" maxLength="20" 	value="${userInfo.addr}" />
							</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">구매요청사항</td>
							<td class="ct_write01">
								<input type="text" name="divyRequest" 	class="ct_input_g input" 
									style="width: 150px; height: 30px" maxLength="20" />
							</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">배송희망일자</td>
							<td width="200" class="ct_write01">
								<input type="text" readonly="readonly" name="divyDate" class="ct_input_g input"  
									style="width: 150px; height: 30px" maxLength="20"/>
								<img 	src="../images/ct_icon_date.gif" width="15" height="15"	
									onclick="show_calendar('document.addPurchase.divyDate', document.addPurchase.divyDate.value)"/>
							</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">구매 수량</td>
							<td class="ct_write01">
								<input type="text" name="tranStock" id="tranStock" class="ct_input_g input" style="width: 150px; height: 30px" maxLength="20" 
									onkeyup="javascript:checkStock(this.value);" value="1"/> 개
								<br>
								※ 숫자만 입력 / 최대 ${prod.prodStock}개까지 구매 가능
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
										<td><a class="button ct_btn01" style="height:40px">구매</a></td>
										<td><a class="button ct_btn01" style="height:40px">취소</a></td>				
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