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

	<body bgcolor="#ffffff" text="#000000">
	
		<!-- Article -->
		<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="15" height="37">
					<img src="/images/ct_ttl_img01.gif"	width="15" height="37"/>
				</td>
				<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="93%" class="ct_ttl01">구매상세조회</td>
							<td width="20%" align="right">&nbsp;</td>
						</tr>
					</table>
				</td>
				<td width="12" height="37">
					<img src="/images/ct_ttl_img03.gif"	width="12" height="37"/>
				</td>
			</tr>
		</table>
	
		<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">
					물품번호 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
				</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="105">
								${pur.tranNo}
							</td>
							<td></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">
					상품명 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
				</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="105">
								${pur.purchaseProd.prodName}
							</td>
							<td></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">
					구매자아이디 
					<img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
				</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">
					${pur.buyer.userId }
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">구매방법</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">
					<c:if test="${! empty pur.paymentOption}">
						${pur.paymentOption == "1" ? '현금구매' : '신용구매'}
					</c:if>
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">구매자이름</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${pur.receiverName}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">구매자연락처</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${pur.receiverPhone}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">구매자주소</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${pur.divyAddr}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">구매요청사항</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${pur.divyRequest}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">배송희망일</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${pur.divyDate}</td>
			</tr>
		
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
		
			<tr>
				<td width="104" class="ct_write">주문일</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${pur.orderDate}</td>
			</tr>
			
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
		
			<tr>
				<td width="104" class="ct_write">구매수량</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${pur.tranStock}</td>
			</tr>
		
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
		</table>
	
		<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
			<tr>
				<td width="53%"></td>
				<td align="right">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
								<a href="/purchase/updatePurchase?tranNo=${pur.tranNo}">수정</a>
							</td>
							<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
							</td>
							<td width="30"></td>
							<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
								<a href="javascript:history.go(-1);">확인</a>
							</td>
							<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif"width="14" height="23"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<!-- Article -->
		
		<!-- Footer -->
		<footer>
			<jsp:include page="/layout/footer.jsp"></jsp:include>
		</footer>
		<!-- Footer -->
				
	</body>
</html>