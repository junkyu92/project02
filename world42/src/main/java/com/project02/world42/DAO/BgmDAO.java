package com.project02.world42.DAO;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project02.world42.DTO.BgmDTO;
import com.project02.world42.DTO.MainDTO;

@Repository
public class BgmDAO {
	
	@Autowired
	SqlSessionTemplate my;
	
	public List<BgmDTO> bgmList() {
		List<BgmDTO> list = my.selectList("bgm.list");
		return list;
	}
	
	public int bgmAdd(MainDTO mainDTO) {
		int result1 = my.update("bgm.add", mainDTO);
		int result2 = my.update("bgm.pay", mainDTO);
		int result = result1 + result2;
		return result;
	}
}
