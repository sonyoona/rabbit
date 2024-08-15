package dto;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Post implements Serializable {

	private static final long serialVersionUID = -4274700572038677000L;
	
	private long postId;
	private String title;
	private int price;
	private String condition;
	private String description;
	private String filename;
	private LocalDateTime createdAt;
	private String category;
	private String userId;

	public Long getPostId() {
		return postId;
	}

	public Post() {
		this.createdAt = LocalDateTime.now();
	}
	
	public Post(long postId, String title, int price) {
		super();
		this.postId = postId;
		this.title = title;
		this.price = price;
	}

	public void setPostId(Long postId) {
		this.postId = postId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public void setPostId(long postId) {
		this.postId = postId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
}
