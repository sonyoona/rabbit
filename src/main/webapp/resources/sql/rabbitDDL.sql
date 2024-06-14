SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Post;
DROP TABLE IF EXISTS reply;
SET FOREIGN_KEY_CHECKS = 1;

drop table User;
drop table reply;
drop table Post;

CREATE TABLE User (
    id varchar(20) NOT NULL,
    pw varchar(20) NOT NULL,
    name varchar(10) NOT NULL,
    email varchar(50) NOT NULL,
    phone varchar(15) NOT NULL,
    age varchar(10),
    create_at datetime DEFAULT CURRENT_TIMESTAMP,
    update_at datetime ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

CREATE TABLE Post (
    postId int AUTO_INCREMENT,
    title varchar(50) NOT NULL,
    price int NOT NULL,
    `condition` varchar(5),
    description text,
    filename varchar(20),
    userId varchar(20) NOT NULL,
    category varchar(10) NOT NULL,
    createdAt datetime DEFAULT CURRENT_TIMESTAMP,
    updateAt datetime ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (postId),
    FOREIGN KEY (userId) REFERENCES User(id) ON DELETE CASCADE
);

CREATE TABLE reply (
    replyId int AUTO_INCREMENT,
    postId int NOT NULL,
    userId varchar(20) NOT NULL,
    content text,
    create_at datetime DEFAULT CURRENT_TIMESTAMP,
    update_at datetime ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (replyId),
    FOREIGN KEY (postId) REFERENCES Post(postId) ON DELETE CASCADE,
    FOREIGN KEY (userId) REFERENCES User(id) ON DELETE CASCADE
);

ALTER TABLE Post ADD FOREIGN KEY (userId) REFERENCES User(id);
ALTER TABLE reply ADD FOREIGN KEY (postId) REFERENCES Post(postId);
ALTER TABLE reply ADD FOREIGN KEY (userId) REFERENCES User(id);

