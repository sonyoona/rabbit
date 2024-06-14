package dto;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Reply implements Serializable {

	private static final long serialVersionUID = -4274700572038677000L;
	
	private long replyId;
	private String description;
	private String userId;
	private long postId;
	private LocalDateTime createdAt;

	public Long getReplyId() {
		return replyId;
	}

	public Reply() {
		this.createdAt = LocalDateTime.now();
	}

	public Reply(long replyId, String userId, String description, long postId) {
		super();
		this.replyId = replyId;
		this.userId = userId;
		this.description = description;
		this.postId = postId;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public long getPostId() {
		return postId;
	}

	public void setPostId(long postId) {
		this.postId = postId;
	}

	public void setReplyId(long replyId) {
		this.replyId = replyId;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	
}
