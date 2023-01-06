package com.sp.app.cs.qna;

public class QnaReply {
	private long qnaAnswer;
	private long qnaNo;
	private long memberNo;
	private String nickName;
	private String qnaAContent;
	private String qnaARegdate;
	private long qnaReply;
	private int showReply;
	
	private int qnaAReplyCount;

	public long getQnaAnswer() {
		return qnaAnswer;
	}

	public void setQnaAnswer(long qnaAnswer) {
		this.qnaAnswer = qnaAnswer;
	}

	public long getQnaNo() {
		return qnaNo;
	}

	public void setQnaNo(long qnaNo) {
		this.qnaNo = qnaNo;
	}

	public long getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(long memberNo) {
		this.memberNo = memberNo;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getQnaAContent() {
		return qnaAContent;
	}

	public void setQnaAContent(String qnaAContent) {
		this.qnaAContent = qnaAContent;
	}

	public String getQnaARegdate() {
		return qnaARegdate;
	}

	public void setQnaARegdate(String qnaARegdate) {
		this.qnaARegdate = qnaARegdate;
	}

	public long getQnaReply() {
		return qnaReply;
	}

	public void setQnaReply(long qnaReply) {
		this.qnaReply = qnaReply;
	}

	public int getShowReply() {
		return showReply;
	}

	public void setShowReply(int showReply) {
		this.showReply = showReply;
	}

	public int getQnaAReplyCount() {
		return qnaAReplyCount;
	}

	public void setQnaAReplyCount(int qnaAReplyCount) {
		this.qnaAReplyCount = qnaAReplyCount;
	}
}
