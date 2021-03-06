<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인커뮤니티 자유게시판</title>
	<link rel="stylesheet" href="resources/css/layout/font.css">
	<link rel="stylesheet" href="resources/css/layout/basic.css">
	<link rel="stylesheet" href="resources/css/layout/btn.css">
	<link rel="stylesheet" href="resources/css/layout/loginout.css">
	<link rel="stylesheet" href="resources/css/layout/nav.css">
	<link rel="stylesheet" href="resources/css/layout/table.css">
	<link rel="stylesheet" href="resources/css/layout/searchbox.css">
<style>
	#paging_wrap span, td {
		cursor: pointer;
	}
	
	table {
		text-align: center;
	}
	
	td img {
		width: 15px;
	}
	#searchBtn:hover , #addBtn:hover{
		background-color: #e3ecfb;
	}
</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script>
	$(document).ready(function() {
		if("${param.searchGbn}" != "") {
			$("#searchGbn").val("${param.searchGbn}");
		}
		reloadList();
		
		// 로그인
		$("#login").on("click",function(){
		    $("#loginForm").attr("action","login");
		    $("#loginForm").submit();
		});
		      
		// 로그아웃
		$("#logout").on("click", function(){
		    $("#loginForm").attr("action","logout");
		    $("#loginForm").submit();
		});
		
		// 마이페이지
		$("#mypage").on("click", function(){
			$("#loginForm").attr("action","myPage");
			$("#loginForm").submit();
		});
		
		// 관리자페이지
		$("#mgrpage").on("click", function(){
			$("#loginForm").attr("action","mgrPage");
			$("#loginForm").submit();
		});
		
		// 검색버튼
		$("#searchBtn").on("click", function() {
			$("#oldTxt").val($("#searchTxt").val());
			$("#page").val("1");
			reloadList();
		});
		
		// 작성버튼
		$("#addBtn").on("click", function() {
			$("#searchTxt").val($("#oldTxt").val());
			$("#actionForm").attr("action", "freeAdd");		// freeAdd 컨트롤러 추가
			$("#actionForm").submit();
		});
		
		// paging
		$("#paging_wrap").on("click", "span", function() {
			$("#page").val($(this).attr("page"));
			$("#searchTxt").val($("#oldTxt").val());
			reloadList();
		});
		
		// 검색버튼 엔터 방지 (url뒤에 # 안뜨면 정상)
		$("#searchTxt").on("keypress", function(event) {
			if(event.keyCode == 13) {
				$("#searchBtn").click();
				return false;
			}
		});
		
		// 상세보기
		$("tbody").on("click", "tr", function() {
			$("#no").val($(this).attr("no"));
			$("#searchTxt").val($("#oldTxt").val());
			$("#actionForm").attr("action", "freeDtl");		// freeDtl 컨트롤러 추가
			$("#actionForm").submit();
		});
		
	}); // doc end
	
	// 데이터 취득용 func
	function reloadList() {
		var params = $("#actionForm").serialize();
		
		$.ajax({					
			url: "freeLists",		// freeLists 컨트롤러 생성 (RequestMapping, ResponseBody)
			type: "post",			
			data: params,			
			dataType: "json",		
			success: function(res) {
				drawList(res.list);
				drawPaging(res.pb);
			},
			error: function(request, status, error) {
				console.log(error);
			}
		});
	};
	
	// list func
	function drawList(list) {
		var html = "";
		
		for(var data of list) {
			html += "<tr no=\"" + data.FREE_NO + "\">  ";
			html += "<td>" + data.FREE_NO + "</td>   	";
			html += "<td>" + data.CATEGORY_NM + "</td>  	";
			html += "<td>";
			html += data.FREE_TITLE;
			
			if(data.FREE_FILE != null) {
				html += "<img src=\"resources/images/file.png\" />";
			}
			
			html +=  "</td>	";
			html += "<td>" + data.MEM_NM + "</td>	";
			html += "<td>" + data.FREE_DT + "</td> 	";
			html += "<td>" + data.FREE_HIT + "</td> 	";
			html += "</tr>               			";
		}
		$("tbody").html(html);
	};
	
	// paging func
	function drawPaging(pb) {
		var html = "";
		
		html += "<span page=\"1\">[처음]</span>	";
		if($("#page").val() == "1") {
			html += "<span page=\"1\">[이전]</span>	";
		} else {
			html += "<span page=\"" + ($("#page").val() * 1 - 1) + "\">[이전]</span>	";
		} 
		for(var i=pb.startPcount; i<=pb.endPcount; i++) {
			if($("#page").val() == i) {
				html += "<span page=\"" + i + "\"><b>" + i + "</b></span>	";
			} else {
				html += "<span page=\"" + i + "\">" + i + "</span>	";
			}
		}
		if($("#page").val() == pb.maxPcount) {
			html += "<span page=\"" + pb.maxPcount + "\">[다음]</span>	";
		} else {
			html += "<span page=\"" + ($("#page").val() * 1 + 1) + "\">[다음]</span>	";
		}
		html += "<span page=\"" + pb.maxPcount + "\">[마지막]</span>	";
		
		$("#paging_wrap").html(html);
	};

</script>
</head>
<body>
<form action="#" id="loginForm">
	<input type="hidden" id="mem_no" name="mem_no" value="${sMNo}">
</form>

<header>
	<jsp:include page="../header.jsp" flush="true" />
</header>
<main>
<jsp:include page="../nav.jsp" flush="true" />
	<h2>자유게시판 목록</h2>
<%-- 	
	<div>
		<c:choose>
			<c:when test="${empty sMId}">
				<input type="button" value="로그인" id="loginBtn" />
			</c:when>
			<c:otherwise>
				<b>${sMNm}님</b> 어서오세요 :)
				<input type="button" value="로그아웃" id="logoutBtn" />
			</c:otherwise>
		</c:choose>
	</div> --%>

	<div>
		<form action="#" id="actionForm" method="post">
			<select id="categoryno" name="categoryno">
				<option value="0">[자유수다]</option>
				<option value="1">[용병구해요]</option>
				<option value="2" selected>[전체]</option>
			</select>
			<select id="searchGbn" name="searchGbn">
				<option value="0">작성자</option>
				<option value="1">제목</option>
			</select>
			<input type="text" id="searchTxt" name="searchTxt" value="${param.searchTxt}" />
			<input type="hidden" id="oldTxt" value="${param.searchTxt}" />
			<input type="hidden" id="page" name="page" value="${page}" />
			<input type="hidden" id="no" name="no" />
			<input type="button" value="검색" id="searchBtn" />
			<c:if test="${!empty sMId}">
				<input type="button" value="글작성" id="addBtn" />
			</c:if>
		</form>
	</div><br><br>
	
	<div>
		<table class="notice_table">
			<thead>
				<tr class="nonetr">
					<th>번호</th>
					<th>말머리</th>
					<th class="title">제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div><br><br>
	
	<div id="paging_wrap"></div>
	</main>
<footer>
	<jsp:include page="../footer.jsp" flush="true" />
</footer>

<script type="text/javascript" src="resources/css/js/header.js"></script>
</body>
</html>