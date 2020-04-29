<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script type="text/javascript">
	
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
		if(document.getElementsByName("upfile" + i)[0].value ==""){
			alert(filecnt + "번째 파일 정보가 누락되었습니다.");
			f.elements[i].focus();
			return;
		}
			filecnt++;	//1증가
		}//바깥쪽 if
	//2번 form 다중 파일 업로드 요청전송  
	f.submit();
}//Check()함수 끝	
	
		

	
		function addInput(){//아래의 업로드할 파일수를 입력하여 입력한 파일수만큼 
							//동적으로 <input type="file">태그를 새로 생성하여 
							//아래의 <div id="inputDiv></div>" 요소 영역에 추가시켜 나타냄 
							
				//입력받은 업로드할 파일 수 얻기
				var filecnt = document.f.add.value;
			
				//id속성값이 inputDiv인 <div>요소를 선택해서 가져와서 변수에 저장 
				var div = document.getElementById("inputDiv");
				//확인 버튼 누를때마다 위의 addInput함수가 실행되고 초기화해야함.
				//var msg="";
				div.innerHTML = "";
				//입력받은 업로드할 파일수만큼 반복해서 <input type="file">태그를 생성하여 div영역에 추가 
				for(i = 0; i <filecnt; i++){	

					var msg ="<input type='file' name='upfile"  + i +  "'/><br>";
					//msg +=~~ 
					//<div></div>영역안에 위의 <input type="file">를 누적 
					div.innerHTML += msg;
				}
				//div.innerHTML = msg;
		}
	
	
	</script>


</head>
<body>
	<h2>다중 파일 업로드 요청</h2>
	<form action="multi_pro.jsp" method="post" enctyple="multipart/form-data" name="f">
		
		이름 : <input type="text" name="name"><br>
		주소 : <input type="text" name="addr"><br>
		하고싶은말 : <br>
		<textarea rows="3" cols="70" name="note"></textarea> <br>
		업로드할 파일수 입력 받기 : <input type="text" name="add" size="2"> <br>
		<input type="button" value="확인" onclick="addInput();">
		
		<div id="inputDiv"></div>
		
		<input type="button" value="다중파일업로드전송" onclick="Check(this.form);">
	
	</form>
</body>
</html>