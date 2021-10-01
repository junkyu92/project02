package com.project02.world42.DAO;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project02.world42.DTO.GuestDTO;
import com.project02.world42.DTO.UsersDTO;



@Repository
public class GuestDAO {
	
	@Autowired
	SqlSessionTemplate my;
	
	// 방명록 등록
		public void create(GuestDTO guestDTO) {
			System.out.println(guestDTO);
			int result = my.insert("guest.cr",guestDTO);
		}
		
	// 방명록 불러오기
		public List<GuestDTO> read(GuestDTO guestDTO) {
			List<GuestDTO>list = my.selectList("guest.re", guestDTO);
			System.out.println(list);
			return list;
		}
		
	// 방명록 삭제	
		public int delete(GuestDTO guestDTO) {
			int result = my.delete("guest.de", guestDTO);
			System.out.println(guestDTO);
			return result;
		}
		
	// 댓글 등록
		public void update(GuestDTO guestDTO) {
			System.out.println(guestDTO);
			int result = my.update("guest.up",guestDTO);
		}
				
}
