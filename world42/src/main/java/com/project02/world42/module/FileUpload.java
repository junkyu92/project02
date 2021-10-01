package com.project02.world42.module;

import java.io.File;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project02.world42.DTO.MainDTO;

@Service
public class FileUpload {

	final String absolutePath;
	
	// 절대 경로를 얻기 위한 ServletContext
	public FileUpload(ServletContext context) {
		// 상대 경로
		String relativePath = "resources/img/mainImg/upload";
		// 절대 경로 
		absolutePath = context.getRealPath(relativePath);
	}
	
	// 컨트롤러에서 넘겨받은 multipartFile multi 파라미터
	public MainDTO proUpload(MultipartFile multi, HttpServletRequest request) {

		// 데이터베이스에 저장될 파일명, 일단 선언 및 초기화
		String savedFile = null;
		
		// 사용자가 올린 이미지가 저장될 서버 디렉토리의 절대 경로를 통해 path를 만들어 준다.
		File path = new File(absolutePath);
		// 만약 디렉토리가 존재하지 않으면 새로 만들어준다. (No such file or directory 에러 방지)
		if (!path.isDirectory()) {
			path.mkdir();
		}

		// 업로드한 파일의 진짜 이름
		String originalFile = multi.getOriginalFilename();

		// uuid는 랜덤한 문자열을 생성해준다.
		// 다른 사용자가 올린 파일의 이름과 같지 않게 original file의 이름과 합쳐서 서버에 저장해야 한다.
		String uid = UUID.randomUUID().toString();

		// 파일의 진짜 이름 + uuid 조합 전에 확장자를 떼어줘야 한다.
		// 마지막 .을 기준으로 오른쪽이 확장자명이다.
		// 확장자가 존재하지 않는다면 반환값은 -1이다.
		int lastIndex = originalFile.lastIndexOf('.');
		// substring 을 이용해 확장자를 제외한 . 왼쪽에 있는 파일명만 가져온다.
		String filename = originalFile.substring(0, lastIndex);

		// 확장자명 String ext, 선언 + 초기화
		String ext = null;
		// 확장자가 없으면, ext에 ""를 추가
		if (lastIndex == -1) {
			ext = "";
		} else {
			// 확장자가 있는 경우 확장자를 .포함해 담아준다.
			ext = "." + originalFile.substring(lastIndex + 1);
		}
		// 저장될 파일 이름 조합 (원래 파일명 + _ + uid + 확장자)
		savedFile = filename + "_" + uid + ext;

		// 파일 디스크에 저장하기
		// 생성자로 미리 구해놓은 절대 경로 디렉토리에 저장한다.
		File serverFile = new File(absolutePath + "/" + savedFile);

		// 파일을 지정된 곳에 저장하게 해준다.
		try {
			multi.transferTo(serverFile);
		} catch (Exception e) {
			e.printStackTrace();
			// 실패시 null로 초기화
			originalFile = null;
			savedFile = null;
		}

		// savedFile을 DTO의 mImg에 set
		// 파일이 없었을 경우 null, 존재할 경우 서버에 저장된 파일명
		MainDTO dto = new MainDTO();
		dto.setmImg(savedFile);

		// 파일명이 저장된 mainDTO 반환
		return dto;
	}

}
