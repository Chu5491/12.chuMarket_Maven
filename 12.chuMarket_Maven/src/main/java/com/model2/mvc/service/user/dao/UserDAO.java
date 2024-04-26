package com.model2.mvc.service.user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;

@Repository("userDAO")
public class UserDAO implements com.model2.mvc.service.user.UserDAO
{
	///필드
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	///생성자
	public UserDAO()
	{
		System.out.println(this.getClass());
	}

	///메소드
	public int addUser(User user) throws Exception 
	{
		return sqlSession.insert("UserMapper.addUser", user);
	}

	public User getUser(String userId) throws Exception 
	{
		return sqlSession.selectOne("UserMapper.getUser", userId);
	}
	
	public void updateUser(User user) throws Exception 
	{
		sqlSession.update("UserMapper.updateUser", user);
	}
	
	public List<User> getUserList(Search search) throws Exception 
	{
		return sqlSession.selectList("UserMapper.getUserList", search);
	}

	public int getUserTotal(Search search) throws Exception 
	{
		return sqlSession.selectOne("UserMapper.getUserTotal", search);
	}
	
	public SqlSession getSqlSession() 
	{
		return sqlSession;
	}

	public void setSqlSession(SqlSession sqlSession) 
	{
		this.sqlSession = sqlSession;
	}
}