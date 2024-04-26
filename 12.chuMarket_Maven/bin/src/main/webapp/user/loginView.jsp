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
<%@ page contentType="text/html; charset=euc-kr" %>
<html>
	<!-- Header -->
	<header>
		<jsp:include page="/layout/header.jsp"></jsp:include>
	</header>
	<!-- Header -->
	
	<!-- Script -->
	<script type="text/javascript">
	
		//엔터 시 submit 이벤트
		document.addEventListener("DOMContentLoaded", function()
		{
		  var inputFields = document.querySelectorAll('.ct_input_g');
	
			inputFields.forEach(function(inputField) 
			{
				inputField.addEventListener("keypress", function(event) 
				{
					if (event.key === "Enter") 
					{
						fncLogin();
					}
				});
			});
		});
		
		$(function() 
		{
			/* ########################## Style ########################## */	
			$("img[src='/images/btn_add.gif']").css('cursor', 'pointer');
			$("img[src='/images/btn_login.gif']").css('cursor', 'pointer');
			/* ########################## Style ########################## */
			
			
			
			//==> 추가된부분 : "addUser"  Event 연결
			$("img[src='/images/btn_login.gif']").on("click" , function() 
			{
				fncLogin(); 
			});
			
			//==> 추가된부분 : "addUser"  Event 연결
			$("img[src='/images/btn_add.gif']").on("click" , function() 
			{
				self.location = "/user/addUser"
			});
		});
	
		function fncLogin() 
		{
			var id=document.loginForm.userId.value;
			var pw=document.loginForm.password.value;
			if(id == null || id.length <1) 
			{
				alert('ID 를 입력하지 않으셨습니다.');
				document.loginForm.userId.focus();
				return;
			}
			
			if(pw == null || pw.length <1) 
			{
				alert('패스워드를 입력하지 않으셨습니다.');
				document.loginForm.password.focus();
				return;
			}
			
			$.ajax
			({
				url : "/user/json/login",
				method : "POST" ,
				dataType : "json" ,
				headers : 
				{
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				data : JSON.stringify({
					userId : id,
					password : pw
				}),
				success : function(JSONData , status) 
				{
					//Debug...
					//alert(status);
					//alert("JSONData : \n"+JSONData);
					//alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(JSONData) );
					//alert( JSONData != null );
					
					if( JSONData != null )
					{
						//[방법1]
						//$(window.parent.document.location).attr("href","/index.jsp");
						
						//[방법2]
						//window.parent.document.location.reload();
						
						//[방법3]
						$(document.location).attr("href","/");
						
						//==> 방법 1 , 2 , 3 결과 학인
					}else
					{
						alert("아이디 , 패스워드를 확인하시고 다시 로그인...");
					}
				}
			}); 
		}
	</script>
	<!-- Script -->
	
	<!-- Article -->
	<body bgcolor="#ffffff" text="#000000" >
		<div class="container is-max-desktop" style="align:center;" >
			<br><br><br><br><br><br>
			<form name="loginForm"  method="post" action="/user/login" target="_parent">
				<div align="center">
					<table WITH="100%" HEIGHT="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
						<tr>
							<td ALIGN="CENTER" VALIGN="MIDDLE">
							
							<table width="650" height="390" border="5" cellpadding="0" cellspacing="0" bordercolor="#D6CDB7">
							  <tr> 
							    <td width="10" height="5" align="left" valign="top" bordercolor="#D6CDB7">
							    	<table width="650" height="390" border="0" cellpadding="0" cellspacing="0">
							        	<tr>
							          		<td width="305">
							           			<img src="/images/logo-spring.png" width="305" height="390">
							          		</td>
									        <td width="345" align="left" valign="top" background="/images/login02.gif">
									          	<table width="100%" height="220" border="0" cellpadding="0" cellspacing="0">
									                <tr> 
										                <td width="30" height="100">&nbsp;</td>
										                <td width="100" height="100">&nbsp;</td>
										                <td height="100">&nbsp;</td>
										                <td width="20" height="100">&nbsp;</td>
									                </tr>
									                <tr> 
										                <td width="30" height="50">&nbsp;</td>
										                <td width="100" height="50">
									                		<img src="/images/text_login.gif" width="91" height="32">
									              	    </td>
									                	<td height="50">&nbsp;</td>
									                	<td width="20" height="50">&nbsp;</td>
									                </tr>
									                <tr> 
									                	<td width="200" height="50" colspan="4"></td>
									                </tr>              
									                <tr> 
										                <td width="30" height="30">&nbsp;</td>
										                <td width="100" height="30">
										                	<img src="/images/text_id.gif" width="100" height="30">
										                </td>
										                <td height="30">
										                  <input 	type="text" name="userId"  class="ct_input_g" 
										                  				style="width:180px; height:19px"  maxLength='50'/>          
										          		</td>
										                <td width="20" height="30">&nbsp;</td>
									                </tr>
									                <tr> 
										                <td width="30" height="30">&nbsp;</td>
										                <td width="100" height="30">
										                	<img src="/images/text_pas.gif" width="100" height="30">
										                </td>
										                <td height="30">                    
										                    <input 	type="password" name="password" class="ct_input_g" style="width:180px; height:19px"  maxLength="50" >
										                </td>
										                <td width="20" height="30">&nbsp;</td>
									                </tr>
									                <tr> 
									                	<td width="30" height="20">&nbsp;</td>
									                	<td width="100" height="20">&nbsp;</td>
									               		<td height="20" align="center">
									      					<table width="136" height="20" border="0" cellpadding="0" cellspacing="0">
									                            <tr> 
										                            <td width="56">
										                            	<img src="/images/btn_login.gif" width="56" height="20" border="0">
										                            </td>
										                            <td width="10">&nbsp;</td>
										                            <td width="70">
										                            	<img src="/images/btn_add.gif" width="70" height="20" border="0">
										                            </td>
									                            </tr>
									                    </table>
									                  </td>
									                  <td width="20" height="20">&nbsp;</td>
									                  </tr>
									            </table>
									       </td>
							       		</tr>	                            
							      	</table>
							      </td>
							    </tr>
							</table>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</body>
	<!-- Article -->
	
	<!-- Footer -->
	<footer>
		<jsp:include page="/layout/footer.jsp"></jsp:include>
	</footer>
	<!-- Footer -->
</html>

<script type="text/javascript">
	document.loginForm.userId.focus();
</script>
