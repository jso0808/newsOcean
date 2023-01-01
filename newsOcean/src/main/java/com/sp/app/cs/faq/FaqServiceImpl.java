package com.sp.app.cs.faq;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("cs.faq.faqService")
public class FaqServiceImpl implements FaqService {
	@Autowired
	private CommonDAO dao;

	@Override
	public void insertFaq(Faq dto) throws Exception {
		try {
			dao.insertData("cs.faq.insertFaq", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Faq> listFaq(Map<String, Object> map) {
		List<Faq> list = null;

		try {
			list = dao.selectList("cs.faq.listFaq", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("cs.faq.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public Faq readFaq(long num) {
		Faq dto = null;
		
		try {
			dto = dao.selectOne("cs.faq.readFaq", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateFaq(Faq dto) throws Exception {
		try {
			dao.updateData("cs.faq.updateFaq", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteFaq(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("cs.faq.deleteFaq", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertCategory(Faq dto) throws Exception {
		try {
			dao.insertData("cs.faq.insertCategory", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateCategory(Faq dto) throws Exception {
		try {
			dao.updateData("cs.faq.updateCategory", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Faq> listCategory(Map<String, Object> map) {
		List<Faq> listCategory = null;
		
		try {
			listCategory = dao.selectList("cs.faq.listCategory", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listCategory;
	}

	@Override
	public void deleteCategory(long categoryNum) throws Exception {
		try {
			dao.deleteData("cs.faq.deleteCategory", categoryNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
