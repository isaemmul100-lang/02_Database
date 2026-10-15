-- DML Data Mainpulation Language
-- 테이블의 데이터를 추가, 수정, 삭제, 조회(DQL)할 때 사용

-- INSERT : 데이터 추가
insert into tbl_menu
values (null, '바나나해장국', 8500, 4, 'Y');


-- null 값이 가능하더나 auto_increament가 있는 컬럼을 제외하고
-- insert 하고 싶은 데이터컬럼을 지정해서 insert 할 수 있다.
insert into tbl_menu (menu_name, menu_price, category_code, orderable_status)
values ('바나나해장국', 8500, 4, 'Y');


-- 컬럼명을 지정해서 값을 넣을 경우에는 데이터 입력 순서를 바꾸어도 된다.
insert into tbl_menu (menu_name, category_code, menu_price, orderable_status)
values ('바나나해장국', 8500, 4, 8500, 'Y');


insert into tbl_menu
values (null, '소시지맛아이스크림', 8500, 3, 'Y'),
       (null, '김치맛아이스크림', 8500, 3, 'Y'),
       (null, '고추참치파르페', 8500, 3, 'Y');

-- UPDATE : 데이터 수정
update tbl_menu -- 테이블 이름
set menu_price    = 6500, -- 수정 사항
    category_code = 5
where menu_code = 38;
-- 수정 대상

-- DELETE : 데이터 삭제
delete
from tbl_menu
where menu_code = 38;


-- 가장 가격이 저렴한 메뉴 2가지 삭제
-- where 조건이 명확 - Safemode
delete
from tbl_menu
order by menu_price
limit 2;

-- where 조건으로 삭제하는 구문
# delete
# from tbl_menu
# where menu_code in (select menu_code
#                     from (select menu_code
#                           from tbl_menu
#                           order by menu_price
#                           limit 2) as target_menu);


-- 다 지워짐
# delete from tbl_menu;


-- REPLACE
-- 데이터를 입력할 때 중복된 데이터는 덮어 쓸 수 있도록 허용해주는 SQL문
replace into tbl_menu
values (1, '소시지맛아이스크림', 6500, 3, 'Y');