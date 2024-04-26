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
			var detailForm = $("form[name=detailForm]");
			
			/* ########################## Style ########################## */	
			$(".ct_btn01").css('cursor', 'pointer');
			/* ########################## Style ########################## */	
			
			
			/* ########################## Market ########################## */
			$( ".ct_btn01:contains('������û')" ).on("click" , function() 
		 	{
				////////// ������û Ŭ�� �� //////////
				//Form ��ȿ�� ����
			 	var name  = $("#marketName");
				var intro = $("#marketIntro");
				var addr  = $("#marketAddr");
	
				if(name.val() == null || name.val().length<1)
				{
					alert("��ȣ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
					name.focus();
					return;
				}
				if(intro.val() == null || intro.val().length<1)
				{
					alert("�Ұ��� �ݵ�� �Է��Ͽ��� �մϴ�.");
					intro.focus();
					return;
				}
				if(addr.val() == null || addr.val().length<1)
				{
					alert("����� �ּҴ� �ݵ�� �Է��ϼž� �մϴ�.");
					addr.focus();
					return;
				}
				
				detailForm.attr('action','/market/addMarket').submit();
			}); 
			
			$( ".ct_btn01:contains('���')" ).on("click" , function() 
			{
				if($(this).text().trim() == '���')
				{
					detailForm.each(function()
					{
						this.reset();
					});
				}else
				{
					 if (!confirm("��� ���� �� ������ �ʱ�ȭ�Ǹ�, ���û �� �ٽ� �ۼ��ϼž� �մϴ�. \n����Ͻðڽ��ϱ�?")) 
					 {
						 
					 } else 
					 {
						detailForm.attr('action','/market/deleteMarket?marketNo=${market.marketNo}').submit();
					 }
				}
			});
			
			$( ".ct_btn01:contains('����')" ).on("click" , function() 
			{
				history.go(-1);
			});
			/* ########################## Market ########################## */
		});
	</script>
	<!-- Script -->

	<body bgcolor="#ffffff" text="#000000">
		
		<!-- Article -->
		<form name="detailForm" method="post">
		<input type="hidden" name="userId" value="${userInfo.userId}"/>
			<div class="table-container">
				<table class="table" width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td background="/images/ct_ttl_img02.gif" width="100%">
							<b>������û</b>
						</td>
					</tr>
				</table>
				<div class="container is-max-desktop" style="align:center;" >
					<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 13px;">
						<c:if test="${!empty market}">
							<tr>
								<td height="1" colspan="3" bgcolor="D6D6D6"></td>
							</tr>
							<tr>
								<td width="130" class="ct_write">
									��û��ȣ
									<imgsrc="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle">
								</td>
								<td class="ct_write01">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="105">
												${market.marketNo}
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</c:if>
						<tr>
							<td width="130" class="ct_write">
								��û�� ���̵� 
								<imgsrc="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle">
							</td>
							<td class="ct_write01">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="105">
											${userInfo.userId}
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">
								��ȣ�� 
								<imgsrc="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle">
							</td>
							<td class="ct_write01">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<c:if test="${!empty market}">
											<td width="105">
												${market.marketName}
											</td>
										</c:if>
										<c:if test="${empty market}">
											<td width="105">
												<input type="text" name="marketName" id="marketName" class="ct_input_g input" style="width: 130px; height: 30px" maxLength="20">
											</td>
										</c:if>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">
								�Ұ� 
								<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<c:if test="${!empty market}">
											<td width="105">
												${market.marketIntro}
											</td>
										</c:if>
										<c:if test="${empty market}">
											<td width="105">
												<textarea class="ct_input_g textarea" id="marketIntro" name="marketIntro" ></textarea>
											</td>
										</c:if>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">
								����� �ּ� 
								<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<c:if test="${!empty market}">
											<td width="105">
												${market.marketAddr}
											</td>
										</c:if>
										<c:if test="${empty market}">
											<td width="105">
												<input type="text" id="marketAddr" name="marketAddr" class="ct_input_g input" style="width: 300px; height: 30px" maxLength="10" minLength="6"/>
											</td>
										</c:if>
									</tr>
								</table>
							</td>
						</tr>
						<c:if test="${!empty market }">
							<tr>
								<td width="130" class="ct_write">
									��û ��Ȳ
									<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
								</td>
								<td class="ct_write01">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<c:if test="${market.manaFlag == 'W'}">
												<td width="105">
													���� �����
												</td>
											</c:if>
											<c:if test="${market.manaFlag == 'Y'}">
												<td width="105">
													���οϷ� [��������]
												</td>
											</c:if>
											<c:if test="${market.manaFlag == 'F'}">
												<td width="105">
													�������� [���� �Ұ���]
												</td>
											</c:if>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="1" colspan="3" bgcolor="D6D6D6"></td>
							</tr>
						</c:if>
					</table>
					<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
						<tr>
							<td width="53%"></td>
							<td align="right">
							<table border="0" cellspacing="0" cellpadding="0">
								<c:if test="${!empty market }">
									<tr>
										<td style="float:right;"><a class="button ct_btn01" style="height:40px;">�������</a></td>	
										<td style="float:right;"><a class="button ct_btn01" style="height:40px;">����</a></td>	
									</tr>
								</c:if>
								<c:if test="${empty market }">
									<tr>
										<td style="float:right;"><a class="button ct_btn01" style="height:40px;">������û</a></td>	
										<td style="float:right;"><a class="button ct_btn01" style="height:40px;">���</a></td>	
									</tr>
								</c:if>
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