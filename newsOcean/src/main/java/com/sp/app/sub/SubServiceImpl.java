package com.sp.app.sub;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("sub.subService")
public class SubServiceImpl implements SubService{
	@Autowired
	private CommonDAO dao;
	
	
}
