package com.sp.app.admin.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("admin.main.mainService")
public class MainServiceImpl implements MainService {

	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private RealtimeMongoOperations realtimeMongo;
	
	//몽고디비 - 실시간 크롤링
	@Override
	public List<Realtime> listRealtime() {
		List<Realtime> list = null;
		
		try {
			list = realtimeMongo.listRealtime();
		} catch (Exception e) {
		}
		
		return list;
		
	}
	
	
	@Override
	public int todayCount() {
		int result = 0;
		
		try {
			result = dao.selectOne("adminMain.todayCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	@Override
	public int yesterdayCount() {
		int result = 0;
		
		try {
			result = dao.selectOne("adminMain.yesterdayCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
		
	@Override
	public List<Main> listSales() {
		List<Main> list = null;
		
		try {
			list = dao.selectList("adminMain.listSales");
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public int toady_sales() {
		int result = 0;
		
		try {
			result = dao.selectOne("adminMain.toady_sales");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int yesterday_sales() {
		int result = 0;

		try {

			result = dao.selectOne("adminMain.yesterday_sales");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int month_sales() {
		int result = 0;

		try {

			result = dao.selectOne("adminMain.month_sales");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int premonth_sales() {
		int result = 0;

		try {

			result = dao.selectOne("adminMain.premonth_sales");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int year_target() {
		int result = 0;

		try {

			result = dao.selectOne("adminMain.year_target");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int year_sales() {
		int result = 0;

		try {

			result = dao.selectOne("adminMain.year_sales");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}


	@Override
	public void update_sales_goals(int golamount) {
		
		try {
			dao.updateData("adminMain.update_sales_goals", golamount);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public List<Main> rank_newsHit() {
		List<Main> list = null;
		
		try {
			list = dao.selectList("adminMain.rank_newsHit");
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<Main> rank_newsLike() {
		List<Main> list = null;
		
		try {
			list = dao.selectList("adminMain.rank_newsLike");
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<Main> chart_sales() {
		List<Main> list = null;
		
		try {
			list = dao.selectList("adminMain.chart_sales");
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<Main> chart_member() {
		List<Main> list = null;
		
		try {
			list = dao.selectList("adminMain.chart_member");
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}



	

	

	

}
