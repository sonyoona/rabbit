package dao;

import java.time.LocalDateTime;
import java.util.ArrayList;

import dto.Reply;

public class ReplyRepository {

	private ArrayList<Reply> listOfReplys = new ArrayList<Reply>();
	private static ReplyRepository instance = new ReplyRepository();
	
	public static ReplyRepository getInstance() {
		return instance;
	}
	
	//더미 데이터
	public ReplyRepository() {
		Reply reply1 = new Reply(0, "당근러버", "구매원합니다!", 0);
		Reply reply2 = new Reply(1, "프로당근러","저도 줄서봅니다!", 0);
		Reply reply3 = new Reply(2, "물고기","안녕하세요 구매 원해요~", 1);
		Reply reply4 = new Reply(3, "프로당근러","안녕하세요 저도 구매 원해요~! 쪽지주세요^^", 1);
		
		listOfReplys.add(reply1);
		listOfReplys.add(reply2);
		listOfReplys.add(reply3);
		listOfReplys.add(reply4);
	}

	public ArrayList<Reply> getAllReplysByPostId(long id){
		ArrayList<Reply> listOfReplysByPostId = new ArrayList<Reply>();
		
		for(int i=0; i<listOfReplys.size(); i++) {
			Reply reply = listOfReplys.get(i);
			if(reply != null && reply.getPostId() == id)
				listOfReplysByPostId.add(reply);
		}
		return listOfReplysByPostId;
	}
	
	public void addReply(Reply reply) {
		listOfReplys.add(reply);
	}
	
	public int getReplysLength() {
		return listOfReplys.size();
	}
	
	public int getReplysByPostIdLength(long id) {
		return getAllReplysByPostId(id).size();
	}
}
