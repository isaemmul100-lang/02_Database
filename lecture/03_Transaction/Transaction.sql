-- auto commit 설정 조회
select @@autocommit;

-- auto commit 설정 비활성화
set autocommit = 0;
set autocommit = OFF;

-- auto commit 설정 활성화
set autocommit = 1;
set autocommit = ON;

use menudb;
select *
from tbl_menu;

-- 트랜젝션 범위 지정
start transaction;

insert into tbl_menu
values (null, '바나나해장국', 8500, 4, 'Y');
update tbl_menu
set menu_name = '수정된 메뉴'
where menu_code = 5;
delete
from tbl_menu
where menu_code = 1;

select *
from tbl_menu
where menu_code = 5;

commit; -- COMMIT : 변경사항을 확정(저장)
rollback; -- 아직 COMMIT 되지 않은 사항을 취소한다.