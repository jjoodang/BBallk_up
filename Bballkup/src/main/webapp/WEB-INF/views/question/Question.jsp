<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객지원-질문답변게시판</title>
	<link rel="stylesheet" href="resources/css/layout/font.css">
	<link rel="stylesheet" href="resources/css/layout/basic.css">
	<link rel="stylesheet" href="resources/css/layout/loginout.css">
	<link rel="stylesheet" href="resources/css/layout/nav.css">
	<link rel="stylesheet" href="resources/css/layout/question.css">
	
<style>

.qqdiv {
	width: 100%;
}
.ob_wrap {
	border: 2px solid #1d2088;
	border-radius: 10px;
	margin-bottom: 20px;
	width: 100%;
}
.reple_con {
	width: 540px;
	height: 90px;
	resize: none;
	margin: 2px;
}
.user_info {
	/* display: inline-table; */
	width: 100px;
	/* height: 100px; */
	vertical-align: top;
	text-align: center;
	padding-top: 45px;
}
.ob_data{
	border-top : 1px solid #444444;
	margin-bottom: 5px;
	display: flex;
	height: 100px;
}

.write_con_wrap, .con_info {
	width: 80%;
	height: 100px;
}

.write_con, .q_re_con {
	resize: none;
	width: 99%;
    height: 90%;
    margin: 3px;
}
.reple_text_area{
	background-color: #e3ecfb;
}

.ob_data_reple{
	display: flex;
}

.reple_wrap{
    height: 100px;
    display: flex;
    width: 100%;
}

.con_info{
	width: 80%
}
.btn_wrap{
	width: 10%;
	text-align: center;
	/* float: right; */
	display : flex; 
	flex-direction: column; 
	padding-top: 10px;
	margin-right: 5px;
	margin-left: 10px;
} 

