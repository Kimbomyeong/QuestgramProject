package data.dto;

import java.sql.Timestamp;

public class CommentDto {
	private String id;
	private String board_id;
	private String user_id;
	private String content;
	private String like_count;
	private String parents_comments_id;
	private Timestamp created_at;
	private Timestamp updated_at;
	private String simpletime;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBoard_id() {
		return board_id;
	}
	public void setBoard_id(String board_id) {
		this.board_id = board_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getLike_count() {
		return like_count;
	}
	public void setLike_count(String like_count) {
		this.like_count = like_count;
	}
	public String getParents_comments_id() {
		return parents_comments_id;
	}
	public void setParents_comments_id(String parents_comments_id) {
		this.parents_comments_id = parents_comments_id;
	}
	public Timestamp getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Timestamp created_at) {
		this.created_at = created_at;
	}
	public Timestamp getUpdated_at() {
		return updated_at;
	}
	public void setUpdated_at(Timestamp updated_at) {
		this.updated_at = updated_at;
	}
	public String getSimpletime() {
		return simpletime;
	}
	public void setSimpletime(String simpletime) {
		this.simpletime = simpletime;
	}	
	
}	
