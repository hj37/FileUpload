<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 


	// MultipartRequest클래스 : 파일업로드를 직접적으로 담당하는 클래스 
	
	
	//현재 실행중인 웹프로젝트에 대한 정보를 지니고 있는 객체 얻기 
	ServletContext ctx = getServletContext();
	
	//현재 실행중인 웹프로젝트에 대한 정보 객체의 getRealPath()메소드를 이용하여 
	//가상경로를 실제경로로 바꿔주기 
	
	
	/* 
		가상경로 
			/upload
		실제경로 
	
			
		
	*/
	//업로드할 실제 서버 경로 알아내기 
	String realPath = ctx.getRealPath("upload");

	//업로드할 수 있는 파일의 최대 크기 지정 5MB
	int max = 5 * 1024 * 1024;
	
	//실제 파일업로드 담당 하는 객체 생성시.. 생성자로 업로드할 정보를 전달하여 업로드함.
	//매개변수1 : <form>에서 전달받은 값을 얻어오기 위해 request전달 
	//매개변수2 : 업로드될 파일의 위치를 전달 
	//매개변수3 : 업로드할 수 있는 파일의 사이즈 전달 
	//매개변수4 : 업로드할 파일명이 한글일 경우 업로드시 깨지므로 문자셋 방식 지정
	//매개변수5 : 실제 업로드되는 위치에 같은 이름의 파일 업로드시 파일명이 중복되므로 업로드할 파일명을 자동으로 변환해주는 객체 전달 
	MultipartRequest multi =  
	new MultipartRequest(request,realPath,max,"UTF-8", new DefaultFileRenamePolicy());
	
	//request객체의 getParameter()메소드대신... MultipartRequest객체의 getParameter()메소드를 사용하여 
	//요청한 텍스트 값을 얻는다.
	String user = multi.getParameter("user");
	String title = multi.getParameter("title");
	
	out.println(user + "," + title);
	out.println(realPath);
	//파일업로드시 선택한 <input>의 name속성값들을 모두 Enumeration 반복기에 담아 
	//Enumeration 반복기 객체를 반환
	Enumeration e= multi.getFileNames();
	
	//Enumeration반복기역할을 하는 객체 내부에 값이 저장되어 있는 동안 

	while(e.hasMoreElements()){
		//파일업로드시 선택한 <input>태그의 name속성값 upFile을 Enumeration반복기에서 차례대로 꺼내옴 
		String name = (String) e.nextElement();
		
		out.println("클라이언트가 업로드한 파일의 원본이름  : " 
		+ multi.getOriginalFileName(name) + "<br>");
		
		out.println("서버저장소에 업로드된 실제 파일이름 : "
		+ multi.getFilesystemName(name)+ "<br>");
		
		//서버에 업로드된 실제 파일에 접근하기 위한 File객체 생성 
		File f = multi.getFile(name);

		
		
		out.println("업로드된 실제 파일의 크기 : " + f.length() + "byte <br>");
		
		//서버에 업로드 될 실제 파일 삭제 
// 		f.delete();
	}
	
%>