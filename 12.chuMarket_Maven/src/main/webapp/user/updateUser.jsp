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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
			$(".ct_btn01:contains('수정')").on("click" , function() 
		 	{
				var name = $("input[name=userName]").val();
				var detailForm = $("form[name=detailForm]");
				if(name == null || name.length <1)
				{
					alert("이름은 반드시 입력하셔야 합니다.");
					return;
				}
					
				if($("input[name=phone2]").val() != "" && $("input[name=phone2]").val() != "") 
				{
					$("input[name=phone]").val($("select[name=phone1]").val() + "-" + $("input[name=phone2]").val() + "-" + $("input[name=phone3]").val());
				}else
				{
					alert("전화번호는 반드시 입력하셔야 합니다.");
					$("input[name=phone2]").focus();
					return;
				}
				
				$("form").attr('action','/user/updateUser').submit();
				
			}); 
			
			$(".ct_btn01:contains('취소')").on("click" , function() 
		 	{
				history.go(-1);
			}); 
			/* ########################## User ########################## */
		});
	</script>
	<!-- Script -->
	
	<body bgcolor="#ffffff" text="#000000">
		
		<!-- Article -->
		<form name="detailForm"  method="post" >
		<input type="hidden" name="userId" value="${user.userId}">
		
			<div class="table-container">
				<table class="table" width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td background="/images/ct_ttl_img02.gif" width="100%" style="padding:7 0 10 10px; margin:0 0 10 0px">
							<b>회원정보수정</b>
						</td>
					</tr>
				</table>
				<div class="container is-max-desktop" style="align:center;" >
					<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:13px;">
						<tr>
							<td width="130" class="ct_write">
								아이디 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle">
							</td>
							<td class="ct_write01">${user.userId}</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">
								이름 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle">
							</td>
							<td class="ct_write01">
								<input type="text" name="userName" value="${user.userName}" class="ct_input_g input" 
											style="width:100px; height:30px"  maxLength="50" >
							</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">주소</td>
							<td class="ct_write01">
								<input type="text" name="addr" value="${user.addr}" class="ct_input_g input" 
											style="width:370px; height:30px"  maxLength="100">
							</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">휴대전화번호</td>
							<td class="ct_write01">
								<div class="select is-small">
									<select name="phone1" class="ct_input_g"  
													onChange="document.detailForm.phone2.focus();">
										<option value="010" ${ ! empty user.phone1 && user.phone1 == "010" ? "selected" : ""  } >010</option>
										<option value="011" ${ ! empty user.phone1 && user.phone1 == "011" ? "selected" : ""  } >011</option>
										<option value="016" ${ ! empty user.phone1 && user.phone1 == "016" ? "selected" : ""  } >016</option>
										<option value="018" ${ ! empty user.phone1 && user.phone1 == "018" ? "selected" : ""  } >018</option>
										<option value="019" ${ ! empty user.phone1 && user.phone1 == "019" ? "selected" : ""  } >019</option>
									</select>
								</div>
								-
								<input 	type="text" name="phone2" value="${ ! empty user.phone2 ? user.phone2 : ''}" 
												class="ct_input_g input" style="width:100px; height:30px"  maxLength="9" >
								- 
								<input 	type="text" name="phone3" value="${ ! empty user.phone3 ? user.phone3 : ''}"  
												class="ct_input_g input"  style="width:100px; height:30px"  maxLength="9" >
								<input type="hidden" name="phone" class="ct_input_g"/>
							</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">이메일 </td>
							<td class="ct_write01">
								<input 	type="text" name="email" value="${user.email}" class="ct_input_g input" 
												style="width:300px; height:30px;" onChange="check_email(this.form);">
							</td>
						</tr>
					</table>
					<table class="table"  width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
						<tr>
							<td width="53%"></td>
							<td align="right">
								<table border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td><a class="button ct_btn01" style="height:40px">수정</a></td>
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
