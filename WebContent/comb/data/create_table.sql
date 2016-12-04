drop table list;
drop table member;
drop table video_list;
drop table hc;

create table hc(
   hc_id int(11) not null primary key,
   hc_pwd varchar (200) not null,
   hc_title varchar(50),
   member_id varchar(20) null
);

create table video_list(
   video_id int(11) not null,
   video_url varchar(800) not null,
   hc_id int not null,
   foreign key(hc_id) references hc(hc_id) ON DELETE CASCADE,
   primary key(hc_id,video_id)
);
create table member(
   member_n int(11) not null auto_increment primary key,
   member_id varchar(20) not null unique,
   member_pwd varchar(200) not null,
   member_name varchar(20) not null
);
create table list(
   list_n int(11) not null auto_increment primary key,
   list_title varchar(50) not null,
   list_contents varchar(800),
   list_time datetime,
   list_good int(11),
   list_bad int(11),
   hc_id int(11) references hc(hc_id),
   member_id varchar(30) references member(member_id)
);
create table goodbad(
	list_n int(11) references list(list_n),
	member_id varchar(30) references member(member_id)
);
create table comment(
	comment_n int(50) not null auto_increment primary key,
	comment_contents varchar(800),
	comment_time datetime,
	list_n int(11) references list(list_n),
	member_id varchar(30) references member(member_id)

);
create table hc_favorite(
	hc_id int (11) references hc(hc_id),
	member_id varchar(30) references member(member_id)
);
