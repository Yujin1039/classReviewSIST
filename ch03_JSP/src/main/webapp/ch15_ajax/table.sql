CREATE TABLE todo(
	id number primary key,
	todo varchar2(150) not null,
	created date default sysdate not null,
	completed number(1) default 0 not null -- 할 일 수행 여부 0:미완료, 1: 완료
);
CREATE SEQUENCE todo_seq;