USE mysns;

INSERT INTO user VALUES("kim", "111", "김시민", now(),"01015540923","kim@abc.com",1,1);
INSERT INTO user VALUES("lee", "111", "이순신", now(),"01015450428", "lee@abc.com",110,2);
INSERT INTO user VALUES("kwon", "111", "권율", now(),"01015371228","kwon@abc.com",210,3);
INSERT INTO user VALUES("test", "test", "테스트", now(),"01012345678","test@aaa.com",0,0);


INSERT INTO feed(id, content) VALUES("kim", "Hello");
INSERT INTO feed(id, content) VALUES("kwon", "Aloha");