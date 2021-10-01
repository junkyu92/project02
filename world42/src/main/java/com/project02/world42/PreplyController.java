package com.project02.world42;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project02.world42.DAO.PreplyDAO;
import com.project02.world42.DTO.PreplyDTO;

@Controller
public class PreplyController {

	@Autowired
	PreplyDAO dao;

	@RequestMapping("plist.do")
	public void read(PreplyDTO preplyDTO, Model model) {
		System.out.println("----------" + preplyDTO);
		List<PreplyDTO> list = dao.list(preplyDTO);
		model.addAttribute("list", list);
	}
	
	@ResponseBody
	@RequestMapping(value = "pinsert.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public void create(@ModelAttribute PreplyDTO preplyDTO) {
		System.out.println("==========" + preplyDTO);
		dao.create(preplyDTO);
	}
	
	@RequestMapping("del2.do")
	public String dele(PreplyDTO preplyDTO, HttpServletRequest request) {
		String getmemid = request.getParameter("memid");
		System.out.println(getmemid);
		int result = dao.delete(preplyDTO);
		return "redirect:list.do?memid=" + getmemid;
	}
}