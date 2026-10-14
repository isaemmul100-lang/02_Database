-- SELECT
-- 테이블의 데이터를 조회할 때 사용

-- select (조회할칼럼) from (조회할 테이블);
select menu_name
from tbl_menu;
select *
from tbl_menu;
-- 모든 컬럼을 조회하겠다.


-- 여러 열의 데이터 검색
select menu_code as 코드,
       menu_name as 이름,
       menu_price as 가격
from tbl_menu;

-- select 연산
select 5 + 5;

-- 내장함수
-- as : 칼럼의 별칭을 지정할 수 있다.
select now() as time; -- 결과칼럼명을 수정

select concat('B.', 'ear') as name;

