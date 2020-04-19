<%@page import="com.sun.xml.internal.bind.v2.runtime.Location"%>
<%@page import="data.dao.ImageDao"%>
<%@page import="data.dto.ImageDto"%>
<%@page import="java.io.UnsupportedEncodingException"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page
	import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="java.io.File"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="java.util.List"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.IOException"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		String board_id = "";
		//multipart로 전송되었는가를 체크 
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		
		//MultipartRequest multi = null;
		//multi = new MultipartRequest(request, rootPath, uploadSize, "utf-8", new DefaultFileRenamePolicy());
		
		// 저장 경로 선언
		//String rootPath = getServletContext().getRealPath("/save");
		
		//multipart로 전송 되었을 경우 
		if (isMultipart) {
			//업로드 된 파일의 임시 저장 폴더를 설정
			File temporaryDir = new File("C:\\Users\\user\\Desktop\\questgramTempImage");
			//톰켓의 전체 경로를 가져오고 upload라는 폴더를 만들고 거기다
			//tmp의 폴더의 전송된 파일을 upload 폴더로 카피 한다.                                                                                                                  
			String realDir = config.getServletContext().getRealPath("/save");
			System.out.println(realDir);
			// 업로드된 파일을 저장할 저장소와 관련된 클래스
			DiskFileItemFactory factory = new DiskFileItemFactory();
			//1메가가 넘지 않으면 메모리에서 바로 사용	  
			factory.setSizeThreshold(1 * 1024 * 1024);   // 저장소에 임시파일을 생성할 한계 크기 byte지정
			//1메가 이상이면 temporaryDir 경로 폴더로 이동  
			factory.setRepository(temporaryDir);  // 업로드된 파일을 저장할 위치를 File객체로 지정
			
			
			//실제 구현단계 아님 설정단계였음
			//클래스는 HTTP 요청에 대한 HttpServletRequest 객체로부터 
			//multipart/form-data형식으로 넘어온 HTTP Body 부분을 다루기 쉽게 
			//변환(parse)해주는 역할을 수행합니다. 
			ServletFileUpload upload = new ServletFileUpload(factory);
			//최대 파일 크기(10M)
			upload.setSizeMax(10 * 1024 * 1024);
			//실제 업로드 부분(이부분에서 파일이 생성된다)
			List<FileItem> items = upload.parseRequest(request);   // parseRequest(request) : FileItem형식으로 변환
			
	
			// Iterator 사용  
			// 임시파일 업로드 삭제 
			Iterator iter = items.iterator();
			while (iter.hasNext()) {
				//파일을 가져온다
				FileItem fileItem = (FileItem)iter.next();
				// 사용자가 업로드한 File 데이터나 사용자가 input text에 입력한 일반 요청 데이터에 대한 객체
				
				// fileItem.isFormField()메소드 리턴값이 true면 text-일반 데이터,, false면 파일데이터
				if (fileItem.isFormField()) {
					// text형태면 if문에 걸림                                                                                                                    
					if("board_id".equals(fileItem.getFieldName())){
						try {
							board_id = fileItem.getString("utf-8");
						} catch (UnsupportedEncodingException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
					//파일이면 이부분의 루틴을 탄다
				} else {
					
					// 폴더 구분자 추출 
			        int idx = fileItem.getName().lastIndexOf("\\"); //윈도우 기반, 없으면 -1을 반환??
			 			
			        if (idx == -1) { // 유닉스, 리눅스 기반 
			            idx = fileItem.getName().lastIndexOf("/"); 
			        } 

					// 실제 파일명 추출 
			        String filename = fileItem.getName().substring(idx + 1); 
					String saveName = fileItem.getName().substring(idx + 1);
									
					//파일이 업로드 되었나 안되었나 체크 size>0이면 업로드 성공
					if (fileItem.getSize() > 0) {
						String fileName = fileItem.getName();
						String fieldName = fileItem.getFieldName();
						String contentType = fileItem.getContentType();
						boolean isInMemory = fileItem.isInMemory();
						long sizeInBytes = fileItem.getSize();
						
						ImageDto dto = new ImageDto();	
						try {
							//실제 디렉토리에 fileName으로 카피 된다.
							File uploadedFile = new File(realDir, fileName);
							//------
							//올릴려는 파일과 같은 이름이 존재하면 중복파일 처리 
				            if ( uploadedFile.exists() == true ){ 
				                for(int k=0; true; k++){ 
				                    //파일명 중복을 피하기 위한 일련 번호를 생성하여 
				                    //파일명으로 조합 
				                    uploadedFile = new File(realDir, "("+k+")"+filename); 
				                    //조합된 파일명이 존재하지 않는다면, 일련번호가 
				                    //붙은 파일명 다시 생성 
				                    //존재하지 않는 경우 
				                    // !을 이용해 false일 경우 참으로 처리되도록 변환 
				                    if(!(uploadedFile.exists() == true)){  
				                        saveName = "("+k+")"+filename; 
				                        break; 
				                    } 
				                }
				                System.out.println("실제 이름 : "+filename);
				                System.out.println("저장된 이름 : "+saveName);
				                
				                
				                
				            } 
			                dto.setBoard_id(board_id);
			                dto.setOrigin_name(filename);
			                dto.setSave_name(saveName);
			                
							// storage 폴더에 파일명 저장	
							fileItem.write(uploadedFile);
							
			               	ImageDao dao = new ImageDao();
			                dao.insertImage(dto);
			                
							//카피 완료후 temp폴더의 temp파일을 제거
							fileItem.delete();
							
							response.sendRedirect("../main.jsp");
						} catch (Exception e) {
							System.out.println(e.getMessage());
						}
					}
				}
			}
		} else {
			out.println("인코딩 타입이 multipart/form-data 가 아님.");
		} 
	%>
</body>
</html>