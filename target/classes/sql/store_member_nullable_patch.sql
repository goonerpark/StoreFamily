-- =====================================================
-- StoreFamily store_member NULL 허용 보정 스크립트
-- 목적:
-- - 사장 row 생성 시 시급(rate) 값 없이 insert 가능하도록 보정
-- - employment / health / color 도 사장에게는 값이 없을 수 있어 NULL 허용 유지
-- =====================================================

-- 현재 컬럼 타입이 다를 수 있으므로 운영 DB 스키마에 맞춰 길이는 필요시 조정하세요.
alter table store_member
    modify column employment varchar(30) null,
    modify column health varchar(30) null,
    modify column rate varchar(30) null,
    modify column color varchar(30) null;

-- 검증용
-- show create table store_member;
