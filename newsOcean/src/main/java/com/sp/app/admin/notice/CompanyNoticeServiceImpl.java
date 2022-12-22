package com.sp.app.admin.notice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.FileManager;
import com.sp.app.common.dao.CommonDAO;

@Service("admin.notice.companyNoticeService")
public class CompanyNoticeServiceImpl implements CompanyNoticeService {
	
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertNotice(CompanyNotice dto, String pathname) throws Exception {
		try {
			long seq = dao.selectOne("adminNotice.seq");
			dto.setCompanyNo(seq);
			
			dao.insertData("adminNotice.insertNotice", dto);
			
			//파일 업로드
			if (! dto.getSelectFile().isEmpty()) {
				for(MultipartFile mf : dto.getSelectFile()) {
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if(saveFilename == null) {
						continue;
					}
					
					String originalFilename = mf.getOriginalFilename();
					long fileSize = mf.getSize();
					
					dto.setOriginalFilename(originalFilename);
					dto.setSaveFilename(saveFilename);
					dto.setFileSize(fileSize);
					
					dao.insertData("adminNotice.insertFile", dto);
					
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("adminNotice.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	

	@Override
	public List<CompanyNotice> listNotice(Map<String, Object> map) {
		List<CompanyNotice> list = null;
		
		try {
			list = dao.selectList("adminNotice.listNotice", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	
	@Override
	public List<CompanyNotice> listNoticeTop() {
		List<CompanyNotice> list = null;
		
		try {
			list = dao.selectList("adminNotice.listNoticeTop");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public void updateHitCount(long companyNo) throws Exception {
		try {
			dao.updateData("adminNotice.updateHitCount", companyNo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	
	@Override
	public CompanyNotice readNotice(long companyNo) {
		CompanyNotice dto = null;
		
		try {
			dto = dao.selectOne("adminNotice.readNotice", companyNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return dto;
	}

	@Override
	public void updateNotice(CompanyNotice dto, String pathname) throws Exception {
		try {
			dao.updateData("adminNotice.updateNotice", dto);
			
			if(! dto.getSelectFile().isEmpty()) {
				for (MultipartFile mf : dto.getSelectFile()) {
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if(saveFilename == null) {
						continue;
					}
					
					String originalFilename = mf.getOriginalFilename();
					long fileSize = mf.getSize();
					
					dto.setOriginalFilename(originalFilename);
					dto.setSaveFilename(saveFilename);
					dto.setFileSize(fileSize);
					
					dao.insertData("adminNotice.insertFile", dto);
					
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	

	@Override
	public void deleteNotice(long companyNo, String pathname) throws Exception {
		try {
			//파일 먼저 지우기
			List<CompanyNotice> listFile = listFile(companyNo);
			if(listFile != null) {
				for(CompanyNotice dto : listFile) {
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			
			//파일 테이블 내용 지우기
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "companyNo");
			map.put("num", companyNo);
			deleteFile(map);
			
			dao.deleteData("adminNotice.deleteNotice", companyNo);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void insertFile(CompanyNotice dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<CompanyNotice> listFile(long companyNo) {
		List<CompanyNotice> list = null;
		
		try {
			list = dao.selectList("adminNotice.listFile", companyNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	

	@Override
	public CompanyNotice readFile(long fileNo) {
		CompanyNotice dto = null;
		
		try {
			dto = dao.selectOne("adminNotice.readFile", fileNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("adminNotice.deleteFile", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
}
