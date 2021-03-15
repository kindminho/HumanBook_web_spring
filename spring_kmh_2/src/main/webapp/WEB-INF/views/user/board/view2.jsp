<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
 
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/layout2_css.css">
<meta charset="UTF-8">
<script>
function checkYesNo(){
	if(confirm("정말로 삭제 하시겠습니까?")){
		return true;	
	} else {
		return false;
	}
}

</script>
<title>게시판</title>
</head>
<body>

<%@ include file="../header.jsp" %>

<%@ include file="../menu.jsp" %>


<div class="content" style="width:100%; padding:100px;">
  <div class="main">  
	<div class="card">
	    <h2>■ 게시판 세부내용</h2>	
	    <hr> 
	    <div style="margin-top:50px;">
			<div>
			<table>		
<%-- 			<c:set value="${board}" var="dto" />	 --%>
				<thead>	
					<tr>
						<td style="text-align:left">${board.title}</td>
						<td style="text-align:right">조회수 : ${board.count}</td>
					</tr>
					<tr>
						<td style="text-align:left">작성자 : ${board.id}</td>
						<td style="text-align:right">${board.wdate}</td>
					</tr>
					<tr style="height:300px; vertical-align: top; background-color: #f5f5f5">
						<td colspan="2" style="text-align:left; padding-top:20px;">
						${board.content}
						</td>
					</tr>
					<c:if test="${board.upfile.fileName != null }">
					<tr>
					<c:set value="${board.upfile.fileType}" var="ftype" />
					<c:set value="${fn:substring(ftype, 0,fn:indexOf(ftype,'/') ) }" var="type"/>
					
						<td colspan="2" style="text-align:left"> 첨부파일 : 	
						
							<form name="filedown" method="post" action="/download">										
								<input type="hidden" name="savefilename" value="${board.upfile.saveFileName}">								
								<input type="hidden" name="filepath" value="${board.upfile.filePath}">	
																
								<c:if test="${ type eq 'image'}">
									<img width="100px" height="100px" src="/upload/${board.upfile.saveFileName }" />
								</c:if>
								${board.upfile.fileName } (사이즈: ${board.upfile.fileSize }) 	
								
								<input type="submit" value="다운로드" >								
							</form>
							
							
						</td>
					</tr>
					</c:if>																				
				</thead>				
			</table>
			</div>
			<div class="button">
			<c:if test="${board.id == sess_id }">
			<form name="boardModifyBtn" method="POST" action="/board/modifyForm">				
				<input type="hidden" name="bno" value="${board.bno}">
				<input type="hidden" name="title" value="${board.title}">
				<input type="hidden" name="content" value="${board.content}">
				<input type="hidden" name="count" value="${board.count}">
				<input type="hidden" name="wdate" value="${board.wdate}">
				<input type="hidden" name="writer" value="${board.id}">
				
				<input type="hidden" name="fileNo" value="${board.upfile.fileNo}">
				<input type="hidden" name="saveFileName" value="${board.upfile.saveFileName }">
				<input type="hidden" name="fileName" value="${board.upfile.fileName}">
				<input type="hidden" name="fileSize" value="${board.upfile.fileSize}">
				<input type="hidden" name="fileType" value="${board.upfile.fileType}">
				
				<input type="submit" value="수정">
			</form>
			<form name="boardDelBtn" method="POST" action="/board/delete" onsubmit="return checkYesNo()">
				<input type="hidden" name="bno" value="${board.bno}">
				<input type="hidden" name="saveFileName" value="${board.upfile.saveFileName}">
				<input type="submit" value="삭제">
			</form>				
			</c:if>
			</div>
		</div>    
	</div>	
  </div>	
</div>


<%@ include file="../footer.jsp" %>

<%@ include file="../modal.jsp" %>

</body>
</html>