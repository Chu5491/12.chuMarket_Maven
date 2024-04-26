package com.model2.mvc.service.upload.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.service.domain.Upload;

@Repository("uploadDAO")
public class UploadDAO implements com.model2.mvc.service.upload.UploadDAO
{
	///필드
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	///생성자
	public UploadDAO()
	{
		System.out.println(this.getClass());
	}
	
	///메소드
	public void addUpload(Upload upload)
	{
		sqlSession.insert("UploadMapper.addUpload", upload);
	}
	
	public Upload getUpload(int prodNo)
	{
		return sqlSession.selectOne("UploadMapper.getUpload", prodNo);
	}
	
	public void updateUpload(Upload upload)
	{
		sqlSession.update("UploadMapper.updateUpload", upload);
	}
	
}