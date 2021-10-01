package com.project02.world42.DAO;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project02.world42.DTO.PhotoDTO;

@Repository
public class PhotoDAO {
	
	@Autowired
	SqlSessionTemplate myBatis;
	
	public void create(PhotoDTO photoDTO) {
		System.out.println(photoDTO);
		myBatis.insert("photo.create", photoDTO);
		
	}
	
	public void update(PhotoDTO photoDTO) {
		System.out.println(photoDTO);
		myBatis.update("photo.up", photoDTO);
		
	}
	
	public List<PhotoDTO> list(PhotoDTO photoDTO) {
		List<PhotoDTO> list = myBatis.selectList("photo.all", photoDTO);
		System.out.println(list);
		return list;
	}
	
	public int delete(PhotoDTO photoDTO) {
		System.out.println(photoDTO);
		int result = myBatis.delete("photo.del", photoDTO);
		return result;
	}
	
	public PhotoDTO one(PhotoDTO photoDTO) {
		PhotoDTO photoDTO2 = myBatis.selectOne("photo.one", photoDTO);
		System.out.println(photoDTO2);
		return photoDTO2;
	}
	
}
