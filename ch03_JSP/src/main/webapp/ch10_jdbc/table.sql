CREATE TABLE tboard(
	num number primary key,
	name varchar2(30) not null,
	title varchar2(150) not null,
	passwd varchar2(10) not null,
	content varchar2(4000) not null,
	reg_date date not null
);
CREATE SEQUENCE tboard_seq;