-- 암호화로 인해서 pwd 속성을 수정. --

alter table member modify member_pwd varchar(200) not null;
alter table hc modify hc_pwd varchar(200) not null;
