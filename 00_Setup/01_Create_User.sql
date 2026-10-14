show databases;

use mysql;

-- 계정 생성
use mysql;
-- mysql 데이터베이스 (시스템 데이터베이스)
-- 사용자 계정 및 권한, 타임존, 로그 .. 등을 포함한 데이터베이스

-- 계정 생성 방법
-- create user '사용자이름'@'접속가능한 위치' identified by '비밀번호'
-- ip 지정, 와일드카드(%) 어느 위치에서든 접속을 허용한다., localhost : 현재 컴퓨터에서만
create user 'bear'@'%' identified by 'bear';

-- Database(Schema) 생성
create database menudb;

show databases; -- 스키마 생성 됐는지 확인

-- 모든 권한 부여
# grant all privileges on (권한을 줄 데이터베이스).(권한을 줄 테이블) to '(권한을 줄 계정)'@'범위'
grant all privileges on menudb.* to 'bear'@'%';

show grants for 'bear'@'%'; -- 해당 게정이 가지고 있는 권한 목록 출력

-- select 권한만 부여시
# grant select on (권한을 줄 데이터베이스).(권한을 줄 테이블) to '(권한을 줄 계정)'@'범위'
