package com.model2.mvc.service.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.user.dao.UserDAO;
import com.model2.mvc.service.domain.User;

@Service("userServiceImpl")
public class UserServiceImpl implements UserService
{
	@Autowired
	@Qualifier("userDAO")
	private UserDAO userDAO;
	
	public UserServiceImpl() 
	{
		userDAO = new UserDAO();
	}

	public int addUser(User user) throws Exception 
	{
		return userDAO.addUser(user);
	}

	public User loginUser(User user) throws Exception 
	{
		User dbUser = userDAO.getUser(user.getUserId());
		if(! dbUser.getPassword().equals(user.getPassword()))
			throw new Exception("로그인에 실패했습니다.");
		
		return dbUser;
	}

	public User getUser(String userId) throws Exception 
	{
		return userDAO.getUser(userId);
	}

	public Map<String, Object> getUserList(Search search) throws Exception 
	{
		List<User> list= userDAO.getUserList(search);
		int totalCount = userDAO.getUserTotal(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	public void updateUser(User user) throws Exception 
	{
		userDAO.updateUser(user);
	}
	
	public int getUserTotal(Search search) throws Exception 
	{
		return userDAO.getUserTotal(search);
	}

	public boolean checkDuplication(String userId) throws Exception 
	{
		boolean result=true;
		User user = userDAO.getUser(userId);
		if(user != null) 
		{
			result = false;
		}
		return result;
	}
}