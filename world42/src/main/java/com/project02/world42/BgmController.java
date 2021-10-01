package com.project02.world42;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project02.world42.DAO.BgmDAO;
import com.project02.world42.DTO.MainDTO;

@Controller
public class BgmController {

	@Autowired
	BgmDAO dao;
	
	@RequestMapping("bgm.add")
	public String bgmAdd(MainDTO mainDTO) {
		int result = dao.bgmAdd(mainDTO);
		if (result == 2 ) {
			System.out.println("성공");
		}
		return "redirect:main.shop?memid="+mainDTO.getMemid();
	}
}
