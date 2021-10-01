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

	// ���̾ �� �����
	public void diaryBookCreate(DiaryBookDTO diaryBookDTO) {
		mybatis.insert("diarybook.create", diaryBookDTO);
	}

	// ���̾ �� ��� �ҷ�����
	public List<DiaryBookDTO> diaryBookAllRead(DiaryBookDTO diaryBookDTO) {
		return mybatis.selectList("diarybook.readAll", diaryBookDTO);
	}
	
	// ���̾ �� �ϳ� �ҷ�����
	public DiaryBookDTO diaryBookOneRead(DiaryBookDTO diaryBookDTO) {
		return mybatis.selectOne("diarybook.readOne", diaryBookDTO);
	}

	// ���̾ �� Ÿ��Ʋ ����
	public void diaryTitleUpdate(DiaryBookDTO diaryBookDTO) {
		mybatis.update("diarybook.updateTitle", diaryBookDTO);
	}

	// ���̾ �� ����
	public void diaryBookTerminate(DiaryBookDTO diaryBookDTO) {
		mybatis.delete("diarybook.terminate", diaryBookDTO);
	}

	// ���̾ ������ Ư�� ��¥ ��� �ҷ�����
	public List<DiaryPageDTO> diaryPageAllRead(DiaryPageDTO diaryPageDTO) {
		return mybatis.selectList("diarypage.readAll", diaryPageDTO);
	}

	// ���̾ ������ �ϳ� �ҷ�����
	public DiaryPageDTO diaryPageOneRead(DiaryPageDTO diaryPageDTO) {
		return mybatis.selectOne("diarypage.readOne", diaryPageDTO);
	}

	// ���̾ ������ �� ���
	public void diaryPageAdd(DiaryPageDTO diaryPageDTO) {
		mybatis.insert("diarypage.add", diaryPageDTO);
	}

	// ���̾ ������ �� ����
	public void diaryPageDelete(DiaryPageDTO diaryPageDTO) {
		mybatis.delete("diarypage.delete", diaryPageDTO);
	}

	// ���̾ ������ �� ����
	public void diaryPageUpdate(DiaryPageDTO diaryPageDTO) {
		mybatis.update("diarypage.update", diaryPageDTO);
	}
}
