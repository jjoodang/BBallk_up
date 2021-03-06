<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀별 공지사항 상세보기</title>
	<link rel="stylesheet" href="resources/css/layout/font.css">
	<link rel="stylesheet" href="resources/css/layout/basic.css">
	<link rel="stylesheet" href="resources/css/layout/btn.css">
	<link rel="stylesheet" href="resources/css/layout/loginout.css">
	<link rel="stylesheet" href="resources/css/layout/nav.css">
	<link rel="stylesheet" href="resources/css/layout/table.css">
	<link rel="stylesheet" href="resources/css/layout/searchbox.css">
	<link rel="stylesheet" href="resources/css/layout/T_board.css">
	
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	// 알림용
	/* alert("팀번호 : " + "${param.tno}");
	alert("팀이름 : " + "${param.tnm}"); */
	
	$("#listBtn").on("click", function(){
		$("#actionForm").attr("action", "T_notice");
		$("#actionForm").submit();
	});
	
	$("#updateBtn").on("click", function(){
		$("#actionForm").attr("action", "T_noticeUpdate");
		$("#actionForm").submit();
	});
	
	
	/* $("#tab2").on("click", function(){
		$("#actionForm").attr("action", "T_notice");
		$("#actionForm").submit();
	}); */
	$("#tab4").on("click", function(){
		if(confirm("페이지를 벗어나시겠습니까?")){
			$("#actionForm").attr("action", "tFreeList");
			$("#actionForm").submit();
		}
	});
	/* $("#tab1").on("click", function(){
		$("#actionForm").attr("action", "T_teammozip");
		$("#actionForm").submit();
	}); */
	$("#tab3").on("click", function(){
		if(confirm("페이지를 벗어나시겠습니까?")){
			$("#actionForm").attr("action", "T_oneline");
			$("#actionForm").submit();
		}
	});
	
	$("#deleteBtn").on("click", function(){
		if(confirm("삭제하시겠습니까?")){
			var params = $("#actionForm").serialize();
			
			$.ajax({ 
				url: "T_noticeDeletes",
				type: "post", 
				dataType: "json", 
				data: params, 
				success: function(res){ 
					if(res.result == "success"){
						history.back();
						
					}else if(res.result == "failed"){
						alert("삭제에 실패하였습니다.");
					}else{
						alert("삭제중 문제가 발생했습니다.");
					}
				},
				error: function(request, status, error){
					console.log(error);
				}
			});
		}
	});
});
</script>
</head>
<body>
<header>
	<jsp:include page="../header.jsp" flush="true" />
</header>
<main>
<jsp:include page="../nav.jsp" flush="true" />
<div class="tabcontent">
<div>
	<h2>${param.tnm}</h2>
	<p>${sMNm}님 안녕하세요. ${param.tnm} 커뮤니티 입니다 :)</p>
</div>
<div class="bigtab">
	<jsp:include page="../T_board.jsp" flush="true" />
<div class="righttab">
<h2>팀 공지사항</h2>
	<form action="#" id="loginForm" method="post">
		<input type="hidden" name="mem_no" value="${sMNo}">
	</form>
	<form action="#" id="actionForm" method="post">
		<input type="hidden" id="mno" name="mno" value="${param.mno}" />
		<input type="hidden" name="searchGbn" value="${param.searchGbn}" />
		<input type="hidden" name="searchTxt" value="${param.searchTxt}" />
		<input type="hidden" name="page" value="${param.page}" />
		<input type="hidden" name="no" value="${param.no}" />
		<input type="hidden" name="tno" value="${param.tno}" />
		<input type="hidden" id="tnm" name="tnm" value="${param.tnm}" />
	</form>
	<div>
		<table class="notice_table2">
			<thead>
				<tr>
					<th>${data.TB_NO} </th>
					<th class="title">${data.TB_TITLE}</th>
					<th>${data.MEM_NM}</th>
					<th>${data.TB_DT}</th>
					<th>${data.TB_HIT}</th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="divcon">
		<div>
			<br/>
			${data.TB_CON}
		</div>
		<c:if test="${!empty data.TB_FILE}">
			<div>
				<br><br>
				<hr>
				<c:set var="len" value="${fn:length(data.TB_FILE)}"></c:set>
				첨부파일 : 
				<a href="resources/upload/${fn:replace(fn:replace(data.TB_FILE, '[', '%5B'), ']', '%5D')}" download="${fn:substring(data.TB_FILE, 20, len)}">
				${fn:substring(data.TB_FILE, 20, len)}
				</a>
			</div>
		</c:if>
		<div class="buttondiv">
			<c:choose>
				<c:when test="${sMNo eq data.MEM_NO}">
					<input type="button" value="수정" id="updateBtn" />
					<input type="button" value="삭제" id="deleteBtn" />
					<input type="button" value="목록" id="listBtn" />
				</c:when>
				<c:otherwise>
					<input type="button" value="목록" id="listBtn" />
				</c:otherwise>
			</c:choose>
		</div>
	</div>
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