package com.sp.app.news;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("news.newsService")
public class NewsServiceImpl implements NewsService{
	
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private NewsMongoOperations newsMongo;
	
	@Override
	public List<News> listNews() {
		List<News> list = null;
		try {
			// NewsMongoOperations << 구현해야함
			list = newsMongo.listNews();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 몽고DB - 뉴스글 내용 가져오기
	@Override
	public News readNews(String originLink) {
		News dto = null;
		
		try {
			// dto = dao.selectOne("news.readNews", news);
			dto = newsMongo.readNews(originLink);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void insertNewsLike(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("news.insertNewsLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteNewsLike(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("news.deleteNewsLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int newsLikeCount(long newsNo) {
		int cnt = 0;
		try {
			cnt = dao.selectOne("news.newsLikeCount", newsNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public boolean userNewsLiked(Map<String, Object> map) {
		boolean liked = false;
		
		try {
			News dto = dao.selectOne("news.userNewsLiked", map);
			// 공감 데이터가 있다면
			if(dto != null) {
				liked = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return liked;
	}

	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			dao.insertData("news.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list = null;
		
		try {
			list = dao.selectList("news.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		int cnt = 0;
		
		try {
			cnt = dao.selectOne("news.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}

	@Override
	public void deleteReply(Map<String, Object> map) {
		try {
			dao.deleteData("news.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void insertReplyLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("news.insertReplyLike", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void deleteReplyLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("news.deleteReplyLike", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int replyLikeCount(long replyNo) {
		int cnt = 0;
		try {
			cnt = dao.selectOne("news.replyLikeCount", replyNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public void updateHitCount(long newsNo) {
		try {
			dao.insertData("news.updateHitCount", newsNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int complainCount(long replyNo) {
		int cnt = 0;
		
		try {
			cnt = dao.selectOne("news.complainCount", replyNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}

	@Override
	public boolean userReplyComplain(Map<String, Object> map) {
		boolean complain = false;
		
		try {
			Complain dto = dao.selectOne("news.userReplyComplain", map);
			// 신고했던 데이터가 존재하면
			if(dto != null) {
				complain = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return complain;
	}

	@Override
	public void updateReplyShowHide(Map<String, Object> map) {
		try {
			dao.updateData("news.updateReplyHide", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void insertReplyComplain(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("news.insertReplyComplain", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void insertBookMark(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("news.insertBookMark", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteBookMark(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("news.deleteBookMark", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteNews(String originLink) {
		try {
			newsMongo.deleteNews(originLink);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public int readNewsNoFromUrl(String originLink) {
		int newsNo = 0;
		
		try {
			dao.selectOne("news.readNewsNoFromUrl", originLink);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return newsNo;
	}

	

}
