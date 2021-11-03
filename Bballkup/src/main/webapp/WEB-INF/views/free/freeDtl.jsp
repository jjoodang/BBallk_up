<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="resources/css/layout/font.css">
	<link rel="stylesheet" href="resources/css/layout/basic.css">
	<link rel="stylesheet" href="resources/css/layout/btn.css">
	<link rel="stylesheet" href="resources/css/layout/loginout.css">
	<link rel="stylesheet" href="resources/css/layout/nav.css">
	<link rel="stylesheet" href="resources/css/layout/table.css">
	<link rel="stylesheet" href="resources/css/layout/searchbox.css">
<style>
	.comm_paging {
		cursor: pointer;
	}
	
	.update_con_wrap, #cUpdateBtn2, #cCancelBtn {
		display: none;
	}
	
	.write_con_wrap .write_con, .update_con_wrap .update_con {
		resize: none;
		width: 600px;
		height: 50px;
	}
</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script>
	$(document).ready(function() {
		
		// dtl 부분
		// 상세보기-목록버튼
		$("#listBtn").on("click", function() {
			$("#actionForm").attr("action", "freeList");
			$("#actionForm").submit();
		});
		
		// 상세보기-수정버튼
		$("#updateBtn").on("click", function() {
			$("#actionForm").attr("action", "freeUpdate");	
			$("#actionForm").submit();
		});
		
		// 상세보기-삭제버튼
		$("#deleteBtn").on("click", function() {
			if(confirm("게시글을 삭제하시겠습니까?")) {
				var params = $("#actionForm").serialize();
				
				$.ajax({
					url: "freeDeletes",			
					type: "post",
					dataType: "json",
					data: params,
					success: function(res) {
						if(res.result == "success") {
							location.href = "freeList";
						} else if(res.result == "failed") {
							alert("게시글 삭제에 실패 하였습니다.");
						} else {
							alert("게시글 삭제 중 문제가 발생하였습니다.");
						}
					},
					error: function(request, status, error) {
						console.log(error);
					}
				});
			}
		});
		
		// comment 부분
		// comment-paging 숨김처리
		// alert('${cnt}');
		if('${cnt}' == 0) {
			$(".comm_paging").hide();
		}
		
		// comment-paging
		$(".comm_paging").on("click", "span", function() {
			$("#page").val($(this).attr("page"));
			$("#commListForm").attr("action", "freeDtl");
			$("#commListForm").submit();
		});
		
		// comment-저장버튼
		$("#cAddBtn").on("click", function() {
			if(checkVal("#con")) {
				alert("내용을 입력해주세요.");
				$("#con").focus;
			} else {
				var params = $("#commAddForm").serialize();
				
				$.ajax({
					url: "cfreeAdds",
					type: "post",
					dataType: "json",
					data: params,
					success: function(res){
						if(res.result == "success"){
							alert("댓글이 정상 등록 되었습니다.")
							history.go();
						} else if(res.result == "failed") {
							alert("작성에 실패 하였습니다.")
						} else {
							alert("작성 중 문제가 발생했습니다.")
						}
					},
					error: function(request, status, error){
						console.log(error);
					}
				}); // ajax end
			}
		});
		
		// comment-삭제버튼
		$(".comm_list #cDelBtn").on("click", function() {
			
			var no = $(this).parent().parent().attr("no");
			$("#reno").val(no);
			
			// reno 알림용(주석처리)
			// alert("reno : " + $("#reno").val());
			
			if(confirm("댓글을 삭제하시겠습니까?")) {
				var params = $("#commListForm").serialize();
				
				$.ajax({
					url: "cfreeDels",
					type: "post",
					data: params,
					dataType: "json",
					success: function(res){
						if(res.result == "success"){
							alert("댓글이 정상적으로 삭제 되었습니다.");
							history.go();
						} else if(res.result == "failed") {
							alert("댓글 삭제에 실패하였습니다.");
						} else {
							alert("댓글 삭제 중 문제가 발생하였습니다.");
						}
					},
					error: function(request, status, error){
						console.log(error);
					}
				}); // ajax end
			}
		});
		
		// comment-수정버튼
		$(".comm_list #cUpdateBtn").on("click", function() {

			// con의 내용 그대로 textarea에 넣기
			var con = $(this).parent().parent().children(".con_info").children(".con").html();
			$(".update_con").val(con);
			
			// 주석처리
			// var no = $(".comm_data").attr('no');
			var no = $(this).parent().parent().attr('no');
			$("#reno3").val(no);
			// alert("reno : " + $("#reno3").val())// reno 찍어보는 용

			$(".write_con_wrap").hide();
			$(".comm_write #cAddBtn").hide();
			$(".update_con_wrap").show();
			$(".comm_update #cUpdateBtn2").show();
			$(".comm_update #cCancelBtn").show();
		});
		
		// comment-수정버튼->수정버튼
		$(".comm_update #cUpdateBtn2").on("click", function() {
		
			var params = $("#commUpdateForm").serialize();
			
			$.ajax({
				url: "cfreeUpdates",
				type: "post",
				data: params,
				dataType: "json",
				success: function(res) {
					if(res.result == "success"){
						alert("댓글 수정이 정상적으로 완료 되었습니다.");
						history.go();
					} else if(res.result == "failed"){
						alert("댓글 작성에 실패 하였습니다.")
					} else {
						alert("댓글 작성 중 문제가 발생하였습니다.")
					}
				},
				error: function(request, status, error){
					console.log(error);
				}
			})
		});
		
		// comment-수정버튼->취소버튼
		$(".comm_update #cCancelBtn").on("click", function() {
			$(".write_con").val("");
			$("#no").val("");
			
			$(".write_con_wrap").show();
			$(".comm_write #cAddBtn").show();
			$(".update_con_wrap").hide();
			$(".comm_update #cUpdateBtn2").hide();
			$(".comm_update #cCancelBtn").hide();
		});
		
	}); // doc end

	// checkVal func
	function checkVal(sel){
		if($.trim($(sel).val()) == ""){
			return true;
		} else {
			return false;
		}
	}
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
	
	<!-- dtl 부분 -->
	<h2>자유게시판 상세페이지</h2>
	<form action="#" id="actionForm" method="post">
		<input type="hidden" name="searchGbn" value="${param.searchGbn}" />
		<input type="hidden" name="searchTxt" value="${param.searchTxt}" />
		<input type="hidden" name="page" value="${param.page}" />
		<input type="hidden" name="no" value="${param.no}" />
	</form>
	
	<input type="button" value="목록" id="listBtn" />
	<c:if test="${sMLv eq 0}">
		<input type="button" value="삭제" id="deleteBtn" /> 
	</c:if>
	<c:if test="${data.MEM_NO eq sMNo}">
		<c:choose>
			<c:when test="${sMLv eq 1}">
				<input type="button" value="수정" id="updateBtn" /> 
				<input type="button" value="삭제" id="deleteBtn" /> 
			</c:when>
			<c:otherwise>
				<input type="button" value="수정" id="updateBtn" /> 
			</c:otherwise>
		</c:choose>
	</c:if>
	<br><br>
	
	<div>
	<table class="free_table">
			<thead>
				<tr>
					<th>${param.no} </th>
					<th>${data.CATEGORY_NM} </th>
					<th class="title">${data.FREE_TITLE}</th>
					<th>${data.MEM_NM}</th>
					<th>${data.FREE_DT}</th>
					<th>${data.FREE_HIT}</th>
				</tr>
			</thead>
		</table>
	</div>
	
	<div class="divcon">
		<div>
			<br>
			${data.FREE_CON}
		</div>
		<c:if test="${!empty data.FREE_FILE}">
		<div>
			<c:set var="len" value="${fn:length(data.FREE_FILE)}"></c:set>
			첨부파일: 
			<a href="resources/upload/${fn:replace(fn:replace(data.FREE_FILE, '[', '%5B'), ']', '%5D')}" 
			download="${fn:substring(data.FREE_FILE, 20, len)}">${fn:substring(data.FREE_FILE, 20, len)}
			</a>
		</div>
		<div>
			<img src="resources/upload/${fn:replace(fn:replace(data.FREE_FILE, '[', '%5B'), ']', '%5D')}" width="100px" height="100px" />
		</div>
	</c:if>
	</div><br>
	<hr>
	
	<!-- comment 부분 -->
	<!-- 댓글 리스트 -->
	<div class="comm_list">
		<form action="#" id ="commListForm" method="post">
		<c:if test="${data.FREE_NO eq no}">
			<c:choose>		
				<c:when test="${fn:length(list) eq 0}">
					<i>등록된 댓글이 없습니다.</i>
				</c:when>
				<c:otherwise>
					<c:forEach var="data" items="${list}">
						<input type="hidden" name="page" id="page" value="${page}">
						<input type="hidden" name="no" id="no" value="${param.no}">
						<input type="hidden" name="mno" id="mno" value="${data.MEM_NO}">
						<input type="hidden" name="reno" id="reno" value="${data.FREE_RE_NO}">
						<div class="comm_data" no="${data.FREE_RE_NO}">
							<img src="resources/images/man.png" width="20px" height="20px">
							<b>${data.MEM_NM}</b>
							${data.FREE_RE_DT}<br>
							<div class="con_info">
								<div class="con">${data.FREE_RE_CON}</div>
							</div><br><br>
							<div class="btn_wrap">
								<c:if test="${data.MEM_NO eq sMNo}">
									<input type="button" value="수정" id="cUpdateBtn">
									<input type="button" value="삭제" id="cDelBtn">
								</c:if>
							</div>
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</c:if>
		</form>
	</div>
	<br>
	
	<!-- 댓글 페이징 -->
	<div class="comm_paging">
		<c:choose>
			<c:when test="${page eq 1}">
				<span page="1">이전</span>
			</c:when>
			<c:otherwise>
				<span page="${page - 1}">이전</span>
			</c:otherwise>
		</c:choose>
		<c:forEach var="i" begin="${pb.startPcount}" end="${pb.endPcount}" step="1">
			<c:choose>
				<c:when test="${page eq i}">
					<span page="${i}"><b>${i}</b></span>
				</c:when>
				<c:otherwise>
					<span page="${i}">${i}</span>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:choose>
			<c:when test="${page eq pb.maxPcount}">
				<span page="${pb.maxPcount}">다음</span>
			</c:when>
			<c:otherwise>
				<span page="${page + 1}">다음</span>
			</c:otherwise>
		</c:choose>
	</div>
	<br>
	
	<!-- 댓글 작성창 -->
	<div class="comm_write">
		<form action="#" id="commAddForm" method="post">
			<input type="hidden" name="no" id="no" value="${param.no}">
			<input type="hidden" name="mno" id="mno" value="${sMNo}">
			<input type="hidden" name="reno" id="reno2">
			
			<div class="user_info">
				<div class="user_name"><b>${sMNm}</b>님</div><br>
			</div>
			<div class="write_con_wrap">
				<textarea class="write_con" id="con" name="con" placeholder="댓글을 입력해주세요."></textarea><br>
	        </div>
	        <div class="btn_wrap">
	        	<input type="button" value="등록" id="cAddBtn"/>
			</div>
		</form>
	</div>
		
	<!-- 댓글 수정창 -->
	<div class="comm_update">
		<form action="#" id="commUpdateForm" method="post">
			<div class="update_date">
				<input type="hidden" name="reno" id="reno3">
				<div class="update_con_wrap">
					<textarea class="update_con" id="con2" name="con2"></textarea><br>
		        </div>
		        <div class="btn2_wrap">
		        	<input type="button" value="수정" id="cUpdateBtn2"/>
		        	<input type="button" value="취소" id="cCancelBtn"/>
				</div>
			</div>
		</form>
	</div>
	</main>
	
	<footer>
		<jsp:include page="../footer.jsp" flush="true" />
	</footer>
	
	<script type="text/javascript" src="resources/css/js/header.js"></script>
</body>
</html>