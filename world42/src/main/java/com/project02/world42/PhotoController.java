package com.project02.world42;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project02.world42.DAO.MainDAO;
import com.project02.world42.DAO.PhotoDAO;
import com.project02.world42.DAO.PreplyDAO;
import com.project02.world42.DTO.MainDTO;
import com.project02.world42.DTO.PhotoDTO;

@Controller
public class PhotoController {
	
	@Autowired
	FileController fileup;
	
	@Autowired
	PhotoDAO dao;
	
	@Autowired
	MainDAO maindao;
	
	@Autowired
	PreplyDAO dao2;
	
		@RequestMapping(value = "photo3.do", method = RequestMethod.POST, produces = "application/json; charset=UTF-8", consumes = {"multipart/form-data"})
		@ResponseBody
		public void create(@RequestParam(value="file") MultipartFile multi, @RequestParam(value="memid") String memid, @RequestParam(value="phtitle") String phtitle, @RequestParam(value="phcontent") String phcontent) {
			// form에 사용자가 선택한 파일이 파라미터 Multipartfile multi에 담겨있다.
			// 이 파일을 입력값으로 fileUpload 클래스의 proUpload 메서드를 호출한다.
			PhotoDTO dto = fileup.proUpload(multi);
			System.out.println(dto.getPhphoto());
			System.out.println(memid);
			// 서버에 저장된 파일명이 담긴 dto에 mIdx를 추가해준 뒤 DAO에게 넘긴다.
			dto.setMemid(memid);
			dto.setPhtitle(phtitle);
			dto.setPhcontent(phcontent);
			dao.create(dto);
		}
	
	@RequestMapping("up.do")
	public void update(MainDTO mainDTO, Model model, HttpServletRequest request) {
		PhotoDTO photoDTO = new PhotoDTO();
		MainDTO dto = maindao.mainReadAll(mainDTO);
		int getphid = Integer.parseInt(request.getParameter("phid"));
		photoDTO.setPhid(getphid);
		System.out.println(photoDTO.getPhid());
		PhotoDTO photoDTO2 = dao.one(photoDTO);
		model.addAttribute("photoDTO2", photoDTO2);
		System.out.println("----" + photoDTO2.getPhtitle());
		System.out.println("====" + photoDTO2.getPhcontent());
		model.addAttribute("main", dto);
		System.out.println(mainDTO.getMemid());
		
	}
	
	@RequestMapping("up2.do")
	public String update(PhotoDTO photoDTO, HttpServletRequest request) {
		dao.update(photoDTO);
		String getmemid = request.getParameter("memid");
		return "redirect:list.do?memid=" + getmemid;
		
	}
	
	@RequestMapping("list.do")
	public void list(MainDTO mainDTO, Model model) {
		PhotoDTO photoDTO = new PhotoDTO();
		MainDTO dto = maindao.mainReadAll(mainDTO);
		photoDTO.setMemid(mainDTO.getMemid());
		List<PhotoDTO> list = dao.list(photoDTO);
		model.addAttribute("list", list);
		model.addAttribute("main", dto); 
		System.out.println(mainDTO.getMemid());
	}
	@RequestMapping("main.photo")
	public String mainPhoto(MainDTO mainDTO, Model model) {
		MainDTO dto = maindao.mainReadAll(mainDTO);
		model.addAttribute("main", dto);
		return "photo";
	}
	
	@RequestMapping("del.do")
	public String dele(PhotoDTO photoDTO, HttpServletRequest request) {
		String getmemid = request.getParameter("memid");
		System.out.println(getmemid);
		int result = dao.delete(photoDTO);
		return "redirect:list.do?memid=" + getmemid;
	}
	
	@RequestMapping("photo2.do")
	public void photo2(MainDTO mainDTO, Model model) {
		MainDTO dto = maindao.mainReadAll(mainDTO);
		model.addAttribute("main", dto); 
		
	}
	
}
