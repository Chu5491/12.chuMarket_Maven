/* ***************************************************
 *	�ۼ��� : �߰��
 *	�ۼ��� : 2024-03-29
 *	��  �� : ����÷�θ� ���� ���� ������ �ۼ�
 *************************************************** */
package com.model2.mvc.service.domain;

import org.springframework.web.multipart.MultipartFile;

public class Upload 
{
	///�ʵ�
    private String fileDir;
    private MultipartFile file;
	private int fileNo;
	private int prodNo;
	private String physName;
	private String logiName;
	
	
	///������
	public Upload()
	{
		System.out.println("File Domain Constructor......");
	}
	
	///�޼ҵ�
	//======== Getter ========
	public int getFileNo() 
	{
		return fileNo;
	}
	
	public int getProdNo() 
	{
		return prodNo;
	}
	
	public String getPhysName() 
	{
		return physName;
	}
	
	public String getLogiName()
	{
		return logiName;
	}
	
	public String getFileDir()
	{
		return fileDir;
	}
	
	public MultipartFile getFile()
	{
		return file;
	}
	
	//======== Setter ========
	public void setLogiName(String logiName) 
	{
		this.logiName = logiName;
	}
	public void setFileNo(int fileNo)
	{
		this.fileNo = fileNo;
	}
	public void setPhysName(String physName) 
	{
		this.physName = physName;
	}
	public void setProdNo(int prodNo) 
	{
		this.prodNo = prodNo;
	}
	public void setFileDir(String fileDir) 
	{
		this.fileDir = fileDir;
	}
	public void setFile(MultipartFile file) 
	{
		this.file = file;
	}

	//======== toString ========
	@Override
	public String toString() 
	{
		return "File [fileDir=" + fileDir + ", fileNo=" + fileNo + ", prodNo=" + prodNo + ", physName=" + physName
				+ ", logiName=" + logiName + "]";
	}
	
}
