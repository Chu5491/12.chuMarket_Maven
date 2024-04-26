package com.model2.mvc.service.upload;

import com.model2.mvc.service.domain.Upload;

public interface UploadService 
{
	public void addUpload(Upload upload);
	
	public Upload getUpload(int prodNo);
	
	public void updateUpload(Upload upload);
}

