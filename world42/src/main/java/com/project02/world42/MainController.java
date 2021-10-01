package com.project02.world42;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project02.world42.DAO.MainDAO;
import com.project02.world42.DAO.MiniroomDAO;
import com.project02.world42.DTO.MainDTO;
import com.project02.world42.module.FileUpload;
import com.project02.world42.module.MainCookie;

@Controller
public class MainController {

	@Autowired
	MainDAO mainDao;
	@Autowired
	MiniroomDAO miniDao;
	@Autowired
	MainCookie cookie;
	@Autowired
	FileUpload fileUpload;
	
	@Autowired
	HttpServletResponse response;
	@Autowired
	HttpServletRequest request;

	
	
	// 로그아웃 버튼 누를 때 
	@RequestMapping("main.logout")
	public String mainLogout(HttpSession session) {
		// 로그가웃 버튼을 누를시 세션이 만료된다.
		session.invalidate();
		// 로그아웃 버튼을 누를시 방문 쿠키가 삭제된다.
		cookie.crushCookie(response);
		return "redirect:index.jsp";
	}
	
	// 09.25 수정
		// 로그인 성공시 -> 메인(미니홈피)로 이동 -> 호출
		@RequestMapping("main.home")
		public void mainRead(MainDTO mainDTO, Model model, HttpSession session) {
			// 로그인시 입력한 memid가 담긴 dto를 넘긴다
			MainDTO dto = mainDao.mainReadAll(mainDTO);
			// 돌려받은 dto를 model에 등록한다
			model.addAttribute("main", dto);
			// 돌려받은 dto의 memid(아이디)를 session에 잡아준다
			session.setAttribute("sessionId", dto.getMemid());
			// 현재 페이지의 mIdx(미니홈피 인덱스)를 입력하여 bakeCookie메서드를 호출한다.
			// 쿠키가 새로 생성되면 true를 반환, 이미 쿠키가 존재해서 새로 만들지 않았다면 false를 반환
			// 새로 생성될 때만 (조건이 true)일 때만 DAO를 호출한다
			if (cookie.bakeCookie(dto.getmIdx(), request, response)) {
				mainDao.mainTodayUp(dto);
			};
		}

	// 본인 미니홈피 말고 다른 사람꺼 들어갈 때
	@RequestMapping("main.others")
	public void mainReadOther(MainDTO mainDTO, Model model) {
		MainDTO dto = mainDao.mainReadAll(mainDTO);
		if (cookie.bakeCookie(dto.getmIdx(), request, response)) {
			mainDao.mainTodayUp(dto);
		};
		model.addAttribute("main", dto);
	}
	
	// 일촌 리스트 읽어오기
	@RequestMapping(value = "main.read1chon", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public List<Map<String, String>> mainRead1chon(@ModelAttribute MainDTO mainDTO) {
		List<Map<String, String>> list = mainDao.mainRead1Chon(mainDTO);
		return list;
	}
	
	// 상대방과 일촌인지 확인하기
	@RequestMapping(value = "main.if1chon", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public boolean mainIf1chon(@ModelAttribute MainDTO mainDTO) {
		// m1chon 문자열에 memid가 존재하면 true를 반환한다.
		boolean if1chon = mainDao.if1chon(mainDTO);
		return if1chon;
	}
	
	// 일촌 맺기
	@RequestMapping(value = "main.add1chon", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public void mainAdd1chon(@ModelAttribute MainDTO mainDTO) {
		mainDao.add1chon(mainDTO);
	}
	
	// 일촌 끊기
	@RequestMapping(value = "main.rmv1chon", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public void mainRmv1chon(@ModelAttribute MainDTO mainDTO) {
		mainDao.rmv1chon(mainDTO);
	}
	
	// 검색창 입력시 검색결과 읽어오는 메서드 (메인에 ajax로 연결됨)
	@RequestMapping(value = "main.search", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public List<Map<String, String>> search(@ModelAttribute MainDTO mainDTO) {
		List<Map<String, String>> list = mainDao.mainSearch(mainDTO);
		return list;
	}
	
	// 미니홈피 타이틀 불러오는 메서드 (메인에 ajax로 연결됨)
	@RequestMapping(value = "main.readTitle", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public MainDTO mainReadTitle(@ModelAttribute MainDTO mainDTO) {
		MainDTO dto = mainDao.readTitle(mainDTO);
		return dto;
	}
	
	// 미니홈피 타이틀 수정하는 메서드 (메인에 ajax로 연결됨)
	@RequestMapping(value = "main.updateTitle", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public void mainUpdateTitle(@ModelAttribute MainDTO mainDTO) {
		mainDao.updateTitle(mainDTO);
	}
	
	// 미니홈피 프로필 불러오는 메서드 (메인에 ajax로 연결됨)
	@RequestMapping(value = "main.readProfile", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public MainDTO mainReadProfile(@ModelAttribute MainDTO mainDTO) {
		MainDTO dto = mainDao.readProfile(mainDTO);
		return dto;
	}
	
	// 미니홈피 메인사진 불러오는 메서드 (메인에 ajax로 연결됨)
	@RequestMapping(value = "main.readPic", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public MainDTO mainReadPic(@ModelAttribute MainDTO mainDTO) {
		MainDTO dto = mainDao.readPic(mainDTO);
		return dto;
	}
	
	// 미니홈피 프로필 수정하는 메서드 (메인에 ajax로 연결됨)
	@RequestMapping(value = "main.updateProfile", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public void mainUpdateProfile(@ModelAttribute MainDTO mainDTO) {
		mainDao.updateProfile(mainDTO);
	}
	
	// 미니홈피 메인사진 수정하는 메서드 (메인에 ajax로 연결됨)
	@RequestMapping(value = "main.updatePic", method = RequestMethod.POST, produces = "application/json; charset=UTF-8", consumes = {"multipart/form-data"})
	@ResponseBody
	public void mainUpdatePic(@RequestParam(value="file") MultipartFile multi, @RequestParam(value="mIdx") int mIdx) {
		// form에 사용자가 선택한 파일이 파라미터 Multipartfile multi에 담겨있다.
		// 이 파일을 입력값으로 fileUpload 클래스의 proUpload 메서드를 호출한다.
		MainDTO dto = fileUpload.proUpload(multi, request);
		// 서버에 저장된 파일명이 담긴 dto에 mIdx를 추가해준 뒤 DAO에게 넘긴다.
		dto.setmIdx(mIdx);
		mainDao.updatePic(dto);
	}
	// 09.25 추가
		// 우측 상단의 bgm, 도토리, 일촌수 가져오기
		@RequestMapping(value = "main.readQty", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
		@ResponseBody
		public MainDTO mainReadQty(@ModelAttribute MainDTO mainDTO) {
			MainDTO dto = mainDao.readQty(mainDTO);
			return dto;
		}
	
}
