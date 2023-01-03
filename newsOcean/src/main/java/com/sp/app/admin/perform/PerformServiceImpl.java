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
	public int todayCount() {
		int result = 0;
		
		try {
			result = dao.selectOne("adminPerform.todayCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	@Override
	public int yesterdayCount() {
		int result = 0;
		
		try {
			result = dao.selectOne("adminPerform.yesterdayCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
		
	@Override
	public List<Perform> listSales() {
		List<Perform> list = null;
		
		try {
			list = dao.selectList("adminPerform.listSales");
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public int toady_sales() {
		int result = 0;
		
		try {
			result = dao.selectOne("adminPerform.toady_sales");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int yesterday_sales() {
		int result = 0;

		try {

			result = dao.selectOne("adminPerform.yesterday_sales");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int month_sales() {
		int result = 0;

		try {

			result = dao.selectOne("adminPerform.month_sales");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int premonth_sales() {
		int result = 0;

		try {

			result = dao.selectOne("adminPerform.premonth_sales");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int year_target() {
		int result = 0;

		try {

			result = dao.selectOne("adminPerform.year_target");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int year_sales() {
		int result = 0;

		try {

			result = dao.selectOne("adminPerform.year_sales");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}


	@Override
	public void update_sales_goals(int golamount) {
		
		try {
			dao.updateData("adminPerform.update_sales_goals", golamount);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public List<Perform> rank_newsHit() {
		List<Perform> list = null;
		
		try {
			list = dao.selectList("adminPerform.rank_newsHit");
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<Perform> rank_newsLike() {
		List<Perform> list = null;
		
		try {
			list = dao.selectList("adminPerform.rank_newsLike");
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

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



	

	

	

}