.action_btn, .action_btn4{
	width: 100px;
 	height: 90px;`
 	margin-top: 5px;
 }
 .action_btn2, .action_btn3, .action_btn5, .action_btn4, .action_btn6{
 	background-color: white;
    padding: 5px;
    width: 100px;
    border-radius: 5px;
    border: 2px solid #1d2088;
    cursor: pointer;
 }
input:hover{
	background-color: #e3ecfb;
}

input{
	background-color: white;
    padding: 5px;
    width: 80px;
    border-radius: 5px;
    border: 2px solid #1d2088;
    cursor: pointer;
    margin-bottom: 10px;
}

.write_area {
    display: flex;
	height: 100px;
	margin-bottom: 3px;
}
 .action_btn6 {
  display: none;
 } 
 
.login_req_wrap {
	display: inline-table;
	width: 100%;
	height: 100px;
}

.login_req {
	display: table-cell;
	width: 800px;
	height: 100px;
	vertical-align: middle;
	text-align: center;
}

.data_req_wrap {
	display: inline-table;
	width: 800px;
	height: 100px;
	border-top : 1px solid #444444;
	margin-bottom: 5px;
}

.data_req {
	display: table-cell;
	width: 800px;
	height: 100px;
	vertical-align: middle;
	text-align: center;
}

.con_info {
	width: 80%;
	display: inline-table;
	height: 100px;
	vertical-align: top;
}

.con {
	display: table-cell;
	width: 100px;
	height: 100px;
	vertical-align: middle;
	text-align: left;
}
.q_re_con {
	display: inline-table;
	height: 75px;
	vertical-align: middle;
}
.reple_con {
	display: inline-table;
    height: 50px;
    width: 100%;
	vertical-align: middle;
	text-align: left;
}

.reple_wrap > .user_info  {
	padding-top: 20px;
}

.reple_text_area {
	height: 90px;
}
.reple_write_area {
	height: 90px;
}
.reple_text_area > .con_info  {
	padding-top: 25px;
}

#paging_wrap2 {
	margin: 20px;
	border-top: 1px solid #444444;
	text-align: center;
}

#paging_wrap2 span {
	margin: 0px 5px;
	cursor: pointer;
}

</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	if("${page}" > "${pb.maxPcount}"){
		$("#page").val("${pb.maxPcount}");
		$("#actionForm").submit();
	}
	
	// textarea에 val가 없을때 영역 감추기 
	$(".q_re_con").each(function() {
		console.log($(this).val());
		if($(this).val() == "") {
			$(this).parent().parent().parent().children(".reple_text_area").hide();
		} else {
			$(this).parent().parent().hide();
		}
	});
	
	// 목록에서 "수정"버튼을 눌렀을때
	$(".ob_list_wrap").on("click","#updateBtn", function(){			
		var con = $(this).parent().parent().children(".con_info").children(".con").html();
		$(".write_con").val(con); // 내용 셋팅
		
		var no = $(this).parent().parent().attr("no");
		$("#no").val(no);
		
		$(".write_area .action_btn").hide(); 
		$(".write_area .action_btn6").show(); 
	});
	
	$(".write_area #cancelBtn").on("click",function(){
		$(".write_con").val(""); 
		$("#no").val("");
		
		$(".write_area .action_btn").show();
		$(".write_area .action_btn6").hide();
	});
	
	$("body").on("click","#loginBtn",function() { 
		location.href = "login";		
	});
	
	$("#logoutBtn").on("click",function() {
		location.href = "logout";
	});
	
	// 저장
	$(".write_area #addBtn").on("click",function(){	
		
		if(checkVal("#q_con")){
			alert("내용을 입력하세요.");
			$("#q_con").focus();
	  } else {
		  $("#actionForm").attr("action","QuestionAdds");
		  $("#actionForm").submit(); 
	   }
	});
	
	// 수정 
	$(".write_area #update2Btn").on("click",function(){	
		if(checkVal("#q_con")){
			alert("내용을 입력하세요.");
			$("#q_con").focus();
		} else {
			$("#actionForm").attr("action","QuestionUpdates");
			$("#actionForm").submit();
		}
	});
	
	//삭제
	$(".ob_list_wrap #deleteBtn").on("click",function() {	
		var no = $(this).parent().parent().attr("no");
		$("#no").val(no);
		
		if(confirm("삭제하시겠습니까?진짜?")) { 
			$("#actionForm").attr("action","QuestionDelete"); 
			$("#actionForm").submit();
		}
	});
	
	//페이징
	$("#paging_wrap2").on("click","span",function() {
		$("#actionForm").attr("action","Question");
		$("#page").val($(this).attr("page"));
		$("#actionForm").submit();
	});
	
	//답변등록버튼
	$(".reple_write_area").on("click","#reple_addBtn", function() {
		var no = $(this).parent().parent().parent().attr("no");
		$("#no2").val(no);
		
		var con = $(this).parent().parent().children(".con_info").children(".q_re_con").val();
		$("#q_re_con").val(con);	
		
		if(checkObjVal($(this).parent().parent().children(".con_info").children(".q_re_con"))){
			alert("내용을 입력하세요.");
			$(this).parent().parent().children(".con_info").children(".q_re_con").focus();
		} else {
			$("#RepleForm").attr("action","QuestionReple");
			$("#RepleForm").submit();
		}
	});
	
	//답변 수정버튼(ㅇㅇ) 
	$(".reple_text_area").on("click","#reple_text_updateBtn", function(){		
		$(this).parent().parent().hide();
		$(this).parent().parent().parent().children(".reple_write_area").show();		
	}); 
	
	$(".reple_write_area").on("click","#reple_write_updateBtn", function(){
		
		var no = $(this).parent().parent().parent().attr("no");	
		$("#no2").val(no);
		
		var con = $(this).parent().parent().children(".con_info").children(".q_re_con").val();
		$("#q_re_con").val(con);
		
		if(checkObjVal($(this).parent().parent().children(".con_info").children(".q_re_con"))){
			alert("내용을 입력하세요.");
			$(this).parent().parent().children(".con_info").children(".q_re_con").focus();
		} else {
			$("#RepleForm").attr("action","QuestionReple");
			$("#RepleForm").submit();
		}
	});
	
	//답변 삭제
	 $(".reple_wrap").on("click","#reple_deleteBtn", function(){
		 var no = $(this).parent().parent().parent().attr("no");
		$("#no2").val(no);
		
		if(confirm("답변을 삭제하시겠습니까?")) { 
			$("#RepleForm").attr("action","QuestionRepleDel");
			$("#RepleForm").submit();
		}
	 });
	
	//답변수정취소
	$(".reple_wrap #reple_cancelBtn").on("click",function(){
		$(this).parent().parent().parent().children(".con_info").children(".q_re_con").val($(this).parent().parent().parent().children(".reple_text_area").children(".con_info").children(".reple_con").html());
		$(this).parent().parent().hide();
		$(this).parent().parent().parent().children(".reple_text_area").show();
	});
});


function checkVal(sel) {
	if($.trim($(sel).val()) == "") {
		return true;
	} else {
		return false;
	}
}

function checkObjVal(obj) {
	if($.trim(obj.val()) == "") {
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
<div class="qqdiv">
	<!-- 작성+리스트 -->
	<h2>고객지원 >> 질문게시판</h2>
	<div class="ob_wrap">	
		<form action="#" id="actionForm" method="post">
		<input type="hidden" id="no" name="no"/>
		<input type="hidden" id="sMNo" name="sMNo" value="${sMNo}"/>
		<input type="hidden" name="page" id="page" value="${page}"/>
		
		<div class="write_area">
			<c:choose>
				<c:when test="${empty sMNo}">
					<div class="login_req_wrap">
						<div class="login_req"> 작성 시 로그인이 필요합니다. 
						<input type="button" value="로그인" id="loginBtn"/></div>
					</div>	
				</c:when>
				<c:otherwise>			
					<div class="user_info">
						<div class="user_name">${sMNm}</div>
					</div>
					<div class="write_con_wrap">
						<textarea class="write_con" id="q_con" name="q_con"></textarea>
					</div>
					<div class="btn_wrap">
						<input type="button" value="저장" class="action_btn" id="addBtn"/>
						<input type="button" value="수정" class="action_btn6" id="update2Btn"/>
						<input type="button" value="취소" class="action_btn6" id="cancelBtn"/>
					</div>			
			    </c:otherwise>
			</c:choose>
		</div>
		</form>
		<form action="#" id ="RepleForm" method="post">
			<input type="hidden" name="no" id="no2" />
			<input type="hidden" id="sMNo" name="sMNo" value="${sMNo}"/>
			<input type="hidden" name="q_re_con" id="q_re_con" />
		</form>
		<!-- List -->
		<div class="ob_list_wrap">
			<c:choose>
				<c:when test="${fn:length(list) eq 0}">
					<div class="data_req_wrap">
						<div class="data_req">데이터가 없습니다.</div>
					</div>
				</c:when>
				<c:otherwise>
					<c:forEach var="data" items="${list}">
						<div class="ob_data" no="${data.Q_NO}">
							<div class="user_info">
								<div class="user_name">${data.MEM_NM}</div>
							</div>
							<div class="con_info">
								<div class="con">${data.Q_CON}</div>
							</div>
							<div class="btn_wrap">				
								<c:if test="${data.MEM_NO eq sMNo || sMNo eq 4}">
									<c:if test="${data.MEM_NO eq sMNo}">
										<input type="button" value="수정" class="action_btn2" id="updateBtn" />
									</c:if>
									<input type="button" value="삭제" class="action_btn2" id="deleteBtn" />
								</c:if>
							</div>
						</div>
						<!-- 댓글영역 -->
						<div class="ob_data_reple" id="ob_data_reple" no="${data.Q_NO}">
							<c:if test="${!empty data.Q_RE_CON}">
							<div class="reple_wrap reple_text_area" >
								<div class="user_info">
									<img src="resources/images/icon/답변.png" width="50px" height="50px">			
								</div>
								<div class="con_info">
									<div id="reple_con" class="reple_con">${data.Q_RE_CON}</div>
								</div>
								<div class="btn_wrap">
									<c:if test="${sMLv eq 0}">
										<input type="button" value="수정" class="action_btn3" id="reple_text_updateBtn" />
										<input type="button" value="삭제" class="action_btn3" id="reple_deleteBtn" />					
									</c:if>
								</div>
							</div>
							</c:if>
							<c:if test="${sMLv eq 0}">
								<div class="reple_wrap reple_write_area" >
									<div class="user_info">
										<img src="resources/images/icon/답변.png" width="50px" height="50px">			
									</div>
									<div class="con_info">
										<textarea class="q_re_con" placeholder="댓글을 입력해주세요.">${data.Q_RE_CON}</textarea>	
									</div>
									<div class="btn_wrap">
										<c:choose>
											<c:when test="${empty data.Q_RE_CON}">
												<input type="button" value="등록" class="action_btn4" id="reple_addBtn" />
											</c:when>
											<c:otherwise>
												<input type="button" value="수정" class="action_btn5" id="reple_write_updateBtn" />
												<input type="button" value="취소" class="action_btn5" id="reple_cancelBtn"/>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</c:if>										
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>		
		</div>
	<!-- Paging -->
		<div id="paging_wrap2">
			<br>
			<!-- 이전 -->
		<c:choose>
			<c:when test="${page eq 1}"> 
				<span page="1">이전</span>
			</c:when>
			<c:otherwise>
				<span page="${page - 1}">이전</span>
			</c:otherwise>
		</c:choose>		
		<!-- 페이지 넘버 -->
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
				<span page ="${pb.maxPcount}">다음</span>
			</c:when>
			<c:otherwise>
				<span page ="${page + 1}">다음</span>
			</c:otherwise>
		</c:choose>
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