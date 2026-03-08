-- =====================================================
-- StoreFamily store 테이블 신구조 마이그레이션 예시
-- =====================================================
-- 실행 전 반드시 백업 후 진행하세요.

-- 1) 기존 store 테이블 백업
rename table store to store_old;

-- 2) 신규 store 테이블 생성
create table if not exists store (
    store_id varchar(20) primary key,
    store_code varchar(20) unique,
    store_name varchar(100),
    store_address varchar(255),
    store_phone varchar(50),
    ceo_bno int,
    created_at datetime default current_timestamp,
    constraint fk_store_ceo_bno foreign key (ceo_bno) references member(bno)
);

-- 3) 기존 데이터 이관
-- old bussiness -> new store_name
-- old bussinessnum -> new store_phone
-- old bussinessaddress + old bussinessaddress_etc -> new store_address
-- old code -> new store_code
-- old id -> member.id 매칭 후 ceo_bno
insert into store (store_id, store_code, store_name, store_address, store_phone, ceo_bno, created_at)
select
    lower(substring(replace(uuid(), '-', ''), 1, 9)) as store_id,
    case
        when so.code is null or so.code = '' then upper(substring(replace(uuid(), '-', ''), 1, 8))
        else so.code
    end as store_code,
    so.bussiness as store_name,
    concat(ifnull(so.bussinessaddress, ''), ' ', ifnull(so.bussinessaddress_etc, '')) as store_address,
    so.bussinessnum as store_phone,
    m.bno as ceo_bno,
    now() as created_at
from store_old so
join member m on m.id = so.id;

-- 4) 인덱스 추가
create index idx_store_ceo_bno on store(ceo_bno);
create index idx_store_store_code on store(store_code);

-- 5) (선택) store_member 테이블 신규 운영 구조 확인
create table if not exists store_member (
    store_member_id int auto_increment primary key,
    store_id varchar(20) not null,
    member_bno int not null,
    position varchar(20) not null,
    chk int not null default 0,
    employment varchar(30) null,
    health varchar(30) null,
    rate varchar(30) null,
    color varchar(30) null,
    created_at datetime not null default current_timestamp,
    constraint uq_store_member unique (store_id, member_bno)
);
