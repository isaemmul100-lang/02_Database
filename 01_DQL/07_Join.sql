-- JOIN
-- 관련 컬럼을 기준으로 여러 테이블의 데이터를 조회할 때 사용

-- JOIN의 종류
-- INNER JOIN : 양쪽 테이블에 모두 존재하는 데이터(행)만 조회
-- LEFT/RIGHT JOIN : 기존 테이블의 일치하지 않는 데이터(행)도 포함


-- INNER JOIN
-- INNER 생략 가능
select a.menu_name, b.category_name
from tbl_menu a
# inner  join tbl_category b
         join tbl_category b
              on -- 조건
                  a.category_code = b.category_code;



-- USING (비교할 컬럼명)
-- 같은 이름의 컬럼을 연결하여 조회할 수 있음
select a.menu_name, b.category_name
from tbl_menu a
         join tbl_category b
              using (category_code);



-- LEFT JOIN
-- tbl_category에 있는 모든 카테고리를 출력하고,
-- tbl_menu에도 같은 카테고리가 있으면 해당 메뉴이름을 출력한다.
select a.category_name, b.menu_name
from tbl_category a -- 기준
         left join tbl_menu b
                   on -- 조건
                       a.category_code = b.category_code;


-- RIGHT JOIN
select a.menu_name, b.category_name
from tbl_menu a
         right join tbl_category b -- 기준
                    on -- 조건
                        a.category_code = b.category_code;


-- CROSS JOIN 모든 조합
select a.menu_name, b.category_name
from tbl_menu a
         cross join tbl_category b;



-- SELF JOIN
-- 자신의 테이블을 자신이 JOIN
select a.category_name as '카테고리명',
       b.category_name as 상위카테고리명
from tbl_category a
         join tbl_category b on a.ref_category_code = b.category_code;