package com.sp.app.admin.notice;

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
		// TODO Auto-generated method stub
		
	}

	@Override
	public CompanyNotice readNotice(long companyNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateNotice(CompanyNotice dto, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteNotice(long companyNo, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}
	
}
