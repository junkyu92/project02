package com.project02.world42.DAO;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project02.world42.DTO.GuestDTO;
import com.project02.world42.DTO.UsersDTO;

@Repository
public class UsersDAO {
	
	@Autowired
	SqlSessionTemplate my;
	
	// 회원가입
	public void create(UsersDTO usersDTO) {
		System.out.println(usersDTO);
		int result = my.insert("users.cr",usersDTO);
	}
	
	// 로그인
	public UsersDTO read(UsersDTO usersDTO) {
		UsersDTO result = my.selectOne("users.re", usersDTO);
		return result;
	}
	// 방명록가기
	public UsersDTO read3(UsersDTO usersDTO) {
		UsersDTO result = my.selectOne("users.re3", usersDTO);
		return result;
	}
	
	// 회원수정
	public int update(UsersDTO usersDTO) {
		int result = my.update("users.up", usersDTO);
		return result;
	}
		
	// 회원 정보 불러오기	
		public UsersDTO read2(UsersDTO usersDTO) {
			UsersDTO dto = my.selectOne("users.re2", usersDTO);
			System.out.println(dto);
			return dto;
		}	
		
	// 탈퇴	
		public int delete(UsersDTO usersDTO) {
			int result = my.delete("users.de", usersDTO);
			System.out.println(usersDTO);
			return result;
		}	
	
	// 아이디 중복 체크	
		public UsersDTO read1(UsersDTO usersDTO) {
			UsersDTO result = my.selectOne("users.re1", usersDTO);
			return result;
		}
}
