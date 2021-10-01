package com.project02.world42;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project02.world42.DAO.BgmDAO;
import com.project02.world42.DAO.MainDAO;
import com.project02.world42.DAO.PayDAO;
import com.project02.world42.DAO.UsersDAO;
import com.project02.world42.DTO.BgmDTO;
import com.project02.world42.DTO.MainDTO;
import com.project02.world42.DTO.PayDTO;
import com.project02.world42.DTO.UsersDTO;

@Controller
public class PayController {

	@Autowired
	PayDAO dao;
	@Autowired
	MainDAO dao2;
	@Autowired
	BgmDAO dao3;
	@Autowired
	UsersDAO dao4;
	
	//shop페이지 열기
	@RequestMapping("main.shop")
	public String shop(String memid, MainDTO mainDTO, Model model, @RequestParam(value="msg", required=false) String msg) {
		int result = dao.acorn(memid);
		model.addAttribute("result", result);
		MainDTO dto = dao2.mainReadAll(mainDTO); 
		model.addAttribute("main", dto);
		List<BgmDTO> list = dao3.bgmList();
		model.addAttribute("list", list);
		List<PayDTO> list2 = dao.payList(memid);
		model.addAttribute("list2", list2);
		if(msg!=null) {
			model.addAttribute("msg", msg);
		}
		if(dto.getBgm_list()!= null) {
			String[] bgm_list = dto.getBgm_list().split(",");
			model.addAttribute("bgm_list", bgm_list);
		}
		return "shop";
	}
	
	//도토리 결제하기 버튼 클릭 시 결제창으로 이동
	@RequestMapping("pay")
	public String pay(String memid, String paydata, int total, Model model) {
		model.addAttribute("memid", memid);
		model.addAttribute("paydata", paydata);
		model.addAttribute("total", total);
		UsersDTO dto = dao.info(memid);
		model.addAttribute("dto", dto);
		return "acornPay";
	}
	
	//도토리 결제
	@RequestMapping("pay.add")
	public String payCreate(PayDTO payDTO, Model model, RedirectAttributes redirect) {
		int result = dao.create(payDTO);
		int result2 = dao.addAcorn(payDTO);
		String msg = "failed.";
		if(result == 1 && result2 == 1) {
			msg = "success.";
		}
		redirect.addAttribute("msg", msg);
		return "redirect:main.shop?memid="+payDTO.getMemid();
	}
}
