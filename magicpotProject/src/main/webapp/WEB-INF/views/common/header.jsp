<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- css -->
<link rel="stylesheet" type="text/css"
	href="resources/css/common/header.css">

<link rel="preconnect" href="https://fonts.gstatic.com/%22%3E">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/dd18300701.js"
	crossorigin="anonymous"></script>
<!-- sweetalert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
.wrap {
	border: px solid lightgray;
	width: 1000px;
}

#font {
	color: rgb(116, 152, 107);
	font-size: 30px;
}

/* 아이디/비밀번호 찾기*/
.find {
	margin-top: 10px;
	font-size: 13px;
}

/*아이디, 비밀번호 입력*/
#idPwd {
	width: 250px;
	padding: 5px;
	border-radius: 5px;
	border: 2px solid rgb(116, 152, 107);
}

/* 로그인 버튼 */
#loginbtn1 {
	width: 250px;
	height: 35px;
	color: white;
	background-color: rgb(116, 152, 107);
	margin-top: 30px;
	border-radius: 5px;
	border: none;
}

/* 회원가입 a태그*/
.join {
	font-size: 13px;
}

#member {
	font-size: 13px;
	color: rgb(116, 152, 107);
}

/* TOP버튼, 문의하기 버튼 */
a#MOVE_TOP_BTN {
    position: fixed;
    right: 2%;
    bottom: 50px;
    display: none;
    z-index: 999;
}
#MOVE_REQUEST_BTN{
	position: fixed;
    right: 2%;
    bottom: 110px;
    display: none;
    z-index: 999;
}
#MOVE_REQUEST_BTN_AREA:hover{cursor:pointer;}

