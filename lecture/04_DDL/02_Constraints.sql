-- 제약조건
-- 데이블의 잘못된 데이터가 저장되지 않도록 컬럼에 규칙을 정한다.

-- 컬럼레벨 정의 : 컬럼 선언 바로 뒤에 제약조건을 작성
-- 테이블레벨 정의 : 모든 컬럼 선언 뒤에 제약조선 작성
-- 복합키나 제약조건 이름을 명시할 때는 테이블레벨 정의를 쓴다.

-- NOT NULL : NULL 저장 방지
-- UNIQUE   : 중복값 저장 방지
-- PRIMARY KEY : 행의 고유 식별자 정의

drop table if exists user_notnull;

CREATE TABLE user_notnull
(
    user_no   INT,
    user_id   VARCHAR(255) NOT NULL,
    user_pwd  VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender    VARCHAR(3),
    phone     VARCHAR(255) NOT NULL,
    email     VARCHAR(255),
    constraint primary key (user_no)
);

select *
from user_notnull;

INSERT INTO user_notnull
    (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
       (2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

-- insert 불가(phone의 null값 허용하지 않음)
INSERT INTO user_notnull
    (user_no, user_id, user_pwd, user_name, gender, email)
VALUES (3, 'user01', 'pass01', '홍길동', '남', 'hong123@gmail.com');

describe user_notnull;

-- insert 가능(gender의 null값 허용)
INSERT INTO user_notnull
    (user_no, user_id, user_pwd, user_name, phone, email)
VALUES (1, 'user01', 'pass01', '홍길동', '010-1234-5678', 'hong123@gmail.com');


INSERT INTO user_notnull
    (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES (3, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com');


-- FOREIGN KEY (외래키)
-- 자식테이블의 FOREIGN KEY에는 부모 테이블에 존재하는 값만 저장 가능
-- 부모테이블의 참조 대상 컬럼은 PRIMARY KEY 또는 UNIQUE KEY여야한다.

create table user_fk_table
(
    user_no    int primary key,
    user_id    varchar(50) not null,
    user_name  varchar(50) not null,
    grade_code int,
    constraint foreign key (grade_code) references user_grade (grade_code)
);

-- 참조 테이블 (먼저 만들어야함)
create table user_grade
(
    grade_code int primary key,
    grade_name varchar(50) not null
);

insert into user_grade
values (10, '일반회원'),
       (20, '우수회원'),
       (30, '특별회원');

-- 참조 무결성
-- 자식 테이블의 foreign key에는 부모 테이블에 존재하는 값만 저장 가능
-- (참조 테이블에 grade_code 에 값이 없어서 안 만들어짐)
insert into user_fk_table
values (1, 'user01', '홍길동', 10),
       (2, 'user02', '유관순', 20);

-- user_grade 에 50이 없기 때문에 안 만들어짐
insert into user_fk_table
values (1, 'user01', '홍길동', 50);

-- 자식이 참조중인 부모행은 바로 삭제가 불가능(참조무결성)
delete
from user_grade
where grade_code = 10;
-- 자식의 데이터 중 참조하고 있기 때문에 삭제가 불가능


-- RESTRICT(기본) : 자식이 참조 중이면 부모의 수정-삭제를 거부한다.
-- CASCADE : 부모의 변경을 자식에도 반영한다.
-- SET NULL : 부모가 수정 삭제되면 자식의 외래키를 null로 변경한다. (데이터를 변경하는 거라 위험해서 잘 사용하지 않음)

-- SET NULL
create table user_fk_table
(
    user_no    int primary key,
    user_id    varchar(50) not null,
    user_name  varchar(50) not null,
    grade_code int         null,
    constraint foreign key (grade_code) references user_grade (grade_code)
        on update set null -- 부모가 수정되면 외래키를 null로 변경
        on delete set null -- 부모가 삭제되면 외래키를 null로 변경
);

insert into user_fk_table
values (1, 'user01', '홍길동', 10),
       (2, 'user02', '유관순', 20);

-- grade_code 10 -> 11 로 변경
update user_grade
set grade_code = 11
where grade_code = 10;

-- grade_code 20을 삭제함
delete from user_grade where grade_code = 20;

select * from user_grade;
select * from user_fk_table;


-- CASCADE
create table user_fk_table2
(
    user_no    int primary key,
    user_id    varchar(50) not null,
    user_name  varchar(50) not null,
    grade_code int         null,
    constraint foreign key (grade_code) references user_grade2 (grade_code)
        on update cascade -- 부모의 키가 변경되면 자식의 외래키도 변경
        on delete cascade -- 부모의 행이 삭제되면 자식행도 삭제 (참조한 값만 삭제가 아닌 행 자체가 삭제됨)
);

create table user_grade2
(
    grade_code int primary key,
    grade_name varchar(50) not null
);

insert into user_grade2
values
    (10, '일반회원'),
    (20, '우수회원'),
    (30, '특별회원');

insert into user_fk_table2
values (1, 'user01', '홍길동', 10),
       (2, 'user02', '유관순', 20);

-- grade_code 10 -> 11 로 변경
update user_grade2
set grade_code = 11
where grade_code = 10;

-- grade_code 20을 삭제함
delete from user_grade2 where grade_code = 20;

select * from user_grade2;
select * from user_fk_table2;


-- CHECK : 값의 조건 검사 (조건이 TRUE여야 값을 저장한다.)
-- DEFAULT : 기본값 설정

drop table user_check;
create table user_check
(
    user_no    int primary key,
    user_name  varchar(50) not null,
    gender varchar(3),
    age int default 19,
    constraint ck check ( gender in ('남','여') ),
    constraint ck2 check ( age >= 19 )
);

insert into user_check (user_no, user_name, gender)
values
    (1,'홍길동','남');

insert into user_check (user_no, user_name, gender, age)
values
    (1,'홍길동','남', default); -- default 사용법 : 데이터 넣는 것을 생략해도 되고 default라고 적어도 됨

 -- gender, age의 값이 check에서 벗어난 값이기에 오류가 남
insert into user_check
values
    (2,'홍길동','남자',15);