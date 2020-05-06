<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<script type="text/javascript">
	
	//2번 form태그에서  다중파일업로드 버튼 클릭했을때 호출되는 함수로서
	//   업로드를 위해 누락된 정보가 있는지 체크 하는 함수 
/* 	function Check(f) {		
		
		var cnt = f.elements.length-5;
		var filecnt = 1;
		for (i = 0; i < cnt; i++) {	
			if (document.getElementsByName("upfile" + i)[0].value == "") {
					alert(filecnt + "번째 파일 정보가 누락되었습니다.");
					f.elements[i].focus();
					return;
				}
					filecnt++;
			}
		f.submit();
	 }//Check()함수 끝 */
	 
	 
	 function Check(f) {
			
			//2번 form태그에 접근하여  form태그내부의 모든 input태그의 갯수 구하기
			//forms[] 배열  : <form>에 접근 방법
			//elements : <form>안에 있는 모든 <input>태그들을 말함
			//length : 개수, 길이
			var cnt = f.elements.length;
			/*
				위 cnt변수에 들어가 <input>태그의 개수에 대한 설명!
				-> 2번 form에 고정된 <input type="hidden"> 3개,
				   <input type="button"> 1개이므로 총4개의 <input>이 고정으로 되어 있다.
			*/
			//누락된 파일업로드 위치를 저장할 변수 선언
			var filecnt = 1;
			/*
				(설명) 2번 form태그에 저희는 업로드될 파일개수를 사용자에 의해서 동적으로 입력 받기 떄문에
					  2번 form태그안의  for문을 이용하여  <input type="file">태그가 동적으로 만들어집니다
					  동적으로 만들어진 <input type="file">태그중에서 업로드할 파일 경로를 지정하지 않은?
					 <input type="file">태그가 있다면 ? " X번째 파일 정보가 누락되었습니다 " 라고 
					 경고 메세지를 띄워 줘야 합니다.
			*/
			//2번 form태그안에 있는 모든 <input>태그 개수 만큼 반복 하는데..
			for(i=0; i<cnt; i++){	
				//만약  2번form태그 내부에 있는 <input>태그의type속성값이 file과 같고
				if(f.elements[i].type == "file"){
					//만약 <input type="file">태그중에서..
					//업로드할 파일을 지정 하지 않았다면?
					if(f.elements[i].value == ""){
						// x번째 <input type="file">내용일 비었습니다 경고메세지!
						var msg = filecnt + "번째 파일정보가 누락되었습니다.\n올바른 선택을 해주세요";
						alert(msg);
						//포커스 주기
						f.elements[i].focus();
						return; //for 반복문을 빠져 나감
					}//안쪽 if				
					filecnt++; //1증가
				}//바깥쪽 if
			}//for 끝		
			//2번 form 다중 파일 업로드 요청전송
			f.submit();
		}//Check()함수 끝

		function addInput() {//아래의 업로드할 파일수를 입력하여 입력한 파일수만큼 
			//동적으로 <input type="file">태그를 새로 생성하여 
			//아래의 <div id="inputDiv></div>"요소 영역에 추가시켜 나타냄

			//입력받은 업로드할 파일수 얻기
			var filecnt = document.f.add.value;

			//id속성값이 inputDiv인 <div>요소를 선택해서 가져와서 변수에 저장
			var div = document.getElementById("inputDiv");

			//확인 버튼 누를때마다 위의 addInput함수가 호출되어 msg변수값은 ""공백으로 초기화됨
			var msg = "";

			//입력받은 업로드할 파일수만큼 반복해서  <input type="file">태그를 생성하여 msg변수에 누적
			for (i = 0; i < filecnt; i++) {

				msg += "<input type='file' name='upfile" + i + "'/><br>";

			}
			//<div></div> 영역안에 위의 msg변수에 누적되어 저장되어 있는 전체 문자열 
			//            <input type="file">들을 한방에 삽입
			div.innerHTML = msg;

		}
	</script>
</head>
<body>
	<h2>다중 파일 업로드 요청</h2>
	<form action="multi_pro.jsp" method="post" enctype="multipart/form-data" name="f">
	
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