package com.project02.world42;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project02.world42.DAO.DiaryDAO;
import com.project02.world42.DAO.MainDAO;
import com.project02.world42.DTO.DiaryBookDTO;
import com.project02.world42.DTO.DiaryPageDTO;
import com.project02.world42.DTO.MainDTO;

@Controller
public class DiaryController {

	@Autowired
	MainDAO maindao;

	@Autowired
	DiaryDAO diarydao;

	// ������ ���̾ �޴� Ŭ���� ���̾ ���� �� �̵�
	@RequestMapping("diaryMainView")
	public String mainDiary(MainDTO mainDTO, Model model, HttpServletRequest request) {
		MainDTO dto = maindao.mainReadAll(mainDTO);
		DiaryBookDTO diaryBookDTO = new DiaryBookDTO();
		diaryBookDTO.setMem_id(mainDTO.getMemid());
		List<DiaryBookDTO> diaryBookList = diarydao.diaryBookAllRead(diaryBookDTO);
		model.addAttribute("main", dto);
		model.addAttribute("diarybook", diaryBookList);
		System.out.println(mainDTO.getMemid());
		return "diaryMain";
	}

	// Ư�� ���̾ ������ �� �̵�
	@RequestMapping("diaryPageView")
	public String diaryPageList(MainDTO mainDTO, Model model, HttpServletRequest request) {
		MainDTO dto = maindao.mainReadAll(mainDTO);
		model.addAttribute("main", dto);

		DiaryBookDTO diaryBookDTO = new DiaryBookDTO();
		diaryBookDTO.setMem_id(mainDTO.getMemid());
		List<DiaryBookDTO> diaryBookList = diarydao.diaryBookAllRead(diaryBookDTO);
		model.addAttribute("diarybook", diaryBookList);

		int getBookid = Integer.parseInt(request.getParameter("bookid"));
		System.out.println("���̾�Ͼ��̵�: " + getBookid);
		DiaryPageDTO diaryPageDTO = new DiaryPageDTO();
		diaryPageDTO.setBook_id(getBookid);
		List<DiaryPageDTO> diaryPageList = diarydao.diaryPageAllRead(diaryPageDTO);
		model.addAttribute("diarypage", diaryPageList);

		return "diaryPage";
	}

	// ���̾ ������ �۾��� �� �̵�
	@RequestMapping("diaryPageWriteView")
	public String diaryWrite(MainDTO mainDTO, Model model, HttpServletRequest request) {
		MainDTO dto = maindao.mainReadAll(mainDTO);
		model.addAttribute("main", dto);

		DiaryBookDTO diaryBookDTO = new DiaryBookDTO();
		diaryBookDTO.setMem_id(mainDTO.getMemid());
		List<DiaryBookDTO> diaryBookList = diarydao.diaryBookAllRead(diaryBookDTO);
		model.addAttribute("diarybook", diaryBookList);

		return "diaryPageWrite";
	}

	// ���̾ ������ ���� �� �̵�
	@RequestMapping("diaryPageUpdateView")
	public String diaryBookUpdate(MainDTO mainDTO, Model model, HttpServletRequest request) {
		MainDTO dto = maindao.mainReadAll(mainDTO);
		model.addAttribute("main", dto);

		DiaryBookDTO diaryBookDTO = new DiaryBookDTO();
		diaryBookDTO.setMem_id(mainDTO.getMemid());
		List<DiaryBookDTO> diaryBookList = diarydao.diaryBookAllRead(diaryBookDTO);
		model.addAttribute("diarybook", diaryBookList);

		int getPageId = Integer.parseInt(request.getParameter("pageid"));
		System.out.println("������ ������ ���̵�: " + getPageId);
		DiaryPageDTO diaryPageDTO = new DiaryPageDTO();
		System.out.println("������ ������: " + diaryPageDTO.getId());
		diaryPageDTO.setId(getPageId);
		System.out.println("������ ������: " + diaryPageDTO.getId());
		DiaryPageDTO diaryPageOne = diarydao.diaryPageOneRead(diaryPageDTO);
		System.out.println("������" + diaryPageDTO.getId() + "�� ����:" + diaryPageOne.getContent());
		System.out.println("������" + diaryPageDTO.getId() + "�� ����:" + diaryPageOne.getTitle());
		model.addAttribute("diarypageone", diaryPageOne);

		return "diaryPageUpdate";
	}

	// ���̾ �� ����� �� �̵�
	@RequestMapping("diaryBookCreateView")
	public String diaryBookCreate(MainDTO mainDTO, Model model, HttpServletRequest request) {
		MainDTO dto = maindao.mainReadAll(mainDTO);
		model.addAttribute("main", dto);

		DiaryBookDTO diaryBookDTO = new DiaryBookDTO();
		diaryBookDTO.setMem_id(mainDTO.getMemid());
		List<DiaryBookDTO> diaryBookList = diarydao.diaryBookAllRead(diaryBookDTO);
		model.addAttribute("diarybook", diaryBookList);

		return "diaryBookCreate";
	}

