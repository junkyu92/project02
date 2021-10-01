package com.project02.world42.DAO;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.project02.world42.DTO.DiaryBookDTO;
import com.project02.world42.DTO.DiaryPageDTO;

@Repository
public class DiaryDAO {

	@Autowired
	SqlSessionTemplate mybatis;

	// 다이어리 북 만들기
	public void diaryBookCreate(DiaryBookDTO diaryBookDTO) {
		mybatis.insert("diarybook.create", diaryBookDTO);
	}

	// 다이어리 북 모두 불러오기
	public List<DiaryBookDTO> diaryBookAllRead(DiaryBookDTO diaryBookDTO) {
		return mybatis.selectList("diarybook.readAll", diaryBookDTO);
	}
	
	// 다이어리 북 하나 불러오기
	public DiaryBookDTO diaryBookOneRead(DiaryBookDTO diaryBookDTO) {
		return mybatis.selectOne("diarybook.readOne", diaryBookDTO);
	}

	// 다이어리 북 타이틀 수정
	public void diaryTitleUpdate(DiaryBookDTO diaryBookDTO) {
		mybatis.update("diarybook.updateTitle", diaryBookDTO);
	}

	// 다이어리 북 삭제
	public void diaryBookTerminate(DiaryBookDTO diaryBookDTO) {
		mybatis.delete("diarybook.terminate", diaryBookDTO);
	}

	// 다이어리 페이지 특정 날짜 모두 불러오기
	public List<DiaryPageDTO> diaryPageAllRead(DiaryPageDTO diaryPageDTO) {
		return mybatis.selectList("diarypage.readAll", diaryPageDTO);
	}

	// 다이어리 페이지 하나 불러오기
	public DiaryPageDTO diaryPageOneRead(DiaryPageDTO diaryPageDTO) {
		return mybatis.selectOne("diarypage.readOne", diaryPageDTO);
	}

	// 다이어리 페이지 글 등록
	public void diaryPageAdd(DiaryPageDTO diaryPageDTO) {
		mybatis.insert("diarypage.add", diaryPageDTO);
	}

	// 다이어리 페이지 글 삭제
	public void diaryPageDelete(DiaryPageDTO diaryPageDTO) {
		mybatis.delete("diarypage.delete", diaryPageDTO);
	}

	// 다이어리 페이지 글 수정
	public void diaryPageUpdate(DiaryPageDTO diaryPageDTO) {
		mybatis.update("diarypage.update", diaryPageDTO);
	}
}
