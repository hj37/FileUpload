<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%--
			스토리 설명: 
			여러개의 파일을 업로드 할 수 있도록 여러개의 <input type="file">태그를 만드는데..
			이왕이면 딱 정해진 개수를 만드는 것 보다 내가 원하는 업로드할 파일수만큼 <input>을 동적으로 늘여
			다중 파일 업로드를 해보자.
	--%>
	<h2>다중 파일 업로드</h2>
	
	<%--[1번 form] 내가 원하는 업로드할 파일수를 입력 받는 form  --%>
	<form action="multi.jsp">
		이름 : <input type="text" name="name"/> <br>
		주소 : <input type="text" name="addr" /> <br>
		하고싶은말 : <br>
		<textarea rows="3" cols="70" name="note"></textarea> <br>
		업로드할 파일 수 입력받기 : <input type="text" name="add" size="2">
		<input type="submit" value="확인">
	</form>
	
	<%
		//입력 받은 업로드할 파일수를 저장할 변수 
		int filecnt = 0;
	
		//1번 form에서 입력한 파일수가 존재하면? 
		if(request.getParameter("add") != null){
			//입력받은 업로드할 파일수 저장 
			filecnt = Integer.parseInt(request.getParameter("add"));
		}
	%>
	
	<%--[2번 form] 다중 파일 업로드 요청 하는 <form> --%>
	<form action="multi_pro.jsp" enctype="multipart/form-data" method="post">
		<%-- [1번 form]에서 입력할 업로드할 파일수만큼 for문을 이용하여 <input type="file">태그를 생성하여 
			 [2번 form]을 이용하여 다중 파일 업로드 요청함.
		 --%>
		<%
			for(int i = 0; i < filecnt; i++){
				%>
					<%=i+1%>번째 파일 선택 : <input type="file" name="upFile<%=i%>"><br>				
		<% 
			}
		
		%>
		
			<input type="submit" value="다중파일업로드">
	
	</form>
	
	
	<%--
		문제점 : 
		1번 form태그에 이름 주소 하고싶은말 추가할 파일 수 입력 후 [확인]버튼을 누르면 
		한 번 서버에 요청을 하고 나면 서버와의 연결이 끊어지므로 
		1번 form태그 내부에 입력한 내용은 모두 지워집니다.
		그래서? 1번 form태그내부에 입력한 데이터를 요청할때 request 객체 메모리영역에 잠시 저장해두었다가 
		request객체 메모리 있는 내용을 다시 1번 form태그 내부에 출력해주면 된다. 
	
	 --%>
	
</body>
</html>