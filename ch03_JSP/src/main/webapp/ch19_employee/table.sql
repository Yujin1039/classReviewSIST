--사원관리
CREATE TABLE semployee(
	num number primary key,
	id varchar2(12) unique not null,
	name varchar2(30) not null,
	passwd varchar2(12) not null,
	salary number(8) not null,
	job varchar2(30) not null,
	reg_date date default sysdate not null
);
CREATE SEQUENCE semployee_seq;

--사원게시판
CREATE TABLE story(
	snum number not null,
	title varchar2(15) not null,
	content clob not null,
	ip varchar2(30) not null,
	num number not null,
	reg_date date default sysdate not null,
	constraint story_pk primary key (snum), -- 기본키
	constraint story_fk foreign key (num) references semployee (num) -- 외래키
);
CREATE SEQUENCE story_seq;