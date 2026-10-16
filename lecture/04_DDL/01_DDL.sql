-- DDL (Data Definition Language) 데이터 정의어
-- 데이터베이스의 구조를 생성, 변경, 초기화, 삭제할 때 사용

-- CREATE   : 새로운 객체를 생성한다.
-- ALTER    : 기존 객체의 구조를 변경
-- TRUNCATE : 데이블의 구조는 유지하고 모든행을 삭제
-- DROP     : 객체의 구조와 데이터를 모두 삭제

-- 테이블 생성
-- if not exists : 해당 테이블이 없을 때 생성해줌. (이게 없을 경우 있는 칼럼 생성시 오류남)
create table if not exists tb1
(
    pk   int,
    fk   int,
    col1 varchar(255),
    check ( col1 in ('Y', 'N') ) -- 제약조건
);

describe tb1; -- 테이블의 구조를 알 수 있음
insert into tb1 ()
values (1, 10, 'Y');

select *
from tb1;

-- tb2
-- auto_increment : 행을 추가할 때 자동으로 번호를 생성해주는 기능
-- Primary Key 또는 Unique Key가 설정된 컬럼에 사용
create table if not exists tb2
(
    pk   int auto_increment primary key,
    fk   int,
    col1 varchar(255),
    check ( col1 in ('Y', 'N') ) -- 제약조건
);

describe tb2;

insert into tb2
values (null, 10, 'Y'),
       (null, 10, 'Y');

select *
from tb2;



-- 수정

-- 컬럼 추가
alter table tb2
    add column col2 int not null default 0; -- default : 기본값 설정
describe tb2;
-- 확인

-- 컬럼 삭제
alter table tb2
    drop column col2;
describe tb2;
-- 확인

-- 컬럼 수정
-- 이름, 걸럼 정의(데이터타입, 제약조건)
alter table tb2 -- 이름을 바꾸면서 데이터 타입, 제약조건 다시 작성
    change column fk change_fk BIGINT not null;
describe tb2; -- 확인

alter table tb2 -- 이름은 변경하지 않고 데이터 타입, 제약조건 다시 작성
    modify column change_fk int;
describe tb2; -- 확인

alter table tb2 -- 이름만 변경
    rename column change_fk to fk;
describe tb2; -- 확인


-- PRIMARY KEY 제약조건 삭제 및 추가
-- auto_increment 컬럼 : KEY로 추가가 되어있어야함
# alter table tb2 drop primary key ;

alter table tb2
    modify column pk int not null; -- auto_increment 삭제
describe tb2;
alter table tb2
    drop primary key;


alter table tb2
    add primary key (pk);
describe tb2;

alter table tb2
    modify column pk int not null auto_increment;
-- auto_increment 추가


-- 삭제
create table if not exists tb3
(
    pk   int auto_increment primary key,
    fk   int,
    col1 varchar(255),
    check ( col1 in ('Y', 'N') ) -- 제약조건
)
    comment '삭제할 tb3입니다.';

drop table if exists tb3;

create table if not exists tb3
(
    pk   int auto_increment primary key,
    fk   int,
    col1 varchar(255),
    check ( col1 in ('Y', 'N') ) -- 제약조건
);
create table if not exists tb4
(
    pk   int auto_increment primary key,
    fk   int,
    col1 varchar(255),
    check ( col1 in ('Y', 'N') ) -- 제약조건
);
create table if not exists tb5
(
    pk   int auto_increment primary key,
    fk   int,
    col1 varchar(255),
    check ( col1 in ('Y', 'N') ) -- 제약조건
);

drop table if exists tb3, tb4, tb5;


-- Truncate
-- 테이블 구조는 유지하면서 모든 행(데이터)는 전부 삭제한다.
-- Auto_increment의 값도 초기화됨 (1,2,3 있다가 3 삭제하면 3자리에 4가 생기는 경우는 초기화 안 된 경우)
create table if not exists tb3
(
    pk   int auto_increment primary key,
    fk   int,
    col1 varchar(255),
    check ( col1 in ('Y', 'N') ) -- 제약조건
);
insert into tb3 (fk, col1)
values (10, 'Y'),
       (20, 'Y'),
       (30, 'Y'),
       (40, 'Y'),
       (50, 'Y');

select * from tb3;

delete from tb3 where pk = 5; -- pk = 5 삭제

insert into tb3 (fk, col1)
values (50, 'Y'); -- pk = 6 으로 생성

truncate table tb3; -- 모든 데이터 삭제

-- DELETE / TRUNCATE / DROP 정리
-- DELETE : 선택한 행 삭제하기 위해 사용
-- TRUNCATE : 테이블 구조를 초기화 해 행을 삭제하기 위해 사용
-- DROP : 모든 행과 구조 삭제