package com.model2.mvc.service.upload.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.service.upload.UploadService;
import com.model2.mvc.service.upload.dao.UploadDAO;
import com.model2.mvc.service.domain.Upload;

@Service("uploadServiceImpl")
public class UploadServiceImpl implements UploadService
{
	///필드
	@Autowired
	@Qualifier("uploadDAO")
	private UploadDAO uploadDAO;

	///생성자
	public UploadServiceImpl() 
	{
		
	}
	
	///메소드
	public void addUpload(Upload upload)
	{
		uploadDAO.addUpload(upload);
	}
	
	public Upload getUpload(int prodNo)
	{
		return uploadDAO.getUpload(prodNo);
	}
	
	public void updateUpload(Upload upload)
	{
		uploadDAO.updateUpload(upload);
	}
}

