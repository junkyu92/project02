package com.project02.world42.DAO;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project02.world42.DTO.MiniroomDTO;
import com.project02.world42.DTO.UsersDTO;

@Repository
public class MiniroomDAO {

	@Autowired
	SqlSessionTemplate mybatis;
	
	public void miniCreate(UsersDTO usersDTO) {
		// 가입하는 동시에 miniroom 테이블에 해당 midx의 레코드 생성
		mybatis.insert("mini.insert", usersDTO);
	}
	
	public MiniroomDTO miniRead(MiniroomDTO miniroomDTO) {
		MiniroomDTO dto = mybatis.selectOne("mini.readRoom", miniroomDTO);
		return dto;
	}
	
	public void miniUpdate(MiniroomDTO miniroomDTO) {
		mybatis.update("mini.update", miniroomDTO);
	}
	
}
