<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.paging_wrap span {
	   cursor: pointer;
	}
	
	td img{
		width : 15px;
	}
</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	if("${param.searchGbn}" != ""){
		$("#searchGbn").val("${param.searchGbn}");
	}
	
	reloadList();
	
	//글작성
	$("#addBtn").on("click", function(){
		
		$("#searchTxt").val($("#oldTxt").val());
		
		$("#actionForm").attr("action", "testABAdd");
		$("#actionForm").submit();
	});
	//로그인
	$("#loginBtn").on("click", function(){
		location.href = "m1Login";
	});
	//로그아웃
	$("#logoutBtn").on("click", function(){
		location.href = "m1Logout";
	});
	//검색
	$("#searchBtn").on("click", function(){
		$("#oldTxt").val($("#searchTxt").val());
		$("#page").val("1");
		
		reloadList();
	});
	
	$("#searchTxt").on("keypress", function(){
		if(event.keyCode == 13){
			$("#searchBtn").click();
			return false;
		}
	});
	
	$(".paging_wrap").on("click", "span", function(){
		
		$("#page").val($(this).attr("page"));
		$("#searchTxt").val($("#oldTxt").val());
		
		reloadList();
	});
	
	$("tbody").on("click", "tr", function(){
		
		$("#no").val($(this).attr("no"));
		
		$("#actionForm").attr("action", "myBoard");
		$("#actionForm").submit();
	});
	
});

//데이터 취득
function reloadList(){

	var params = $("#actionForm").serialize(); // form의 데이터를 문자열로 변환
	
	$.ajax({	//jquery의 ajax 함수 호출
		url : "myBoardListAjax",	// 접속
		type : "post",			// 전송방식
		dataType : "json",		// 받아올 데이터의 형태
		data : params,			// 보낼 데이터(문자열 형태)
		success : function(res){// 성공(ajax통신성공)시 다음 함수 발생
			drawList(res.list);
			drawPaging(res.pb);
		},
		error : function(request, status, error){// 실패시 다음 함수 발생
			console.log(error);
		}
	});
}

//목록 그리기
function drawList(list){
	var html = "";
	
	for(var data of list){
		
		html += "<tr no=\"" + data.NO + "\">           ";
		html += "<td>" + data.NO + "</td>     ";
		html += "<td>" + data.TEAM_NM + "</td>     ";
		html += "<td>" + data.TBM_NM + "</td>     ";
		html += "<td>";
		html += data.TITLE;

		if(data.B_FILE != null){
			
			html += "<img src=\"resources/images/attFile.png\">";
		}
		
		html += "</td>  ";
		html += "<td>" + data.DT + "</td>  ";
		html += "<td>" + data.HIT + "</td>     ";
		html += "</tr>          ";
	}
	
	$("tbody").html(html);
}

function drawPaging(pb){
	var html = "";
	
	html += "<span page=\"1\">처음</span>       ";
	
	if($("#page").val() == "1"){
		
		html += "<span page=\"1\">이전</span>       ";	
	}else{
		html += "<span page=\"" + ($("#page").val() * 1 - 1) + "\">이전</span>       ";
	}
	
	for(var i = pb.startPcount ; i <= pb.endPcount; i++){
		if($("#page").val() == i){
			html += "<span page=\"" + i + "\"><b>" + i + "</b></span>  ";
		}else{
			html += "<span page=\"" + i + "\">" + i + "</span>  ";
		}
	}
	
	if($("#page").val() == pb.maxPcount){
		html += "<span page=\"" + pb.maxPcount + "\">다음</span>       ";
	}else{
		html += "<span page=\"" + ($("#page").val() * 1 + 1) + "\">다음</span>       ";
	}
	
	
	html += "<span page=\"" + pb.maxPcount + "\">마지막</span>      ";
	
	$(".paging_wrap").html(html);
}
</script>
</head>
<body>
<div>
	<form action="#" id="actionForm" method="post">
		<input type="hidden" name="mem_no" id="mem_no" value="${sMNo}">
		<select name="searchBoardGbn" id="searchBoardGbn">
			<option value="0">전체</option>
			<option value="1">개인커뮤니티</option>
			<option value="2">팀커뮤니티</option>
		</select>
		<select name="searchGbn" id="searchGbn">
			<option value="0">제목</option>
			<option value="1">제목+내용</option>
		</select>
		<input type="text" name="searchTxt" id="searchTxt" value="${param.searchTxt }" >
		<input type="hidden" name="oldTxt" id="oldTxt" value="${param.searchTxt }" >
		<input type="hidden" name="page" id="page" value="${page}">
		<input type="hidden" name="no" id="no">
		<input type="button" value="검색" id="searchBtn">
		<c:if test="${!empty sMNo}">
			<input type="button" value="작성" id="addBtn">
		</c:if>
	</form>
</div>
<div>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>커뮤니티</th>
				<th>게시판명</th>
				<th>제목</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
</div>
<div class="paging_wrap">
</div>
</body>
</html>








