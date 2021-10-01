package com.project02.world42;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project02.world42.DAO.GuestDAO;
import com.project02.world42.DTO.GuestDTO;
import com.project02.world42.DTO.UsersDTO;

@Controller
public class GuestController {

	@Autowired
	GuestDAO dao;

	// 방명록 등록
	@RequestMapping("guest.cr")
	public String gjoin(GuestDTO guestDTO) {
		System.out.println(guestDTO);
		dao.create(guestDTO);
		return "redirect:ug.re?memid=" + guestDTO.getOwner();
	} // public void gjoin

	// 방명록 읽어오기
	@ResponseBody
	@RequestMapping(value = "guest1.on", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public List<GuestDTO> list(@ModelAttribute GuestDTO guestDTO) {
		List<GuestDTO> list = dao.read(guestDTO);
		return list;
	} // public List<GuestDTO> list

	// 방명록 삭제
	@ResponseBody
	@RequestMapping(value="gu.de", method=RequestMethod.POST)
	public int delete(GuestDTO guestDTO) {
	    int result = dao.delete(guestDTO);
	    return result;
	} // public void user
	
	// 댓글 등록
	@ResponseBody
	@RequestMapping(value = "com.on", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		public void gcom(@ModelAttribute GuestDTO guestDTO) {
			System.out.println(guestDTO);
			dao.update(guestDTO);
		} // public void gjoin
		
} // GuestController
