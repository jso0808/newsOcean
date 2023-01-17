package com.sp.app.mypage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;
import com.sp.app.member.Member;
import com.sp.app.news.News;

@Service("mypage.mypageService")
public class MypageServiceImpl implements MypageService {
	
	@Autowired
	private CommonDAO dao;
//나의 키워드 구독 리스트, 구독리스트 추가,삭제
	@Override
	public List<Keyword> readMyKeyword(Map<String, Object> map) {
		List<Keyword> list = null;
		
		try {
			list = dao.selectList("mypage.readMyKeyword", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	
	@Override
	public void insertMyKeyword(Map<String, Object> map) throws Exception {
	    try {
	    	 dao.insertData("mypage.insertMyKeyword", map);
		    /*for(String s:keywordName) {
		       map.put("keywordName", s);
		       dao.insertData("mypage.insertMyKeyword", map);
		    }*/
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	} 
	@Override
	public void updateMyKeyword(Map<String, Object> map) throws Exception {
		
		try {
			dao.updateData("mypage.updateMyKeyword", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	@Override
	public void deleteMyKeyword(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("mypage.deleteMyKeyword", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	//나의 회원정보 리스트, 수정
	@Override
	public Member readMyInfo(String email) {
		Member member =null;
		
		try {
			member = dao.selectOne("mypage.readMyInfo",email);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return member;
	}
	@Override
	public void updateMyInfo(Member dto) throws Exception {
		try {
			dao.updateData("mypage.updateMyInfo", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	@Override
	public void updateMyInfoPwd(Member dto) throws Exception {
		try {
			dao.updateData("mypage.updateMyInfoPwd", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void deleteMyInfo(Member dto) throws Exception{;
		try {
			dao.updateData("mypage.deleteMyInfo", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	//나의 댓글 리스트, 수정	
	@Override
	public List<Reply> readMyReply(Map<String, Object> map) {
		List<Reply> list = null;
		
		try {
			list = dao.selectList("mypage.listReply", map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public void deleteMyReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("mypage.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	@Override
	public List<QnaReply> readMyQnaReply(Map<String, Object> map) {
		List<QnaReply> list = null;
		
		try {
			list = dao.selectList("mypage.readMyQnaReply", map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	@Override
	public void deleteMyQnaReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("mypage.deleteMyQnaReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	//나의 북마크
	@Override
	public List<Bookmark> readMyBookmark(long memberNo) {
		List<Bookmark> list = null;
		
		try {
			list = dao.selectList("mypage.readMyBookmark", memberNo);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	@Override
	public void deleteMyBookmark(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("mypage.deleteMyBookmark", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public News readNews(News news) {
		News dto = null;
		
		try {
			dto = dao.selectOne("news.readNews", news);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}



}