</style>
</head>
<body>

	<!-- alertMsg출력 구문 (일회성 메시지) -->
	<c:if test="${ !empty alertMsg }">
		<script>
			swal("Success!", "${alertMsg}", "success");
		</script>
		<c:remove var="alertMsg" scope="session" />
	</c:if>

	<!-- 다인 추가 -->
	<c:if test="${ !empty errorMsg }">
		<script>
			swal("error", "${errorMsg}", "error");
		</script>
		<c:remove var="errorMsg" scope="session" />
	</c:if>

	<!-- 로고 영역 -->
	<div id="header">
		<div id="header_1">
			<a href="${ pageContext.servletContext.contextPath }"><img
				src="resources/images/common/mainLogo.png" alt=""></a>
		</div>

		<!-- 카테고리 영역-->
		<div id="header_2">
			<ul>
				<li><a href="fund.li">펀딩하기</a></li>
				<c:choose>
					<c:when test="${ empty loginUser }">
						<li><a href="" onclick="alertFn1();">프로젝트 올리기</a></li>
						<script>
							function alertFn1(){
								alert("로그인이 필요합니다.");
								// sweetalert 창 바로 닫히는 에러(timer안먹힘 차후 수정할지)
							}		  
	                  	 </script>
					</c:when>
					<c:when test="${ loginUser.status eq 'C' && creator.status eq 'Y' }">
	            		<li id="project"><a href="insert.pro">프로젝트 올리기</a></li>
	                </c:when>
					<c:when test="${ loginUser.status ne 'C' && creator.status eq 'N'}">
						<li><a href="" onclick="alertFn2();">프로젝트 올리기</a></li>
						<script>
							function alertFn2(){
								alert("승인 대기중입니다");	
							}
						</script>
					</c:when>
	                <c:otherwise>
						<li><a href="enrollPage.cre">프로젝트 올리기</a></li>
					</c:otherwise>
				</c:choose>
				<li><a href="guide.me">이용가이드</a></li>
				<li><a href="list.cm">커뮤니티</a></li>
			</ul>
		</div>

		<!-- 검색 영역 -->
		<div id="header_3">
			<form action="search2.pr" id="search_form">
				<div class="input-group mb-3" id="search_text" style="width:240px;">
					<input type="text" style="width:240px;" class="form-control" name="keyword" id="search">
					<div class="input-group-append">
						<button class="btn btn-success" type="submit" id="searchBtn1" style="background-color: rgb(116, 152, 107);"disabled>
							<i class="fas fa-search fa-sm" style="padding: 2px;"></i>
						</button>
					</div>
				</div>
			</form>
		</div>


		<!-- 로그인전/후 영역-->
		<div id="header_4">
			<c:choose>
				<c:when test="${ empty loginUser }">
					<!-- 로그인 전 -->
					<a href="" data-toggle="modal" data-target="#loginModal">로그인</a>
					<h style="color:rgb(116, 152, 107)"> &nbsp |</h>
					<a href="enrollForm.me">회원가입</a>
				</c:when>
				<c:when test="${ !empty loginUser and loginUser.memId ne 'admin'}">
					<!-- 로그인 후 -->
					<b>${ loginUser.memName }</b>
					<h style="color:rgb(116, 152, 107)">님</h>
					<abbr title="마이페이지"><a href="myPage.me" class="afterLogin"><i
							class="fas fa-user fa-2x " style="margin-top: 20px;"></i></a></abbr>
					<abbr title="좋아하는 프로젝트"><a href="like.pr" class="afterLogin"><i
							class="fas fa-heart fa-2x"></i></a></abbr>
					<abbr title="로그아웃"><a href="logout.me" class="afterLogin"><i
							class="fas fa-sign-out-alt fa-2x"></i></a></abbr>
				</c:when>
				<c:when test="${loginUser.memId eq 'admin'}">
					<b>${ loginUser.memName }</b>
					<h style="color:rgb(116, 152, 107)">님</h>
					<abbr title="마이페이지"><a href="myPage.me" class="afterLogin"><i
							class="fas fa-user fa-2x " style="margin-top: 20px;"></i></a></abbr>
					<abbr title="좋아하는 프로젝트"><a href="like.pr" class="afterLogin"><i
							class="fas fa-heart fa-2x"></i></a></abbr>
					<!-- 로그인한 사용자가 관리자일 경우 관리자 페이지로 이동하는 버튼 노출-->
					<abbr title="관리자페이지"><a href="admin.me" class="afterLogin"><i
							class="fas fa-cog fa-2x"></i></i></a></abbr>
					<abbr title="로그아웃"><a href="logout.me" class="afterLogin"><i
							class="fas fa-sign-out-alt fa-2x"></i></a></abbr>
				</c:when>
			</c:choose>
		</div>
	</div>

	<!-- 로그인 모달 -->
	<div class="modal fade" align="center" id="loginModal">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h3 id="font">
						로그인
						</h4>
				</div>

				<form action="login.me" method="post">
					<!-- Modal Body -->
					<div class="modal-body">

						<input id="memId" type="text" name="memId" value=""
							class="form-control mb-2 mr-sm-2" placeholder="아이디를 입력하세요.">
						<br> <br> <input id="memPwd" type="password"
							name="memPwd" class="form-control mb-2 mr-sm-2"
							placeholder="비밀번호를 입력하세요.">
					</div>

					<div class="find">
						<tr>
							<td><input type="checkbox" id="remember_memId" name="remember_memId"> 아이디 저장</td>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<th><a href="fId.me">아이디 찾기 </a> |
							<a href="fPwd.me"> 비밀번호 </a></th>
						</tr>
					</div>

					<div class="join">
						<br>
						<br> 또는 <br>
						<br> 아직 MagicPot 계정이 없으신가요? &nbsp;&nbsp; <a id="member"
							href=""><b>회원가입</b></a>

					</div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="submit" id="loginbtn1" class="btn btn-primary">로그인</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	
	<!-- 검색창에 텍스트 작성시 활성화 -->
	<script >
		
		$(function(){
			$("#search").on('input', function(){
				if($("#search").val()==''){
					$("#searchBtn1").attr("disabled", true);
					
				}else{
					$("#searchBtn1").attr("disabled", false);
				}
			});
		})
		
	</script>
	
	<!-- TOP버튼/문의하기 버튼 -->
	<div id="MOVE_TOP_BTN_AREA" style="position:fixed; bottom:35px; right:30px; z-index:99;"> 
		<a id="MOVE_TOP_BTN" href="#">
		  <img src="resources/images/common/upBtn.png" style="width:60px"> 
		</a>
	</div>
	<div id="MOVE_REQUEST_BTN_AREA" style="position:fixed; bottom:110px; right:30px; z-index:99;"> 
		<a id="MOVE_REQUEST_BTN" onclick="alert('추후 채팅창 연결');">
		  <img src="resources/images/common/requestBtn.png" style="width:60px"> 
		</a>
	</div>
	
	<!-- 스크립트 : TOP버튼/문의하기 버튼 -->
	<script>
	    $(function() {
	        $(window).scroll(function() {
	            if ($(this).scrollTop() > 500) {
	                $('#MOVE_TOP_BTN').fadeIn();
	            } else {
	                $('#MOVE_TOP_BTN').fadeOut();
	            }
	        });
	        $(window).scroll(function() {
	            if ($(this).scrollTop() > 500) {
	            	$('#MOVE_REQUEST_BTN').fadeIn();
	            } else {
	                $('#MOVE_REQUEST_BTN').fadeOut();
	            }
	        });
	        $("#MOVE_TOP_BTN").click(function() {
	            $('html, body').animate({
	                scrollTop : 0
	            }, 400);
	            return false;
	        });
	    });
	</script>


</body>
</html>