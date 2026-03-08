-- StoreFamily 신규 매장 등록 기능 스키마
-- 기존 로그인/회원가입 호환을 위해 기존 member/store 구조는 유지하고,
-- store 테이블에 신규 컬럼을 확장하고 store_member 테이블을 추가합니다.

alter table store
	add column if not exists store_id varchar(20) null,
	add column if not exists store_code varchar(20) null,
	add column if not exists store_name varchar(100) null,
	add column if not exists store_address varchar(255) null,
	add column if not exists store_phone varchar(30) null,
	add column if not exists ceo_bno int null,
	add column if not exists created_at datetime null;

update store
set created_at = now()
where created_at is null;

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

create index idx_store_ceo_bno on store(ceo_bno);
create index idx_store_store_code on store(store_code);
