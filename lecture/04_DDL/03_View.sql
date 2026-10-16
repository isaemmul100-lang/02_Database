-- VIEW
-- select문을 이름과 함께 저장해서 테이블처럼 사용하는 가상 테이블

-- 장점
-- 복잡한 select 문을 단순하게 재사용 가능하다.
-- 사용자에게 필요한 컬럼과 행만 공개할 수 있다.

create view hansik as
select menu_code,
       menu_name,
       menu_price,
       category_code,
       orderable_status
from tbl_menu
where category_code = 4
with check option; -- view 입력, 수정을 행이 view의 where 조건을 만족하도록 검사

select *
from hansik;

-- view가 아닌 원래 테이블에 추가하면 view에도 자동으로 추가됨
insert into tbl_menu (menu_name, menu_price, category_code, orderable_status)
values ('뷰확인용 닭칼국수 김밥', 5000, 4, 'Y');


set @menu_code = last_insert_id(); -- 변수처럼 사용 가능_마지막 code 번호 @menu_code에 저장해서 변수처럼 사용

select *
from hansik
where menu_code = @menu_code;

-- 테스트 데이터 삭제
delete
from tbl_menu
where menu_code = @menu_code;


-- VIEW를 통해 DML
insert into hansik (menu_name, menu_price, category_code, orderable_status)
values ('뷰확인용 닭칼국수 김밥', 5000, 4, 'Y');

-- with check option으로 view의 where절의 조건을 만족하지 못해 생성불가_category_code가 4인 것만 가능
insert into hansik (menu_name, menu_price, category_code, orderable_status)
values ('뷰확인용 락토핏 에이드', 5000, 5, 'Y');

select *
from hansik;

set @menu_code = last_insert_id();

-- VIEW를 통해 저장한 데이터도 원본 테이블에서 확인 가능
select *
from hansik
where menu_code = @menu_code;

select *
from tbl_menu
where menu_code = @menu_code;

-- DML문이 제한되는 VIEW
-- DISTINCT, GROUP BY (HAVING), 집계 함수, UNION, 계산식
-- 여러 테이블을 JOIN 했을 경우 (VIEW 정의를 어떻게 헀느냐, VIEW에서 어떤 컬럼을 변경하려고 하느냐)

CREATE VIEW category_menu_summary AS
SELECT category_code,
       COUNT(*)               AS menu_count,
       FLOOR(AVG(menu_price)) AS avg_price
FROM tbl_menu
GROUP BY category_code;

update category_menu_summary
set avg_price = 10000
where category_code = 4;


-- VIEW 재정의 (원래 있는 VIEW를 재정의한 것)
select * from hansik;

create or replace view hansik as
select a.menu_code,
       a.menu_name,
       truncate(a.menu_price / 1000, 1) as price_in_thousands,
       b.category_name
from tbl_menu a
         join tbl_category b on a.category_code = b.category_code
where b.category_code = 4;

-- VIEW 삭제
drop view if exists category_menu_summary;
# select * from category_menu_summary; 삭제됐나 확인용

show full tables
where table_type = 'view';