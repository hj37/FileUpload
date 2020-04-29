<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%!

	//1번 form태그의 input태그의 value=""에서 요청하는 메소드 
	public String getParam(HttpServletRequest request,String param){
	
		//request객체에 요청한 데이터가 저장되어 있으면?
		if(request.getParameter(param) != null){
			
			//request객체에 저장되어 있는 데이터 리턴 
			return request.getParameter(param);
		}else{// request객체에 요청한 데이터가 저장되어 있지 않으면?
				
			//빈 공백을 리턴 		
			return "";
		}//getParam
		
	
	}

%>









<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<script type="text/javascript">
	
	
		//2번 form태그에서 다중파일업로드 버튼 클릭했을때 호출되는 함수로서 
		//업로드을 위해 누락된 정보가 있는지 체크하는 함수 
		function Check(f){
			//2번 form태그에 접근하여 form태그 내부의 모든 input태그의 갯수 구하기 
			//forms[] 배열 : <form>에 접근 방법 
			//elements : <form>안에 있는 모든 <input>태그들을 말함
			//length : 개수, 길이 
			var cnt = f.elements.length;
			
		/* 위 cnt변수에 들어가 <input>태그의 개수에 대한 설명!
		->2번 form에 고정된 <input type="hidden">3개,
		<input type="button">1개이므로 총 4개의 <input>이 고정으로 되어 있다.*/
			
		//누락된 파일업로드 위치를 저장할 변수 선언 
		var filecnt = 1;
		/* 
			(설명 ) 2번 form태그에 저희는 업로드될 파일개수를 사용자에 의해서 동적으로 입력받기 떄문에 
				  2번 form태그안의 for문을 이용하여 <input type="file">태그가 동적으로 만들어집니다.
				  동적으로 만들어진 <input type="file">태그중에서 업로드할 파일 경로를 지정하지 않은?
				<input type="file">태그가 있다면? "X번째 파일정보가 누락되었습니다."라고 
				경고 메세지를 띄워줘야합니다.
		*/
		//2번 form태그안에 있는 모든 <input>태그 개수만큼 반복하는데..
		for(i=0; i < cnt; i++){
			//만약 2번 form태그 내부에 있는 <input>태그의 type속성값이 file과 같고 
			if(f.elements[i].type=="file"){
				//만약 <input type="file">태그중에서..
				//업로드할 파일을 지정하지 않았다면?
				if(f.elements[i].value == ""){
					//x번째 <input type="file">내용이 비었습니다. 경고메세지!
					var msg = filecnt + "번째 파일정보가 누락되었습니다.\n 올바른 선택을 해주세요";
					alert(msg);
					//포커스 주기 
					f.elements[i].focus();
					return; //for 반복문을 빠져나감 
				}//안쪽 if
				
				filecnt++;	//1증가
			}//바깥쪽 if
		}//for
		//2번 form 다중 파일 업로드 요청전송  
		f.submit();
	}//Check()함수 끝
	
	</script>



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
		이름 : <input type="text" name="name" value='<%=getParam(request, "name")%>'/> <br>
		주소 : <input type="text" name="addr" value='<%=getParam(request,"addr")%>'/> <br>
		하고싶은말 : <br>
		<textarea rows="3" cols="70" name="note"><%=getParam(request,"note")%></textarea> <br>
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
	
	<%--[2번 form] 다중 파일 업로드 요청 하는 <form> 
	
	enctype="multipart/form-data" <--- 업로드할 파일의 내용까지 전송 
	enctype="application/x-www-form-urlencoded" <--- 업로드할 파일의 이름만 전송 
	
	--%>
	<form action="multi_pro.jsp" enctype="multipart/form-data" method="post">
	
		<%--
			multi_pro.jsp로 요청할때 입력한 이름, 주소, 하고싶은 말 모두 !!! 전송해야함.
			그러기 위해서 <input type="hidden">으로 나머지 값들을 감추어서 multi_pro.jsp로 전송해야함.
		 --%>
		<input type="hidden" name="name" value='<%=getParam(request,"name")%>'>
		<input type="hidden" name="addr" value='<%=getParam(request,"addr")%>'>
		<input type="hidden" name="note" value='<%=getParam(request,"note")%>'>
	
	
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
		
			<input type="button" value="다중파일업로드" onclick="Check(this.form);">
														
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