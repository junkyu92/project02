package com.project02.world42.DAO;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project02.world42.DTO.PreplyDTO;

@Repository
public class PreplyDAO {
	
	@Autowired
	SqlSessionTemplate myBatis;
	
	public List<PreplyDTO> list(PreplyDTO preplyDTO) {
		System.out.println(preplyDTO);
		List<PreplyDTO> list = myBatis.selectList("preply.all", preplyDTO);
		return list;
	}
	
	public void create(PreplyDTO preplyDTO) {
		System.out.println("-------" + preplyDTO);
		myBatis.insert("preply.add", preplyDTO);
	}
	
	public int delete(PreplyDTO preplyDTO) {
		System.out.println(preplyDTO);
		int result = myBatis.delete("preply.del", preplyDTO);
		return result;
	}
	
	
}