	// ���̾ �� ���� �� �̵�
	@RequestMapping("diaryBookSetView")
	public String diaryBookSet(MainDTO mainDTO, Model model, HttpServletRequest request) {
		MainDTO dto = maindao.mainReadAll(mainDTO);
		model.addAttribute("main", dto);

		DiaryBookDTO diaryBookDTO = new DiaryBookDTO();
		diaryBookDTO.setMem_id(mainDTO.getMemid());
		List<DiaryBookDTO> diaryBookList = diarydao.diaryBookAllRead(diaryBookDTO);
		model.addAttribute("diarybook", diaryBookList);
		
		int getBookId = Integer.parseInt(request.getParameter("bookid"));
		DiaryBookDTO diaryBookDTO2 = new DiaryBookDTO();
		diaryBookDTO2.setId(getBookId);
		DiaryBookDTO diaryBookOne = diarydao.diaryBookOneRead(diaryBookDTO2);
		model.addAttribute("diarybookone", diaryBookOne);

		return "diaryBookSet";
	}

	// ======================================= �׼�

	
	// ���̾ �� ���� �׼�
	@RequestMapping("diaryBookTerminateAction")
	public String diaryBookTerminateAction(MainDTO mainDTO, HttpServletRequest request) {
		String getMemId = request.getParameter("memid");
		int getBookId = Integer.parseInt(request.getParameter("bookid"));

		System.out.println(getMemId);
		System.out.println(getBookId);
		DiaryBookDTO diaryBookDTO = new DiaryBookDTO();
		diaryBookDTO.setId(getBookId);

		diarydao.diaryBookTerminate(diaryBookDTO);

		return "redirect:diaryMainView?memid=" + getMemId;
	}

	// ���̾ �� Ÿ��Ʋ ���� �׼�
	@RequestMapping("diaryBookTitleUpdateAction")
	public String diaryBookTitleUpdateAction(MainDTO mainDTO, HttpServletRequest request) {
		String getMemId = request.getParameter("mem_id");
		String getTitle = request.getParameter("title");
		int getBookId = Integer.parseInt(request.getParameter("book_id"));
		
		System.out.println(getMemId);
		System.out.println(getTitle);
		DiaryBookDTO diaryBookDTO = new DiaryBookDTO();
		diaryBookDTO.setId(getBookId);
		diaryBookDTO.setTitle(getTitle);
		
		diarydao.diaryTitleUpdate(diaryBookDTO);
		

		return "redirect:diaryBookSetView?memid=" + getMemId + "&bookid=" + getBookId;
	}

	// ���̾ �� ����� �׼�
	@RequestMapping("diaryBookCreateAction")
	public String diaryBookCreateAction(MainDTO mainDTO, HttpServletRequest request) {
		String getMemId = request.getParameter("mem_id");
		String getTitle = request.getParameter("title");

		DiaryBookDTO diaryBookDTO = new DiaryBookDTO();
		diaryBookDTO.setMem_id(getMemId);
		diaryBookDTO.setTitle(getTitle);

		System.out.println(getTitle);
		diarydao.diaryBookCreate(diaryBookDTO);

		return "redirect:diaryMainView?memid=" + getMemId;
	}

	// ���̾ ������ �۾��� �׼�
	@RequestMapping("diaryPageWriteAction")
	public String diaryWriteAction(DiaryPageDTO diaryPageDTO, HttpServletRequest request) {
		diarydao.diaryPageAdd(diaryPageDTO);
		String getBookid = request.getParameter("book_id");
		String getMemid = request.getParameter("mem_id");
		return "redirect:diaryPageView?memid=" + getMemid + "&bookid=" + getBookid;
	}

	// ���̾ ������ �۾��� �信�� �ڷ� ���� �׼�
	@RequestMapping("diaryPageBackAction")
	public String diaryPageBackAction(HttpServletRequest request) {
		String getBookId = request.getParameter("bookid");
		String getMemId = request.getParameter("memid");
		System.out.println();
		return "redirect:diaryPageView?memid=" + getMemId + "&bookid=" + getBookId;
	}

	// ���̾ ������ ���� �׼�
	@RequestMapping("diaryPageDeleteAction")
	public String diaryPageDeleteAction(DiaryPageDTO diaryPageDTO, HttpServletRequest request) {
		int getPageId = Integer.parseInt(request.getParameter("pageid"));
		diaryPageDTO.setId(getPageId);
		diarydao.diaryPageDelete(diaryPageDTO);
		System.out.println("������ ������: " + getPageId);
		return "redirect:diaryPageView?memid=" + request.getParameter("memid") + "&bookid=" + request.getParameter("bookid");
	}

	// ���̾ ������ ������Ʈ �׼�
	@RequestMapping("diaryPageUpdateAction")
	public String diaryUpdateAction(DiaryPageDTO diaryPageDTO, HttpServletRequest request) {
		String getBookid = request.getParameter("bookid");
		String getMemid = request.getParameter("memid");
		int getPageId = Integer.parseInt(request.getParameter("pageid"));
		diaryPageDTO.setId(getPageId);
		System.out.println("�޾ƿ� ������: " + getPageId);
		diarydao.diaryPageUpdate(diaryPageDTO);
		return "redirect:diaryPageView?memid=" + getMemid + "&bookid=" + getBookid;
	}
}
