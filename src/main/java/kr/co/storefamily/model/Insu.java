package kr.co.storefamily.model;

public class Insu {

	private int bno;
	private String title;
	private String name;
	private String content;
	private String day;
	private String time;
	private int chk;
	private int viewcnt;
	private String code;
	private String id;
	private int reply_chong;
	private String ch_member_id;
	private String insu_img;

	//답글(추가)
	private int insu_bno;
	private String sign_day;

	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public int getChk() {
		return chk;
	}
	public void setChk(int chk) {
		this.chk = chk;
	}
	public int getViewcnt() {
		return viewcnt;
	}
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public int getReply_chong() {
		return reply_chong;
	}
	public void setReply_chong(int reply_chong) {
		this.reply_chong = reply_chong;
	}

	public String getCh_member_id() {
		return ch_member_id;
	}
	public void setCh_member_id(String ch_member_id) {
		this.ch_member_id = ch_member_id;
	}

	public String getInsu_img() {
		return insu_img;
	}
	public void setInsu_img(String insu_img) {
		this.insu_img = insu_img;
	}
	public int getInsu_bno() {
		return insu_bno;
	}
	public void setInsu_bno(int insu_bno) {
		this.insu_bno = insu_bno;
	}
	public String getSign_day() {
		return sign_day;
	}
	public void setSign_day(String sign_day) {
		this.sign_day = sign_day;
	}


}
