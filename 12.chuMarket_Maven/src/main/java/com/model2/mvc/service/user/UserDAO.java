package com.model2.mvc.service.user;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;

public interface UserDAO 
{
	public int addUser(User user) throws Exception;

	public User getUser(String userId) throws Exception;

	public List<User> getUserList(Search search) throws Exception;

	public void updateUser(User user) throws Exception;
	
	public int getUserTotal(Search search) throws Exception;
}
