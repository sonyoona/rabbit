package dao;

import java.util.ArrayList;
import dto.User;

//xml에 사용자 추가
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class userRepository {
	
	private ArrayList<User> listOfUsers = new ArrayList<User>();
	// tomcat-users.xml 파일의 경로
	private static final String TOMCAT_USERS_FILE = "C:\\Users\\sonyo\\workspace_webServer\\Servers\\Tomcat v10.1 Server at localhost-config";
	
	private static userRepository instance = new userRepository();
	
	public userRepository() {
		User user1 = new User("Yoona", "1234");
		user1.setAge(22);
		user1.setEmail("sonyoo0526@naver.com");
		user1.setName("손유나");
		user1.setGender("여성");
		user1.setPhone1("010");
		user1.setPhone2("1111");
		user1.setPhone3("1111");
		//user1.프로필
		user1.setProfile("me.jpg");
		
		User user2 = new User("Jooyoung", "5678");
		user2.setAge(25);
		user2.setEmail("mark117@naver.com");
		user2.setName("김주영");
		user2.setGender("남성");
		user2.setPhone1("010");
		user2.setPhone2("2222");
		user2.setPhone3("2222");
		//user2.profile
		user2.setProfile("choch.jpg");
		
		//add list
		listOfUsers.add(user1);
		listOfUsers.add(user2);
		
		
	}
	
	public static userRepository getInstance() {
		return instance;
	}
	
	public void addUser(User user) {
		listOfUsers.add(user);
		updateUserInTomcatUsersXML(user);
	}
	
	private void updateUserInTomcatUsersXML(User user) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(TOMCAT_USERS_FILE, true))) {
            // 새로운 사용자 정보를 tomcat-users.xml 파일에 추가
            writer.write("<user username=\"" + user.getId() + "\" password=\"" + user.getPw() + "\" roles=\"your_role\"/>\n");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
	
	public ArrayList<User> getAllUser(){
		return listOfUsers;
	}

}
