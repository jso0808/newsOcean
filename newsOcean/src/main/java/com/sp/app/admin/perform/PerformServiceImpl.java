package com.sp.app.admin.perform;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("admin.perform.performService")
public class PerformServiceImpl implements PerformService {

	@Autowired
	private CommonDAO dao;
	

	@Override
	public List<Perform> chart_sales() {
		List<Perform> list = null;
		
		try {
			list = dao.selectList("adminPerform.chart_sales");
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}


	@Override
	public List<Perform> chart_member() {
		List<Perform> list = null;
		
		try {
			list = dao.selectList("adminPerform.chart_member");
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}


	@Override
	public Perform year_target() {
		Perform dto = null;
		
		try {
			
			dto = dao.selectOne("adminPerform.year_target");
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return dto;
	}

	

}
