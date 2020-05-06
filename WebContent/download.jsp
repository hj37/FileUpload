<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	//주제 : 특정 파일들을 실행하지 않고 다운로드를 전문적으로 처리하는 페이지 

	//한글처리 
	request.setCharacterEncoding("UTF-8");

	//multi_pro.jsp로부터 파일을 다운로드를 위해 요청받은 다운로드할 가상주소, 
		//다운로드할 파일명(실제 서버에 업로드된 파일명) 받기 
	String path  = request.getParameter("path");
	String name = request.getParameter("name"); 

	//가상주소 upload경로를 전달하여  -> 다운로드할 실제 서버의 경로 구하기 
	String realPath = getServletContext().getRealPath("/" + path);
	out.println(realPath);
	
	/* 
	
		(설명)
		실행가능한 파일일지라도 무조건 다운로드 받게 처리해야하는데..
		그러기 위해서는 지금까지는? 클라이언트 <----- 서버가 응답(파일) 할때...
		응답할 파일데이터 + 응답할 파일데이터에 대한 헤더 정보(어떤 형식,누구한테 전달, 어떻게 만들어졌고, 응답데이터크기)등등...
		응답할 파일 데이터의 헤더정보 또한 같이 클라이언트의 웹브라우저에 전달해야함.
	
	*/
	
	//다운로드 파일을 서버에서 클라이언트의 웹브라우저로 내보내기 전에.. 헤더 정보 설정하기 
	response.setContentType("Application/x-msdownload");	//다운로드 문서형식으로 무조건 내보내겠다고 수정 
	//클라이언트의 웹브라우저에서 위코드를 인식함!!!
	
	//이미 정해져 있는 헤더정보를 담는 Content-Disposition변수의 값을? 다운로드 할 파일명으로 지정 해주기 
	response.setHeader("Content-Disposition", "attachment;filename=" + name);
	
	//서버경로에 저장되어 있는 다운로드할 파일에 직접 접근 할 수 있는 File객체 생성 
	File file = new File(realPath + "/" + new String(name.getBytes("8859_1"),"utf-8"));
	
	//서버 경로에 저장되어 있는 파일내부의 데이터를 1024바이트씩 읽어 들이기 위해 byte배열 생성 
	byte[] data = new byte[1024];
	
	
	if(file.isFile()){//다운로드 할 것이 파일형식이라면? 
		
			try{	//입출력시 예외처리 필수!
				//서버경로에 저장되어 있는 파일을 클라이언트의 웹브라우저로 내보내기 위해 스트림통로준비
				
				//1.파일 내용을 읽어들이기 위한 스트림통로 준비 
				//new FileInputStream(file); 
					//다운로드할 실제 File객체가 가리키는 파일을 1바이트씩 1바이트씩 읽어 들이기 위한 스트림통로 준비 
					
				//new BufferedInputStream(new FileInputStream(file)); 
					//File객체가 가리키는 파일 데이터 모두를 1바이트단위로 읽어 들여 
					//별도의 내부버퍼 공간에 모아 두었다가...
					//한꺼번에 파일의 전체 내용을 익어들이기 위한 통로 만들기 
					
					
				BufferedInputStream input = 
					new BufferedInputStream(new FileInputStream(file));
				//2. 스트림 통로를 통해 읽어들인 파일의 전체내용을 클라이언트의 웹브라우저로 내보내기(다운로드) 위한 
				//별도의 출력 스트림 통로 준비 필요함 
				BufferedOutputStream output = new BufferedOutputStream(response.getOutputStream());
				
				//다운로드할 파일전체 내용 중... 1024바이트 읽어 들인 내용을 저장할 변수
				int read;
				
				
				//다운로드할 파일 내용을 1024바이트씩 끊어서 내부버퍼공간에 읽어들이는데...
				//읽어들일 파일의 내용이 존재하는 동안 반복 
				while((read = input.read(data)) != -1 ){	//read()메소드의 반환값은 읽어들이기에 성공한 바이트수를 반환
															//읽어들이기에 실패하면? -1을 반환함.
					
					//data배열의 0부터 읽어들인 1024바이트씩 묶어서 출력버퍼에 내보낸다.											
					output.write(data,0,read); 
				}
				
				//출력버퍼 공간이 가득 차지 않아도 파일 내용을 강제적으로 사용자의 웹브라우저 화면에 내보내는 기능을 제공
				output.flush();
				//스트림 통로 사용후 자원해제 
				output.close();
				input.close();
				
				
				
			}catch(Exception err){
				err.printStackTrace();
			}
	}
	
%>    
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>