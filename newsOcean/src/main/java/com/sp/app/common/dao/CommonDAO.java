package com.sp.app.common.dao;

import java.util.List;
import java.util.Map;

public interface CommonDAO {
	public int insertData(String id, Object value) throws Exception;
	public int insertData(String id) throws Exception;
	
	public int updateData(String id, Object value) throws Exception;
	public int updateData(String id) throws Exception;
	
	public int deleteData(String id, Object value) throws Exception;
	public int deleteData(String id) throws Exception;
	
	public <T> List<T> selectList(String id, Object value) throws Exception;
	public <T> List<T> selectList(String id) throws Exception;
	
	public <T> T selectOne(String id, Object value) throws Exception;
	public <T> T selectOne(String id) throws Exception;
	
	// INSERT, UPDATE, DELETE 프로시져(IN)
	public void callUpdateProcedure(String id, Object value) throws Exception;
	
	// SELECT(OUT)
	public <T> Map<String, T> callSelectOneProcedureMap(String id, Map<String, T> map) throws Exception;
	public <T> Map<String, T> callSelectListProcedureMap(String id, Map<String, T> map) throws Exception;
}
