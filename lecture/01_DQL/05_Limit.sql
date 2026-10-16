-- LIMIT
-- 조회할 행의 갯수를 제한할 때 사용
-- LIMIT (갯수) : 처음부터 지정한 갯수만큼 조회
-- LIMIT (시작위치), (갯수) : 시작위치부터 지정한 갯수만큼 조회

select
    menu_code,
    menu_name,
    menu_price
from tbl_menu
order by menu_price -- 원하는 순서의 일부 행을 조회하려면 order by 먼저 사용
limit 5;


select
    menu_code,
    menu_name,
    menu_price
from tbl_menu
order by menu_price -- 원하는 순서의 일부 행을 조회하려면 order by 먼저 사용
limit 1, 4;