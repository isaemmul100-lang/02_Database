-- GROUP BY
-- 같은 값을 가진 행을 하나의 그룹으로 묶을 때
-- 통계, 집계를 계산할 때 사용
-- HAVING : 그룹화 한 이후에 결과를 필터링할 때 사용
-- WHERE : 그룹화를 하기 전에 데이터를 필터링


select
    category_code as '카테고리 종류',
    count(*)
from tbl_menu
group by category_code;



select
    category_code as '카테고리 종류',
    count(*),
    sum(menu_price),
    avg(menu_price)
from tbl_menu
group by category_code;



-- HAVING
-- 그룹화를 한 이후에 조건을 작성할 때 사용

select
    category_code,
    count(*)
from tbl_menu
group by category_code
having category_code between 5 and 8;



-- ROLLUP
-- 각 그룹에 대한 소계나 총계를 계산하여 resultset에 포함
select
    category_code,
    sum(menu_price)
from tbl_menu
group by category_code
with rollup; -- 총합도 출력됨


-- 먼저나온 컬럼의 총합을 구하고 이후에 나오는 컬럼의 총합을 구함
-- menu_price 기준으로 rollup
select
    menu_price,
    category_code,
    sum(menu_price)
from tbl_menu
group by
    menu_price,
    category_code
with rollup ;

-- category_code 기준 rollup
select
    category_code,
    menu_price,
    sum(category_code)
from tbl_menu
group by
    category_code,
    menu_price
with rollup ;
