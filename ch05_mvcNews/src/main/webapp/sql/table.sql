CREATE TABLE dailynews(
	num number primary key,
	title varchar2(150) not null,
	writer varchar2(30) not null,
	passwd varchar2(12) not null,
	email varchar2(50) not null,
	article clob not null, --clob: ~4GB
	filename varchar2(400) not null,
	reg_date date default sysdate not null
);
CREATE SEQUENCE dailynews_seq;