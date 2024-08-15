package dao;

import java.util.ArrayList;

import dto.Post;

public class PostRepository {

	private ArrayList<Post> listOfPosts = new ArrayList<Post>();
	private static PostRepository instance = new PostRepository();
	
	
	public static PostRepository getInstance() {
		return instance;
	}
	
	//더미 데이터
	public PostRepository() {
		Post post1 = new Post(0, "시계", 10000); 
		post1.setCondition("미개봉");
		post1.setDescription("한 번도 착용하지 않은 정말 깨끗한 시계입니다!!!!");
		post1.setCategory("hobby");
		
		Post post2 = new Post(1, "노트북", 2100000);
		post2.setCondition("개봉");
		post2.setDescription("전원만 켜본 정말 깨끗한 노트북입니다!!!!");
		post2.setCategory("etc");
		
		listOfPosts.add(post1);
		listOfPosts.add(post2);
	}
	
	//모든 포스트 리스트 가져오기
	public ArrayList<Post> getAllPosts(){
		return listOfPosts;		
	}

	//특정 ID값 게시물 가져오기
	public Post getPostById(String postId) {
		Post postById = null;
		
		for(int i=0; i < listOfPosts.size(); i++) {
			Post post = listOfPosts.get(i);
			if (post!=null && post.getPostId()!=null && String.valueOf(post.getPostId()).equals(postId)) {
				postById=post;
				break;
			}
		}
		return postById;
	}
	
	public void addPost(Post post) {
		listOfPosts.add(post);
	}
	
	public int getPostsLength() {
		return listOfPosts.size();
	}

}
