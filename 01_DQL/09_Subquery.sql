-- SUBQUERY
-- 다른 SQL문 안에 작성하는 Select 문
-- 서브쿼리의 결과를 메인쿼리의 조건이나 조회 대상
-- FROM 절에 서브쿼리를 작성할 경우 별칭 필수!

-- 서브쿼리
select category_code
from tbl_menu
where menu_name = '민트미역국';

-- 메인쿼리
select *
from tbl_menu
where category_code = (select category_code
                       from tbl_menu
                       where menu_name = '민트미역국');

-- 다양한 위치에서 서브커리의 활용
-- 1. SELECT 절 (스칼라 서브쿼리) : 한 행, 한 컬럼의 값을 반환하며 조회의 결과를 컬럼처럼 사용

select a.menu_code,
       a.menu_name,
       a.menu_price,
       (select b.category_name
        from tbl_category b
        where b.category_code = a.category_code) as category_name
from tbl_menu a;


-- 2. FROM 절 (인라인 뷰/파생테이블) : 서브쿼리의 조회 결과를 하나의 테이블처럼 사용(별칭 필수 지정)
select category_summary.category_code,
       category_summary.menu_count,
       category_summary.avg_price
from (select category_code,
             count(*)                        as menu_count,
             floor(avg(tbl_menu.menu_price)) as avg_price
      from tbl_menu
      group by category_code) as category_summary;


-- WHERE 절 (중첩서브쿼리) : 서브쿼리의 바깥쪽(메인) 쿼리의 조건으로 사용
select menu_code,
       menu_name,
       menu_price
from tbl_menu
where menu_price > (select avg(menu_price)
                    from tbl_menu);


-- HAVING 절
select category_code,
       floor(avg(menu_price)) as avg_price
from tbl_menu
group by category_code
having avg_price > (select avg(menu_price)
                    from tbl_menu);


-- 상관 서브쿼리
-- 내부 쿼리가 외부 쿼리의 값을 참조하는 형태

-- 카테고리별로 평균 가격보다 높은 가격의 메뉴 조회
select menu_code,
       menu_name,
       menu_price,
       category_code,
       orderable_status
from tbl_menu a
where menu_price > (select avg(menu_price)
                    from tbl_menu
                    where category_code = a.category_code);



-- EXISTS()
-- 서브쿼리의 조회 결과가 있으면 true
--  없으면 false
select category_name,
       category_code
from tbl_category a
where exists((select 1
              from tbl_menu b
              where b.category_code = a.category_code));



-- common table expression
-- 파생테이블과 비슷한 개념이고, 코딩 가독성과 재사용성을 위해
select a.menu_name, b.category_name
from tbl_menu a
         join tbl_category b on a.category_code = b.category_code;

-- CTE
with menucate as (select a.menu_name, b.category_name
                  from tbl_menu a
                           join tbl_category b on a.category_code = b.category_code)
select *
from menucate
order by menu_name;