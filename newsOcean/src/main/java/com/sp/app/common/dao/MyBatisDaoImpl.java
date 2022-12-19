package com.sp.app.common.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dao")
public class MyBatisDaoImpl implements CommonDAO {
	@Autowired
	private SqlSession sqlSession;
	
	private final Logger logger=LoggerFactory.getLogger(getClass());
	
/*	
	public void setSqlSessionTemplate(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
*/
	
	// ******************************************************************
	// 데이터 추가
    public int insertData(String id, Object value) throws Exception {
    	int result = 0;

		try {
			result = sqlSession.insert(id, value);
		} catch (Exception e) {
			logger.error(e.toString());
			
			throw e;
		} finally {
		}
		
		return result;
    }
    
    public int insertData(String id) throws Exception {
    	int result = 0;

		try {
			result = sqlSession.insert(id);
		} catch (Exception e) {
			logger.error(e.toString());
			
			throw e;
		} finally {
		}
		
		return result;
    }
    
	// ----------------------------------------------------
	// 데이터 수정
    public int updateData(String id, Object value) throws Exception {
		int result = 0;
		
		try {
	   	    result = sqlSession.update(id, value);
		} catch (Exception e) {
			logger.error(e.toString());
			
			throw e;
		}
		
		return result;
    }
    
    public int updateData(String id) throws Exception {
		int result = 0;
		
		try {
	   	    result = sqlSession.update(id);
		} catch (Exception e) {
			logger.error(e.toString());
			
			throw e;
		}
		
		return result;
    }
    
	// ----------------------------------------------------
	// 데이터 삭제
	public int deleteData(String id, Object value) throws Exception {
		int result = 0;
		
		try {
			result = sqlSession.delete(id, value);
		} catch (Exception e) {
			logger.error(e.toString());
			
			throw e;
		}

		return result;
    }
	
	public int deleteData(String id) throws Exception {
		int result = 0;
		
		try {
	    	result = sqlSession.delete(id);
		} catch (Exception e) {
			logger.error(e.toString());
			
			throw e;
		}

		return result;
    }
	
	// ----------------------------------------------------
	// 테이블의 하나 이상의 레코드를 SELECT
	public <T> List<T> selectList(String id, Object value) throws Exception {
		List<T> list = null;
		
		try {
			list = sqlSession.selectList(id, value);
		} catch (Exception e) {
			logger.error(e.toString());
			
			throw e;
		}
		
		return list;
	
	}
	public <T> List<T> selectList(String id) throws Exception {
		List<T> list = null;
		
		try {
			list = sqlSession.selectList(id);
		} catch (Exception e) {
			logger.error(e.toString());
			
			throw e;
		}
		
		return list;
	}
	
	// ----------------------------------------------------
	// 테이블의 하나의 레코드를 SELECT
	public <T> T selectOne(String id, Object value) throws Exception {
		try {
			return  sqlSession.selectOne(id, value);
		} catch (Exception e) {
			logger.error(e.toString());
			
			throw e;
		}		
	}

	public <T> T selectOne(String id) throws Exception {
		try {
			return  sqlSession.selectOne(id);
		} catch (Exception e) {
			logger.error(e.toString());
			
			throw e;
		}		
	}
	
	// ----------------------------------------------------
	// 프로시져
	// INSERT, UPDATE, DELETE
	@Override
	public void callUpdateProcedure(String id, Object value) throws Exception{
		try {
			sqlSession.update(id, value);
		} catch (Exception e) {
			logger.error(e.toString());
			
			throw e;
		}
	}

	// SELECT : OUT 파라미터가 SYS_REFCURSOR 이외의 하나의 레코드(INTEGER 등)
	@Override
	public <T> Map<String, T> callSelectOneProcedureMap(String id, Map<String, T> map) throws Exception{
		try {
			// select procedure 결과는 map로 리턴한다.
			sqlSession.selectOne(id, map);
		} catch (Exception e) {
			logger.error(e.toString());
			
			throw e;
		}
		
		return map;
	}
	
	// SELECT : OUT 파라미터가 SYS_REFCURSOR(하나 또는 하나 이상의 레코드)
	public <T> Map<String, T> callSelectListProcedureMap(String id, Map<String, T> map) throws Exception{
		try {
			// select procedure 결과는 map로 리턴한다.
			sqlSession.selectList(id, map);
		} catch (Exception e) {
			logger.error(e.toString());
			
			throw e;
		}
		
		return map;
	}
}
