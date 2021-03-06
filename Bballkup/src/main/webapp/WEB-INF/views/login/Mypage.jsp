<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
	<link rel="stylesheet" href="resources/css/layout/font.css">
	<link rel="stylesheet" href="resources/css/layout/basic.css">
	<link rel="stylesheet" href="resources/css/layout/btn.css">
	<link rel="stylesheet" href="resources/css/layout/loginout.css">
	<link rel="stylesheet" href="resources/css/layout/nav.css">
	<link rel="stylesheet" href="resources/css/layout/main.css">
	<link rel="stylesheet" href="resources/css/layout/mypage.css">
<style>
.myinfo{
	left: 300px;
    top: 60px;
}
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//엔터키 폼 실행 막기
	$("#loginForm").on("keypress", "input", function(){
		if(event.ketCode == 13){ //엔터키가 눌렸을때
			return false;		 //form실행 이벤트를 하지않음
		}
	});
	//나의 예약 내역
	$(".booking").on("click", function(){
		$("#loginForm").attr("action","myMatchList");
		$("#loginForm").submit();
	});
	//내가 가입한 팀현황
	$(".jointeam").on("click", function(){
		$("#loginForm").attr("action","TeamJoin");
		$("#loginForm").submit();
	});
	//내가 쓴 글 리스트
	$(".mypost").on("click", function(){
		$("#loginForm").attr("action","myBoardList");
		$("#loginForm").submit();
	});
	//회원정보수정
	$(".meminfo").on("click",function(){
		
		$("#gbn").val("u");
		$("#loginForm").attr("action", "pwCheckGo");
		$("#loginForm").submit();
	});
	
	//비밀번호변경
	$(".mypassword").on("click",function(){
		
		$("#gbn").val("pu");
		$("#loginForm").attr("action", "pwCheckGo");
		$("#loginForm").submit();
	});
	
	$("#logout").on("click", function(){
		$("#loginForm").attr("action","logout");
		$("#loginForm").submit();
	});

	$("#mypage").on("click", function(){
		$("#loginForm").attr("action","myPage");
		$("#loginForm").submit();
	});
	
	$("#card").on("click", function(){
		$("#loginForm").attr("action", "myCard");
		$("#loginForm").submit();
	});
	
});
</script>
</head>
<body>

<form action="#" id="loginForm" method="post">
	<input type="hidden" id="mem_no" name="mem_no" value="${sMNo}">
	<input type="hidden" id="mem_nm" name="mem_nm" value="${data.MEM_NM}">
	<input type="hidden" id="mem_phone" name="mem_phone" value="${data.MEM_PHONE}">
	<input type="hidden" id="gbn" name="gbn" value="">
</form>
<header>
	<jsp:include page="../header.jsp" flush="true" />
</header>
<main>
<jsp:include page="../nav.jsp" flush="true" />

<div class="mypage1">
	<div class="myphoto">
	     <img src="resources/images/icon/사진.png">
	</div>
	<div class="myinfo">
	    <div class="myname">
	         <p>${sMNm}</p>
		</div>
		<div class="myphone">
	    	<p>${data.MEM_PHONE}</p>
	    </div>
	    <div class="mycard">
	    	<c:choose>
	    		<c:when test="${data.CARD_NO != null and data.CARD_NO != ''}">
	    			<p>카드가 &nbsp;<span class=blue>등록되어있습니다.</span></p>
	    		</c:when>
	    		<c:otherwise>
	    			<p>카드가 &nbsp;<span class=red>등록되어있지않습니다.</span></p>
	    		</c:otherwise>
	    	</c:choose>
	    </div>
	</div>
</div>
<div class="mypage2">
    <div class="mybuttons1">
        <div class="mybtn booking">
            <img src="resources/images/icon/예약내역조회.png" type="button">
            <p>예약내역조회</p>
        </div>
        <div class="mybtn card" id="card" name="card">
            <img src="resources/images/icon/카드등록.png" type="button">
            <p>카드등록</p>
        </div>
        <div class="mybtn jointeam">
            <img src="resources/images/icon/팀가입현황.png" type="button">
            <p>팀가입현황</p>
        </div>
    </div>
    <div class="mybuttons2">
        <div class="mybtn mypost">
            <img id="myBoardListBtn" src="resources/images/icon/내가쓴게시글.png" type="button">
            <p>내가쓴게시글</p>
        </div>
        <div class="mybtn mypassword">
            <img src="resources/images/icon/패스워드변경.png" type="button">
            <p>패스워드변경</p>
        </div>
        <div class="mybtn meminfo">
            <img src="resources/images/icon/회원정보수정.png" type="button">
            <p>회원정보수정</p>
        </div>
    </div>
</div>
</main>
<footer>
	<jsp:include page="../footer.jsp" flush="true" />
</footer>
<script type="text/javascript" src="resources/css/js/header.js"></script>
</body>
</html>