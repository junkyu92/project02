package com.project02.world42;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project02.world42.DAO.MainDAO;
import com.project02.world42.DAO.MiniroomDAO;
import com.project02.world42.DAO.UsersDAO;
import com.project02.world42.DTO.GuestDTO;
import com.project02.world42.DTO.MainDTO;
import com.project02.world42.DTO.UsersDTO;

@Controller
public class UsersController {
	
	@Autowired
	UsersDAO dao;
	@Autowired
	MainDAO mainDao;
	@Autowired
	MiniroomDAO miniDao;
	
	
	// 회원가입.
	@RequestMapping("uj.cr")
	public String ujoin(UsersDTO usersDTO) {
		System.out.println(usersDTO);
		dao.create(usersDTO);
		// 가입시 미니홈피 생성
				mainDao.create(usersDTO);
				// 가입시 miniroom 생성
				miniDao.miniCreate(usersDTO);
				return "redirect:index.jsp";
	}
	
	// 로그인.
	@RequestMapping("ul.re")
	public String ulogin(UsersDTO usersDTO, HttpSession session) {
		UsersDTO dto;
		try {
			dto = dao.read(usersDTO);
			session.setAttribute("sessionId", usersDTO.getMemid());	
			return "redirect:main.home?memid=" + dto.getMemid();	
		} catch (Exception e) {
			return "redirect:index.jsp";
		}
		// ${id}: 세션 출력
	}
	
	//방명록가기
	@RequestMapping("ug.re")
	public String ulogin2(MainDTO mainDTO, UsersDTO usersDTO, Model model) {
		UsersDTO dto = dao.read3(usersDTO);
		MainDTO dto2 = mainDao.mainReadAll(mainDTO);
		model.addAttribute("main", dto2);
		return "guest";
		// ${id}: 세션 출력
	}
	
	//회원수정.
	
	@RequestMapping("uc.up")
	public String ucor(UsersDTO usersDTO) {
		int result = dao.update(usersDTO);
		if (result == 1) {
			return "redirect:main.home?memid=" + usersDTO.getMemid();
			
		} else {
			return "redirect:ucor.on?memid=" + usersDTO.getMemid();
		}
	}
	
	// 회원정보 읽어오기
	@RequestMapping("ucor.on")
	public void list(UsersDTO usersDTO, Model model) {
		UsersDTO dto = dao.read2(usersDTO);
		model.addAttribute("dto", dto);
	}
	
	// 탈퇴.
	@RequestMapping("us.de")
	public String user(UsersDTO usersDTO) {
		System.out.println(usersDTO);
		int result = dao.delete(usersDTO);
		
		return "redirect:index.jsp";
	}
	
	// 아이디 중복확인.
	@ResponseBody
	@RequestMapping(value = "uj1.on", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public boolean check2(@ModelAttribute UsersDTO usersDTO) {
		System.out.println(usersDTO);
		UsersDTO dto = dao.read1(usersDTO);
		boolean result = true;
		if (dto != null) {
			 result = false;
		}
		return result;
	}
	
}
