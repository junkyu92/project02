package com.project02.world42;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project02.world42.DAO.MiniroomDAO;
import com.project02.world42.DTO.MiniroomDTO;

@Controller
public class MiniController {

	@Autowired
	MiniroomDAO dao;
	
	@RequestMapping(value = "mini.read", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public MiniroomDTO read(@ModelAttribute MiniroomDTO miniroomDTO) {
		MiniroomDTO dto = dao.miniRead(miniroomDTO);
		return dto;
	}
	
	@RequestMapping(value = "mini.update", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public void update(@ModelAttribute MiniroomDTO miniroomDTO) {
		dao.miniUpdate(miniroomDTO);
	}
}