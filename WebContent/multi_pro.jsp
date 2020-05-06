<%@page import="java.util.Enumeration"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
			multi.jsp의 2번 <form>태그에서 요청한 데이터 + 업로드할 파일의 정보는?
			request객체영역에 저장되어 있으므로
			request객체영역에 저장되어 있는 요청 데이터 꺼내오기
		 --%>
	
		<%
			request.setCharacterEncoding("UTF-8");
		
			//업로드할 실제 서버 경로 얻기 
			String realFolder = getServletContext().getRealPath("/upload");
			
			//참고 : HttpServletRequset.getServletContext()
			//	      클라이언트가 요청한 context정보(servletContext인스턴스)를 반환하는 메소드
			//	   getServletContext().getRealPath(서버의 실제 파일이 저장되는 절대경로) : 
			//	   context객체에 존재하는 파일의 실제 절대경로를 반환하는 메소드 
			
			
			//업로드할 수 있는 최대 용량 100MB
			int max = 100 * 1024 * 1024;
			
			//실제 파일 업로드 담당 하는 MultiPartRequest객체 생성하여 다중 파일 업로드 !
			MultipartRequest multi =
			new MultipartRequest(request,realFolder,max,"UTF-8",new DefaultFileRenamePolicy());
			out.print(realFolder);
			
			//서버경로에 실제로 업로드된 파일의 이름을? 저장할 ArrayList배열 생성 
			ArrayList saveFiles = new ArrayList();
			
			//클라이언트가 업로드하기전의 파일의 원본이름을? 저장할 ArrayList배열 생성 
			ArrayList originFiles = new ArrayList();
			
			//클라이언트가 파일 업로드 요청을 위해 선택했던 <input type="file">태그의 name속성값들을 모두 얻어
			//Enumeration 인터페이스타입의 자식객체에 담아.. 반환 받기 
			Enumeration e = multi.getFileNames();
			
			while(e.hasMoreElements()){	//Enumeration인터페이스 타입의 자식 객체 안에 
										//데이터가 저장되어 있는 동안 반복 
				
				//업로드 요청을 위해 선택했떤 <input type="file">태그의 name속성값들을 차례대로 꺼내옴
				String filename = (String)e.nextElement();	//upFile0 upFile1 upFile2
				
				//서버에 실제로 업로드된 파일 이름을 하나씩? 얻어 ArrayList배열에 추가 
				saveFiles.add(multi.getFilesystemName(filename));
				
				//클라이언트가 업로드 요청한 파일의 원본 이름을 하나씩 하나씩 얻어? ArrayList배열에 추가 
				originFiles.add(multi.getOriginalFileName(filename));
				
					
			}
			
			
			//입력한 이름, 주소, 하고싶은말 얻기 
			String name= multi.getParameter("name");
			String addr = multi.getParameter("addr");
			String note = multi.getParameter("note");
			
		%>
			<ul>
				<li>이름 : <%=name %></li>
				<li>주소 : <%=addr %></li>
				<li>하고싶은말 : <%=note%></li>
			</ul>
			
			<hr/>
			
			파일리스트 <br>
			
			<ul>
				<%
					for(int i = 0; i < saveFiles.size(); i++){
				%>
				
					<li>
					
						<%--파일 다운로드를 처리하는 download.jsp페이지로 다운로드할 가상주소 & 실제 다운로드할 파일이름을 전달함. --%>
						<a href="download.jsp?path=upload&name=<%=saveFiles.get(i)%>">
							<%=originFiles.get(i) %>
						</a>
					
					</li>
					
				<% 		
					}
				%>
			</ul>
		
		
		<script>
		window.alert("파일업로드 성공");
		</script>
</body>
</html>