-- WHERE
-- 조건에 맞는 행만 조회할 때 사용
-- BETWEEN, IN, LIKE

select menu_name,
       menu_price,
       orderable_status
from tbl_menu
where orderable_status = 'Y';

-- menu_price가 13000원인 메뉴의 이름과 가격만 보여주세요
select menu_name,
       menu_price
from tbl_menu
where menu_price = 13000;

-- menu_price가 13000원 보다 작은 메뉴의 이름과 가격만 보여주세요
select menu_name,
       menu_price
from tbl_menu
where menu_price < 13000;

-- menu_price가 13000원이 아닌 메뉴의 이름과 가격만 보여주세요
select menu_name,
       menu_price
from tbl_menu
where menu_price != 13000;


-- 논리연산 AND, OR
select menu_name,
       category_code,
       orderable_status,
       menu_price
from tbl_menu
where orderable_status = 'Y'
  AND category_code = 10
order by menu_price;


-- 우선순위
-- and 연산 먼저 수행됨
select 1 and 0;
select (1 or 0) and 0;
-- or 먼저 수행

-- 메뉴 가격이 10000원 이상 25000원 이하인 데이터들을 menu_price을 오름차순으로 정렬해서 출력하시오
select menu_name,
       menu_price,
       category_code
from tbl_menu
where menu_price >= 10000
  and menu_price <= 25000
order by menu_price;

-- between
select menu_name,
       menu_price,
       category_code
from tbl_menu
where menu_price between 10000 and 25000
order by menu_price;

-- 부정표현 not
select menu_name,
       menu_price,
       category_code
from tbl_menu
where menu_price not between 10000 and 25000
order by menu_price;

-- LIKE 연산자 : 특정 패턴과 일치하는 데이터를 검색할 때 사용함
-- 와일드카드
-- _ : 딱 한 글자
-- % : 글자 수 제한 없음
select menu_name
from tbl_menu
where menu_name like '%마늘%'; -- 중간에 '마늘'이 들어있는 메뉴 이름을 찾아라

select menu_name
from tbl_menu
where menu_name like '_마늘%'; -- 앞에 어떤 한 글자가 오고 '마늘'온 모든 이름을 찾아라


select menu_name
from tbl_menu
where menu_name like '생%';
-- 중간에 '마늘'이 들어있는 메뉴 이름을 찾아라

-- IN : 여러값 중에 하나라도 일치하는지 확인하는 연산자
select menu_name,
       category_code
from tbl_menu
where category_code in (4, 5, 6);

-- 부정표현 not
select menu_name,
       category_code
from tbl_menu
where category_code not in (4, 5, 6)
order by category_code;

-- IS NULL : null값을 확인하는 메서드
select
    category_name,
    ref_category_code
from tbl_category
where ref_category_code is null;

-- 부정표현
select
    category_name,
    ref_category_code
from tbl_category
where ref_category_code is not null;