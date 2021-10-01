package com.project02.world42.DAO;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project02.world42.DTO.PayDTO;
import com.project02.world42.DTO.UsersDTO;

@Repository
public class PayDAO {
	
	@Autowired
	SqlSessionTemplate my;
	
	public int acorn(String memid) {
		int result = my.selectOne("pay.acorn", memid);
		return result;
	}
	public UsersDTO info(String memid) {
		UsersDTO result = my.selectOne("pay.info", memid);
		return result;
	}
	public int create(PayDTO paydto) {
		int result = my.insert("pay.create", paydto);
		return result;
	}
	public int addAcorn(PayDTO payDTO) {
		int result = my.update("pay.addAcorn", payDTO);
		return result;
	}
	public List<PayDTO> payList(String memid) {
		List<PayDTO> list = my.selectList("pay.list", memid);
		return list;
	}
}
