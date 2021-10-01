package com.project02.world42.DAO;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project02.world42.DTO.MainDTO;
import com.project02.world42.DTO.UsersDTO;

@Repository
public class MainDAO {

	@Autowired
	SqlSessionTemplate mybatis;
	
	// users DAO에 있는 join과 합칠 부분
	public void create(UsersDTO usersDTO) {
		// 가입하는 동시에 main 테이블에 해당 memid의 레코드 생성
		mybatis.insert("main.insert", usersDTO);
	}
	
	public MainDTO mainReadAll(MainDTO mainDTO) {
		MainDTO dto = mybatis.selectOne("main.readAll", mainDTO);
		return dto;
	}
	
	public List<Map<String, String>> mainSearch(MainDTO mainDTO) {
		List<Map<String, String>> list = mybatis.selectList("main.search", mainDTO);
		return list;
	}
	
	public List<Map<String, String>> mainRead1Chon(MainDTO mainDTO) {
		List<Map<String, String>> list = mybatis.selectList("main.read1chon", mainDTO);
		return list;
	}
	
	public void add1chon(MainDTO mainDTO) {
		mybatis.update("main.add1chon", mainDTO);
	}
	
	public void rmv1chon(MainDTO mainDTO) {
		mybatis.update("main.rmv1chon", mainDTO);
	}
	
	public boolean if1chon(MainDTO mainDTO) {
		// sessionId와 memid가 담겨있다
		boolean if1chon = true;
		try {
			MainDTO dto = mybatis.selectOne("main.if1chon", mainDTO);
			if (dto.isIf1chon() == 0) {
				if1chon = false;
			}
		} catch (NullPointerException e){
			if1chon = false;
		}
		return if1chon;
	}
	
	public void mainTodayUp(MainDTO mainDTO) {
		mybatis.update("main.visitUp", mainDTO);
	}
	
	public MainDTO readTitle(MainDTO mainDTO) {
		MainDTO dto = mybatis.selectOne("main.readTitle", mainDTO);
		return dto;
	}
	
	public void updateTitle(MainDTO mainDTO) {
		mybatis.update("main.updateTitle", mainDTO);
	}
	
	public MainDTO readProfile(MainDTO mainDTO) {
		MainDTO dto = mybatis.selectOne("main.readProfile", mainDTO);
		return dto;
	}
	
	public MainDTO readPic(MainDTO mainDTO) {
		MainDTO dto = mybatis.selectOne("main.readPic", mainDTO);
		return dto;
	}
	
	public void updateProfile(MainDTO mainDTO) {
		mybatis.update("main.updateProfile", mainDTO);
	}
	
	public void updatePic(MainDTO mainDTO) {
		mybatis.update("main.updatePic", mainDTO);
	}
	
	// 09.25 추가
		public MainDTO readQty(MainDTO mainDTO) {
			MainDTO dto = mybatis.selectOne("main.readQty", mainDTO);
			return dto;
		}
}
