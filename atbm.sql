--- connect QUANLYBENHVIEN/123;
----tao bang
create table NHANVIEN(
  MANV char(10),
  TENNV varchar2(50),
  CHUCVU varchar2(50),
  LUONG decimal,
  PHUCAP decimal, 
  LOAINV int,
  MAPHONG int,
  primary key (MANV)
);

create table LOAINV(
  MALOAI int,
  TENLOAI varchar2(50),
  primary key (MALOAI)
);

create table PHONG(
  MAPHONG int,
  TENPHONG varchar2(50),
  primary key (MAPHONG)
);

create table CHAMCONG(
  MANV char(10),
  NGAY date,
  CA int,
  primary key (MANV,NGAY,CA)
);

create table BENHNHAN(
  MABN int,
  TENBN varchar2(50),
  DIACHI varchar2(50),
  DIENTHOAI char(20),
  PHAI varchar2(4),
  NGAYSINH date,
  CMND raw(16),
  primary key (MABN)
);

create table PHIEUKHAM(
  MAPK int,
  MABN int,
  MABS char(10), --nen la char
  NGAYKHAM date,
  TRIEUCHUNG varchar2(50),
  CHANDOAN varchar2(50),
  MOTATHEM varchar2(50),
  primary key (MAPK)
);

create table DICHVU(
  MADV int,
  TENDV varchar2(50),
  GIADV decimal,
  primary key (MADV)
);

create table PK_DV(
  MAPK int,
  MADV int,
  MANV char(10),
  primary key (MAPK,MADV)
);

create table THUOC(
  MATHUOC int,
  TENTHUOC varchar2(50),
  QUYCACH varchar2(50),
  DONVITINH varchar2(50),
  GIATHUOC decimal,
  primary key (MATHUOC)
);

create table PK_THUOC(
  MAPK int,
  MATHUOC int,
  SOLUONG int,
  HUONGDAN varchar2(200),
  primary key (MAPK,MATHUOC)
);

----tao khoa ngoai
alter table NHANVIEN
add constraint fk_NHANVIEN_LOAINV 
foreign key (LOAINV)
references LOAINV(MALOAI);

alter table NHANVIEN
add constraint fk_NHANVIEN_PHONG 
foreign key (MAPHONG)
references PHONG(MAPHONG);

alter table CHAMCONG
add constraint fk_CHAMCONG_NHANVIEN
foreign key (MANV)
references NHANVIEN(MANV);

alter table PHIEUKHAM
add constraint fk_PHIEUKHAM_BENHNHAN
foreign key (MABN)
references BENHNHAN(MABN);

alter table PHIEUKHAM
add constraint fk_PHIEUKHAM_NHANVIEN
foreign key (MABS)
references NHANVIEN(MANV);

alter table PK_DV
add constraint fk_PK_DV_PHIEUKHAM
foreign key (MAPK)
references PHIEUKHAM(MAPK);

alter table PK_DV
add constraint fk_PK_DV_DICHVU
foreign key (MADV)
references DICHVU(MADV);

alter table PK_DV
add constraint fk_PK_DV_NHANVIEN
foreign key (MANV)
references NHANVIEN(MANV);

alter table PK_THUOC
add constraint fk_PK_THUOC_THUOC
foreign key (MATHUOC)
references THUOC(MATHUOC);

alter table PK_THUOC
add constraint fk_PK_THUOC_PHIEUKHAM
foreign key (MAPK)
references PHIEUKHAM(MAPK);

insert into LOAINV values (1, 'Nhóm quản lý tài nguyên');
insert into LOAINV values (2, 'Nhóm quản lý tài vụ');
insert into LOAINV values (3, 'Nhóm quản lý chuyên môn');
insert into LOAINV values (4, 'Bộ phận tiếp tân và điều phối');
insert into LOAINV values (5, 'Nhân viên phòng tài vụ');
insert into LOAINV values (6, 'Bác sĩ');
insert into LOAINV values (7, 'Kỹ thuật viên');
insert into LOAINV values (8, 'Nhân viên bộ phận bán thuốc');
insert into LOAINV values (9, 'Nhân viên kế toán');

insert into PHONG values (1, 'Phòng quản lý tài nguyên');
insert into PHONG values (2, 'Phòng quản lý tài vụ');
insert into PHONG values (3, 'Phòng quản lý chuyên môn');
insert into PHONG values (4, 'Phòng tiếp tân và điều phối');
insert into PHONG values (5, 'Phòng tài vụ');
insert into PHONG values (6, 'Phòng bác sĩ');
insert into PHONG values (7, 'Phòng kỹ thuật');
insert into PHONG values (8, 'Phòng thuốc');
insert into PHONG values (9, 'Phòng kế toán');

insert into NHANVIEN values ('NV1','Nguyễn Văn An', 'Trưởng phòng', 1000000,500000, 1, 1);
insert into NHANVIEN values ('NV2','Trần Thị Bình', 'Trưởng phòng', 1000000,500000, 2, 2);
insert into NHANVIEN values ('NV3','Bùi Thị Chung', 'Trưởng phòng', 1000000,500000, 3, 3);
insert into NHANVIEN values ('NV4','Trương Văn Dũng', 'Trưởng phòng', 1000000,500000, 4, 4);
insert into NHANVIEN values ('NV5','Lê Thị Hà', 'Trưởng phòng', 1000000,500000, 5, 5);
insert into NHANVIEN values ('NV6','Lý Văn Minh', 'Trưởng phòng', 1000000,500000, 6, 6);
insert into NHANVIEN values ('NV7','Nguyễn Thị Nga', 'Trưởng phòng', 1000000,500000, 7, 7);
insert into NHANVIEN values ('NV8','Trần Văn Toàn', 'Trưởng phòng', 1000000,500000, 8, 8);
insert into NHANVIEN values ('NV9','Nguyễn Thị Tâm', 'Trưởng phòng', 1000000,500000, 9, 9);
insert into NHANVIEN values ('NV10','Nguyễn Thị Nhẫn', 'Trưởng phòng', 1000000,500000, 7, 7);
insert into NHANVIEN values ('NV11','Nguyễn Hà Lan', 'Trưởng phòng', 1000000,500000, 6, 6);

alter session set nls_date_format='dd/mm/yyyy';
insert into CHAMCONG values ('NV1', TO_DATE('06/06/2018', 'dd/mm/yyyy'),1);
insert into CHAMCONG values ('NV2', TO_DATE('06/06/2018', 'dd/mm/yyyy'),1);
insert into CHAMCONG values ('NV3', TO_DATE('06/06/2018', 'dd/mm/yyyy'),1);
insert into CHAMCONG values ('NV4', TO_DATE('06/06/2018', 'dd/mm/yyyy'),1);
insert into CHAMCONG values ('NV5', TO_DATE('06/06/2018', 'dd/mm/yyyy'),1);
insert into CHAMCONG values ('NV6', TO_DATE('06/06/2018', 'dd/mm/yyyy'),1);
insert into CHAMCONG values ('NV7', TO_DATE('06/06/2018', 'dd/mm/yyyy'),1);
insert into CHAMCONG values ('NV8', TO_DATE('06/06/2018', 'dd/mm/yyyy'),1);
insert into CHAMCONG values ('NV9', TO_DATE('06/06/2018', 'dd/mm/yyyy'),1);
insert into CHAMCONG values ('NV10', TO_DATE('06/06/2018', 'dd/mm/yyyy'),2);
insert into CHAMCONG values ('NV11', TO_DATE('06/06/2018', 'dd/mm/yyyy'),2);
insert into CHAMCONG values ('NV1', TO_DATE('07/06/2018', 'dd/mm/yyyy'),1);
insert into CHAMCONG values ('NV2', TO_DATE('07/06/2018', 'dd/mm/yyyy'),1);
insert into CHAMCONG values ('NV3', TO_DATE('07/06/2018', 'dd/mm/yyyy'),1);
insert into CHAMCONG values ('NV4', TO_DATE('07/06/2018', 'dd/mm/yyyy'),1);
insert into CHAMCONG values ('NV5', TO_DATE('07/06/2018', 'dd/mm/yyyy'),1);
insert into CHAMCONG values ('NV6', TO_DATE('07/06/2018', 'dd/mm/yyyy'),1);
insert into CHAMCONG values ('NV7', TO_DATE('07/06/2018', 'dd/mm/yyyy'),1);
insert into CHAMCONG values ('NV8', TO_DATE('08/06/2018', 'dd/mm/yyyy'),1);
insert into CHAMCONG values ('NV9', TO_DATE('08/06/2018', 'dd/mm/yyyy'),1);
insert into CHAMCONG values ('NV10', TO_DATE('08/06/2018', 'dd/mm/yyyy'),1);
insert into CHAMCONG values ('NV11', TO_DATE('08/06/2018', 'dd/mm/yyyy'),1);

insert into BENHNHAN values (1,'Nguyễn Văn An', 'TPHCM', '0904535074','Nam', TO_DATE('06/06/1980', 'dd/mm/yyyy'), '123456789');
insert into BENHNHAN values (2,'Trần Thị Bình', 'TPHCM', '0904535075','Nu', TO_DATE('06/06/1980', 'dd/mm/yyyy'), '123456788');
insert into BENHNHAN values (3,'Bùi Thị Chung', 'TPHCM', '0904535076','Nu', TO_DATE('06/06/1980', 'dd/mm/yyyy'), '123456787');
insert into BENHNHAN values (4,'Trương Văn Dũng', 'TPHCM', '0904535077','Nam', TO_DATE('06/06/1980', 'dd/mm/yyyy'), '123456786');
insert into BENHNHAN values (5,'Lê Thị Hà', 'TPHCM', '0904535078','Nu', TO_DATE('06/06/1980', 'dd/mm/yyyy'), '123456785');
insert into BENHNHAN values (6,'Lý Văn Minh', 'TPHCM', '0904535071','Nam', TO_DATE('06/06/1980', 'dd/mm/yyyy'), '123456784');
insert into BENHNHAN values (7,'Nguyễn Thị Nga', 'TPHCM', '0904535072','Nu', TO_DATE('06/06/1980', 'dd/mm/yyyy'), '123456783');
insert into BENHNHAN values (8,'Trần Văn Toàn', 'TPHCM', '0904535073','Nam', TO_DATE('06/06/1980', 'dd/mm/yyyy'), '123456782');
insert into BENHNHAN values (9,'Nguyễn Thị Tâm', 'TPHCM', '0904535070','Nu', TO_DATE('06/06/1980', 'dd/mm/yyyy'), '12345671');

insert into PHIEUKHAM values (1,1,'NV6',TO_DATE('06/06/2018', 'dd/mm/yyyy'), 'Ho', 'Ung thư', 'Giai doan 1');
insert into PHIEUKHAM values (2,2,'NV6',TO_DATE('06/06/2018', 'dd/mm/yyyy'), 'Ho', 'Viêm phổi', 'Nhẹ');
insert into PHIEUKHAM values (3,3,'NV11',TO_DATE('06/06/2018', 'dd/mm/yyyy'), 'Sốt', 'Dị ứng', 'Ngoài da');
insert into PHIEUKHAM values (4,4,'NV11',TO_DATE('06/06/2018', 'dd/mm/yyyy'), 'Đau bụng', 'Dị ứng', 'Nhẹ');
insert into PHIEUKHAM values (5,5,'NV6',TO_DATE('07/06/2018', 'dd/mm/yyyy'), 'Ho', 'Viêm phổi', 'Nhẹ');
insert into PHIEUKHAM values (6,2,'NV6',TO_DATE('07/06/2018', 'dd/mm/yyyy'), 'Sốt', 'Ung thư', 'Giai doan 2');
insert into PHIEUKHAM values (7,3,'NV11',TO_DATE('07/06/2018', 'dd/mm/yyyy'), 'Đau bụng', 'Ung thư', 'Giai doan 3');
insert into PHIEUKHAM values (8,4,'NV11',TO_DATE('07/06/2018', 'dd/mm/yyyy'), 'Đau bụng', 'Dị ứng', 'Ngoài da');
insert into PHIEUKHAM values (9,1,'NV6',TO_DATE('06/06/2018', 'dd/mm/yyyy'), 'Ho', 'Viêm phổi', 'Giai doan 2');

insert into DICHVU values (1,'Siêu âm', 1000000);
insert into DICHVU values (2,'Chụp hình', 200000);
insert into DICHVU values (3,'Thử máu', 150000);


insert into PK_DV values (1,1,'NV7');
insert into PK_DV values (1,2,'NV10');
insert into PK_DV values (2,1,'NV7');
insert into PK_DV values (3,1,'NV7');
insert into PK_DV values (4,2,'NV10');
insert into PK_DV values (5,2,'NV10');


insert into THUOC values(1,'Panadol','Viên','Vỉ',30000);
insert into THUOC values(2,'Metrodiazol','Viên','Vỉ',20000);
insert into THUOC values(3,'Amocxin','Viên','Vỉ',120000);
insert into THUOC values(4,'Alpha Choay','Viên','Vỉ',50000);
insert into THUOC values(5,'Vitamin PP','Viên','Vỉ',40000);

insert into PK_THUOC values(1,1,2, 'Uống sau bữa ăn');
insert into PK_THUOC values(1,2,6, 'Uống trước khi ngủ');
insert into PK_THUOC values(2,3,3, 'Uống trước khi ngủ');
insert into PK_THUOC values(2,1,2, 'Uống sau bữa ăn');
insert into PK_THUOC values(3,1,2, 'Uống khi đau');
insert into PK_THUOC values(4,4,5, 'Uống buổi sáng');
insert into PK_THUOC values(5,1,5, 'Uống trước khi ngủ');
insert into PK_THUOC values(6,3,5, 'Uống sau bữa ăn');
insert into PK_THUOC values(7,5,5, 'Uống khi đau');

---tao role
create role NhomQuanLyTaiNguyen;
create role NhomQuanLyTaiVu;
create role NhomQuanLyChuyenMon;
create role BoPhanTiepTanVaDieuPhoi;
create role NhanVienPhongTaiVu;
create role BacSi;
create role KyThuatVien;
create role NhanVienBoPhanBanThuoc;
create role NhanVienKeToan;

---tạo tài khoản
begin
	for username in (select MANV from NhanVien)
	loop
		execute immediate 'create user ' || username.MANV || ' identified by ' ||123;
		execute immediate 'grant connect to ' || username.MANV;
		execute immediate 'grant create session to ' || username.MANV;
	end loop;
end;

---gan role cho user
begin
	for username in (select MANV from NHANVIEN where LOAINV = 1)
	loop
		execute immediate 'grant NhomQuanLyTaiNguyen to ' || username.MANV;
	end loop;
end;

begin
	for username in (select MANV from NHANVIEN where LOAINV = 2)
	loop
		execute immediate 'grant NhomQuanLyTaiVu to ' || username.MANV;
	end loop;
end;

begin
	for username in (select MANV from NHANVIEN where LOAINV = 3)
	loop
		execute immediate 'grant NhomQuanLyChuyenMon to ' || username.MANV;
	end loop;
end;

begin
	for username in (select MANV from NHANVIEN where LOAINV = 4)
	loop
		execute immediate 'grant BoPhanTiepTanVaDieuPhoi to ' || username.MANV;
	end loop;
end;

begin
	for username in (select MANV from NHANVIEN where LOAINV = 5)
	loop
		execute immediate 'grant NhanVienPhongTaiVu to ' || username.MANV;
	end loop;
end;

begin
	for username in (select MANV from NHANVIEN where LOAINV = 6)
	loop
		execute immediate 'grant BacSi to ' || username.MANV;
	end loop;
end;

begin
	for username in (select MANV from NHANVIEN where LOAINV = 7)
	loop
		execute immediate 'grant KyThuatVien to ' || username.MANV;
	end loop;
end;

begin
	for username in (select MANV from NHANVIEN where LOAINV = 8)
	loop
		execute immediate 'grant NhanVienBoPhanBanThuoc to ' || username.MANV;
	end loop;
end;

begin
	for username in (select MANV from NHANVIEN where LOAINV = 9)
	loop
		execute immediate 'grant NhanVienKeToan to ' || username.MANV;
	end loop;
end;

----tao user quan ly chinh sach bao mat
--create user SEC_QLBV identified by 123;
grant connect to SEC_QLBV;
grant create session to SEC_QLBV;
grant select on NhanVien to SEC_QLBV;
grant select on LOAINV to SEC_QLBV;
grant select on Phong to SEC_QLBV;
grant select on ChamCong to SEC_QLBV;
grant select on BenhNhan to SEC_QLBV;
grant select on PhieuKham to SEC_QLBV;
grant select on DichVu to SEC_QLBV;
grant select on PK_DV to SEC_QLBV;
grant select on Thuoc to SEC_QLBV;
grant select on PK_Thuoc to SEC_QLBV;
grant select,insert,update,delete on ThongBao to SEC_QLBV;

--connect sysdba/123456789
grant create session, create any context, create procedure, create trigger, administer database trigger to SEC_QLBV;
grant execute on dbms_session to SEC_QLBV;
grant execute on dbms_rls to SEC_QLBV;
GRANT grant any object privilege TO SEC_QLBV;
-- grant admin all cho SEC_QLBV

---cap quyen doc tren toan bang , , , , , , , , ,
---CS1: Nhóm quản lý chuyên môn tất cả thông tin trong đó có thông tin điều trị bệnh nhưng không được chỉnh sửa (RBAC).
grant select on BENHNHAN to NhomQuanLyChuyenMon;
grant select on CHAMCONG to NhomQuanLyChuyenMon;
grant select on DICHVU to NhomQuanLyChuyenMon;
grant select on LOAINV to NhomQuanLyChuyenMon;
grant select on NHANVIEN to NhomQuanLyChuyenMon;
grant select on PHIEUKHAM to NhomQuanLyChuyenMon;
grant select on PHONG to NhomQuanLyChuyenMon;
grant select on PK_DV to NhomQuanLyChuyenMon;
grant select on PK_THUOC to NhomQuanLyChuyenMon;
grant select on THONGBAO to NhomQuanLyChuyenMon;
grant select on THUOC to NhomQuanLyChuyenMon;

---CS2: tất cả mọi nhân viên đều có thể đọc bảng LOAINV và PHONG.
grant select on LOAINV to NhomQuanLyTaiNguyen;
grant select on PHONG to NhomQuanLyTaiNguyen;

grant select on LOAINV to NhomQuanLyTaiVu;
grant select on PHONG to NhomQuanLyTaiVu;

grant select on LOAINV to BoPhanTiepTanVaDieuPhoi;
grant select on PHONG to BoPhanTiepTanVaDieuPhoi;

grant select on LOAINV to NhanVienPhongTaiVu;
grant select on PHONG to NhanVienPhongTaiVu;

grant select on LOAINV to BacSi;
grant select on PHONG to BacSi;

grant select on LOAINV to KyThuatVien;
grant select on PHONG to KyThuatVien;

grant select on LOAINV to NhanVienBoPhanBanThuoc;
grant select on PHONG to NhanVienBoPhanBanThuoc;

grant select on LOAINV to NhanVienKeToan;
grant select on PHONG to NhanVienKeToan;

---CS2.1: Nhóm quản lý tài vụ được ghi các thông tin lquan, các thông tin còn lại được xem tất cả.
grant select on BENHNHAN to NhomQuanLyTaiVu;
grant select on CHAMCONG to NhomQuanLyTaiVu;
grant select on DICHVU to NhomQuanLyTaiVu;
grant select on LOAINV to NhomQuanLyTaiVu;
grant select on NHANVIEN to NhomQuanLyTaiVu;
grant select on PHIEUKHAM to NhomQuanLyTaiVu;
grant select on PHONG to NhomQuanLyTaiVu;
grant select on PK_DV to NhomQuanLyTaiVu;
grant select on PK_THUOC to NhomQuanLyTaiVu;
grant select on THONGBAO to NhomQuanLyTaiVu;
grant select on THUOC to NhomQuanLyTaiVu;

---bang NHANVIEN
---CS3:Nhân viên kế toán chỉ được chỉnh sửa LUONG, PHUCAP trong bảng NHANVIEN và xem tất cả các thuộc tính.
grant select on NHANVIEN to NhanVienKeToan;
grant update(LUONG,PHUCAP) on NHANVIEN to NhanVienKeToan;
--grant delete on NHANVIEN to NHANVIENKETOAN; --??

--CS5: Nhóm quản lý tài nguyên nhận chỉ định thêm, xóa, sửa, các 
--thông tin trong danh mục như: bác sĩ, nhân viên trong tưng phòng ban (RBAC).
grant insert, delete, update, select on NhanVien to NhomQuanLyTaiNguyen;

---CS6: Nhân viên nào chỉ xem được LUONG,PHUCAP của nhân viên đó
--nhưng nhân viên thuộc bộ phận quản lý chuyên môn, nhân viên kế toán, nhóm quản lý tài nguyên được xem tất cả.
connect SEC_QLBV/123;
create or replace function vpd_Luong_PhuCap (p_schema in varchar2, p_obj in varchar2)
return varchar2
as
user varchar2(100);
userrole varchar2(100);
begin
user := SYS_CONTEXT('userenv', 'SESSION_USER');
---lấy role của user
select granted_role into userrole from dba_ROLE_PRIVS where granted_role <> 'CONNECT' and rownum=1 and grantee= '' || user || '';

---nếu role là NhomQuanLyChuyenMon, NhanVienKeToan, NhomQuanLyTaiNguyen thi duoc doc tat ca
if userrole = 'NHOMQUANLYCHUYENMON' or userrole = 'NHANVIENKETOAN'
 or userrole = 'NHOMQUANLYTAINGUYEN' or userrole = 'NHOMQUANLYTAIVU' then
	return '1=1';
else
	return ' MANV=  ''' || user ||'''';
end if;
end;

connect SEC_QLBV/123;
begin dbms_rls.add_policy(object_schema =>'QuanLyBenhVien',
object_name => 'NHANVIEN',
policy_name => 'Luong_PhuCap_policy',
function_schema => 'sec_QLBV',
policy_function => 'vpd_Luong_PhuCap',
sec_relevant_cols => 'LUONG,PHUCAP',
sec_relevant_cols_opt => dbms_rls.ALL_ROWS
);
end;

/*connect SEC_QLBV/123;
begin dbms_rls.drop_policy(object_schema =>'QuanLyBenhVien',
object_name => 'PHIEUKHAM',
policy_name => 'PhieuKham_VPDcot'
);
end;
*/

--cấp quyền đọc cho tất cả nhân viên.
grant select on NHANVIEN to NhomQuanLyTaiNguyen;
---grant select on NHANVIEN to NhomQuanLyTaiVu; đã grant ở trên
grant select on NHANVIEN to NhomQuanLyChuyenMon;
grant select on NHANVIEN to BoPhanTiepTanVaDieuPhoi;
grant select on NHANVIEN to NhanVienPhongTaiVu;
grant select on NHANVIEN to BacSi;
grant select on NHANVIEN to KyThuatVien;
grant select on NHANVIEN to NhanVienBoPhanBanThuoc;
--grant select on NHANVIEN to NhanVienKeToan; do đã grant ở cs2
  
  connect NV1/123;
  select * from quanlybenhvien.NhanVien;
  connect NV2/123;
  select * from quanlybenhvien.NhanVien;
    connect NV3/123;
  select * from quanlybenhvien.NhanVien;
    connect NV4/123;
  select * from quanlybenhvien.NhanVien;
    connect NV5/123;
  select * from quanlybenhvien.NhanVien;
    connect NV6/123;
  select * from quanlybenhvien.NhanVien;
    connect NV7/123;
  select * from quanlybenhvien.NhanVien;
    connect NV8/123;
  select * from quanlybenhvien.NhanVien;
    connect NV9/123;
  select * from quanlybenhvien.NhanVien;
  
  
------bảng LOAINV và PHÒNG
--CS7: Nhóm quản lý tài nguyên nhận chỉ định thêm, xóa, sửa, các 
--thông tin trong danh mục như: phòng ban (RBAC).
grant insert, delete, update, select on Phong to NhomQuanLyTaiNguyen;
grant insert, delete, update, select on LoaiNV to NhomQuanLyTaiNguyen;

-----bảng CHAMCONG
--CS7.1: Nhóm quản lý tài nguyên nhận chỉ định thêm, xóa, sửa, các 
--thông tin trong danh mục như: bác sĩ nào trực phòng nào trong thời gian nào (RBAC).
grant insert, delete, update, select on CHAMCONG to NhomQuanLyTaiNguyen;

--CS8: Bộ phận tiếp tân và điều phối bệnh cũng căn cứ vào dữ liệu bác sĩ 
--chỉ định về việc xét nghiệm hoặc /và chẩn đoán hình ảnh để hướng dẫn bệnh
--nhân đúng phòng => Bộ phận tiếp tân và điều phối có thể đọc các thông tin 
--trên bảng CHAMCONG để có thể hướng dẫn cho bệnh nhân (DAC).
--grant select on CHAMCONG to BoPhanTiepTanVaDieuPhoi;
begin
	for username in (select MANV from NHANVIEN where LOAINV = 4)
	loop
		execute immediate 'grant select on CHAMCONG to ' || username.MANV;
	end loop;
end;

--CS8.1: Nhân viên kế toán có thể xem lịch làm việc để tính lương cho nhân viên.
grant select on CHAMCONG to NhanVienKeToan;

--CS8.2: Nhân viên có thể xem lịch làm việc của chính họ. ?, 
--nhóm quản lý tài vụ, nhóm quản lý chuyên môn, nhóm quản lý tài nguyên, 
--nhân viên kế toán, bộ phận tiếp tân và điều phối được xem tất cả(VPD trên dòng).
connect SEC_QLBV/123;
create or replace function vpd_ChamCong(p_schema in varchar2, p_obj in varchar2)
return varchar2
as
user varchar2(100);
userrole varchar2(100);
begin
user := SYS_CONTEXT('userenv', 'SESSION_USER');
---lấy role của user
select granted_role  into userrole from dba_ROLE_PRIVS where granted_role <> 'CONNECT' and rownum=1 and grantee= '' || user || '';

---nếu role là NhomQuanLyChuyenMon, NhanVienKeToan, NhomQuanLyTaiNguyen thi duoc doc tat ca
if userrole = 'NHOMQUANLYCHUYENMON' or userrole = 'NHANVIENKETOAN' OR userrole = 'BOPHANTIEPTANVADIEUPHOI'
 or userrole = 'NHOMQUANLYTAINGUYEN' or userrole = 'NHOMQUANLYTAIVU' then
	return '1=1';
else
	return ' MANV=  ''' || user ||'''';
end if;
end;

connect SEC_QLBV/123;
begin dbms_rls.add_policy(object_schema =>'QuanLyBenhVien',
object_name => 'CHAMCONG',
policy_name => 'CHAMCONG_policy',
function_schema => 'sec_QLBV',
policy_function => 'vpd_ChamCong',
statement_types => 'SELECT, DELETE, UPDATE',
update_check => true
);
end;

/*connect SEC_QLBV/123;
begin dbms_rls.drop_policy(object_schema =>'QuanLyBenhVien',
object_name => 'CHAMCONG',
policy_name => 'CHAMCONG_policy'
);
end;
*/
--cấp quyền đọc bảng chấm công cho tất cả nhân viên
grant select on CHAMCONG to NhomQuanLyTaiNguyen;
grant select on CHAMCONG to NhomQuanLyTaiVu;
grant select on CHAMCONG to NhomQuanLyChuyenMon;
--grant select on CHAMCONG to BoPhanTiepTanVaDieuPhoi;
grant select on CHAMCONG to NhanVienPhongTaiVu;
grant select on CHAMCONG to BacSi;
grant select on CHAMCONG to KyThuatVien;
grant select on CHAMCONG to NhanVienBoPhanBanThuoc;
grant select on CHAMCONG to NhanVienKeToan; 

 connect NV1/123;
  select * from quanlybenhvien.CHAMCONG;
  connect NV2/123;
  select * from quanlybenhvien.CHAMCONG;
    connect NV3/123;
  select * from quanlybenhvien.CHAMCONG;
    connect NV4/123;
  select * from quanlybenhvien.CHAMCONG;
    connect NV5/123;
  select * from quanlybenhvien.CHAMCONG;
    connect NV6/123;
  select * from quanlybenhvien.CHAMCONG;
    connect NV7/123;
  select * from quanlybenhvien.CHAMCONG;
    connect NV8/123;
  select * from quanlybenhvien.CHAMCONG;
    connect NV9/123;
  select * from quanlybenhvien.CHAMCONG;
  
------bang BenhNhan
--CS9: Bộ phận tiếp tân và điều phối bệnh viện được quyền thêm, xóa , sửa, tìm kiếm thông tin bệnh nhân (DAC).
grant select, insert, update, delete on BenhNhan to BoPhanTiepTanVaDieuPhoi

-----CS: Mỗi bác sĩ chỉ nhìn thấy dòng dữ liệu của bệnh nhân được tiếp tân điều phối 
--cho bác sĩ đó (VPD trên dòng). ---chua lam dc
--(tạo view và cấp quyền hoặc VPD).
----CS12: Nhân viên phòng tài vụ sẽ nhìn thấy thông tin của các bệnh nhân (RBAC).
connect SEC_QLBV/123;
create or replace function vpd_BenhNhan(p_schema in varchar2, p_obj in varchar2)
return varchar2
as
user varchar2(100);
userrole varchar2(100);
begin
user := SYS_CONTEXT('userenv', 'SESSION_USER');
---lấy role của user
select granted_role  into userrole from dba_ROLE_PRIVS where granted_role <> 'CONNECT' and rownum=1 and grantee= '' || user || '';
---nếu role là NhomQuanLyChuyenMon, NhanVienKeToan, NhomQuanLyTaiNguyen thi duoc doc tat ca
if userrole = 'NHOMQUANLYCHUYENMON' OR userrole = 'BOPHANTIEPTANVADIEUPHOI'
or userrole = 'NHOMQUANLYTAIVU' then
	return '1=1';
else if userrole = 'BACSI' then
  return 'MABN in (select MABN from QUANLYBENHVIEN.PHIEUKHAM where MABS = ''' || user ||''')';
else if userrole = 'KYTHUATVIEN' then
  return 'MABN in (select MABN from QuanLyBenhVien.PhieuKham where MAPK in (select MAPK from QuanLyBenhVien.PK_DV where MANV = ''' || user || '''))';
else
  return '1=0';
end if;
end if;
end if;
end;

connect SEC_QLBV/123;
begin dbms_rls.add_policy(object_schema =>'QuanLyBenhVien',
object_name => 'BENHNHAN',
policy_name => 'BENHNHAN_policy',
function_schema => 'sec_QLBV',
policy_function => 'vpd_BENHNHAN',
statement_types => 'SELECT, DELETE, UPDATE, INSERT',
update_check => true
);
end;

/*connect SEC_QLBV/123;
begin dbms_rls.drop_policy(object_schema =>'QuanLyBenhVien',
object_name => 'BENHNHAN',
policy_name => 'BENHNHAN_policy'
);
end;
*/

----CS11: Kỹ thuật viên tại phòng xét nghiệm và chuẩn đoán hình ảnh chỉ thấy những dòng 
--dữ liệu về bệnh nhân đã được bác sĩ chi định cho họ (họ tên, ngày tháng năm sinh) 
connect SEC_QLBV/123;
create or replace function vpd_BenhNhan_KTV(p_schema in varchar2, p_obj in varchar2)
return varchar2
as
user varchar2(100);
userrole varchar2(100);
begin
user := SYS_CONTEXT('userenv', 'SESSION_USER');
---lấy role của user
select granted_role  into userrole from dba_ROLE_PRIVS where granted_role <> 'CONNECT' and rownum=1 and grantee= '' || user || '';
---nếu role là NhomQuanLyChuyenMon, NhanVienKeToan, NhomQuanLyTaiNguyen thi duoc doc tat ca
if userrole = 'KYTHUATVIEN' then
  return 'MABN not in (select MABN from QuanLyBenhVien.PhieuKham where MAPK in (select MAPK from QuanLyBenhVien.PK_DV where MANV = ''' || user || '''))';
  --return '1=0';
else
  return '1=1';
end if;
end;

connect SEC_QLBV/123;
begin dbms_rls.add_policy(object_schema =>'QuanLyBenhVien',
object_name => 'BENHNHAN',
policy_name => 'BenhNhan_KTV__policy',
function_schema => 'sec_QLBV',
policy_function => 'vpd_BenhNhan_KTV',
sec_relevant_cols => 'DIACHI,DIENTHOAI,PHAI,CMND',
sec_relevant_cols_opt => dbms_rls.ALL_ROWS
);
end;

connect SEC_QLBV/123;
begin dbms_rls.drop_policy(object_schema =>'QuanLyBenhVien',
object_name => 'BENHNHAN',
policy_name => 'BenhNhan_KTV__policy'
);
end;


---cap queyn doc tren bang BenhNhan cho tat ca nhan vien
grant select on BENHNHAN to NhomQuanLyTaiNguyen;
grant select on BENHNHAN to NhomQuanLyTaiVu;
grant select on BENHNHAN to NhomQuanLyChuyenMon;
grant select on BENHNHAN to BoPhanTiepTanVaDieuPhoi;
grant select on BENHNHAN to NhanVienPhongTaiVu;
grant select on BENHNHAN to BacSi;
grant select on BENHNHAN to KyThuatVien;
grant select on BENHNHAN to NhanVienBoPhanBanThuoc;
grant select on BENHNHAN to NhanVienKeToan; 

 connect NV1/123;
  select * from quanlybenhvien.BENHNHAN;
  connect NV2/123;
  select * from quanlybenhvien.BENHNHAN;
    connect NV3/123;
  select * from quanlybenhvien.BENHNHAN;
    connect NV4/123;
  select * from quanlybenhvien.BENHNHAN;
    connect NV5/123;
  select * from quanlybenhvien.BENHNHAN;
    connect NV6/123;
  select * from quanlybenhvien.BENHNHAN;
    connect NV7/123;
  select * from quanlybenhvien.BENHNHAN;
    connect NV8/123;
  select * from quanlybenhvien.BENHNHAN;
    connect NV9/123;
  select * from quanlybenhvien.BENHNHAN;
      /*connect NV10/123;
  select * from quanlybenhvien.BENHNHAN;
    connect NV11/123;
  select * from quanlybenhvien.BENHNHAN;*/
 connect NV4/123;
 update quanlybenhvien.BenhNhan set Phai = 'Nu' where MaBN=1; --thanh cong (bpttvdp)
 connect NV6/123;
 update quanlybenhvien.BenhNhan set Phai = 'Nu' where MaBN=1; --thanh cong (bac si)
 
 
 -----------------------------------------------
 -----------------------------------------------
 -------- bang PhieuKham
 -- CS: NV Tài vụ được xem thông tin mà bộ phận điều phối tiếp nhận (cài chung với CS16)
 -- CS: NV Tài vụ không xem được thông tin ChanDoan, Motathem (VPD)
 -- CS: Bộ phận tiếp tân và điều phối không xem được thông tin ChanDoan, Motathem(VPD)
connect SEC_QLBV/123;
create or replace function vpd_CHANDOAN_MOTA (p_schema in varchar2, p_obj in varchar2)
return varchar2
as
user varchar2(100);
userrole varchar2(100);
begin
user := SYS_CONTEXT('userenv', 'SESSION_USER');
---lấy role của user
select granted_role into userrole from dba_ROLE_PRIVS where granted_role <> 'CONNECT' and rownum=1 and grantee= '' || user || '';

---nếu role là NhomQuanLyChuyenMon, NhanVienKeToan, NhomQuanLyTaiNguyen thi duoc doc tat ca
if userrole = 'NHOMQUANLYCHUYENMON' or userrole = 'BACSI' or userrole = 'NHOMQUANLYTAINGUYEN' or userrole = 'NHOMQUANLYTAIVU' then
	return '1=1';
else
	return '1=0';
end if;
end;

connect SEC_QLBV/123;
begin dbms_rls.add_policy(object_schema =>'QuanLyBenhVien',
object_name => 'PHIEUKHAM',
policy_name => 'CHANDOAN_MOTA_policy',
function_schema => 'sec_QLBV',
policy_function => 'vpd_CHANDOAN_MOTA',
sec_relevant_cols => 'CHANDOAN,MOTATHEM',
sec_relevant_cols_opt => dbms_rls.ALL_ROWS
);
end;

/*connect SEC_QLBV/123;
begin dbms_rls.drop_policy(object_schema =>'QuanLyBenhVien',
object_name => 'PHIEUKHAM',
policy_name => 'CHANDOAN_MOTA_policy'
);
end;*/
  
------ Cấp quyền xem trên bảng PhieuKham
grant select on PHIEUKHAM to NhomQuanLyTaiNguyen;
grant select on PHIEUKHAM to NhomQuanLyTaiVu;
grant select on PHIEUKHAM to NhomQuanLyChuyenMon;
grant select on PHIEUKHAM to BoPhanTiepTanVaDieuPhoi;
grant select on PHIEUKHAM to NhanVienPhongTaiVu;
grant select on PHIEUKHAM to BacSi;

--- test
connect NV3/123;
  select * from quanlybenhvien.PHIEUKHAM;
connect NV6/123;
  select * from quanlybenhvien.PHIEUKHAM;
connect NV4/123;
  select * from quanlybenhvien.PHIEUKHAM;
connect NV5/123;
  select * from quanlybenhvien.PHIEUKHAM;
  
-- CS: Chỉ có Bác sĩ mới được update trên TrieuChung, ChanDoan, MoTaThem (DAC)
connect SEC_QLBV/123;
begin
	for username in (select MANV from NHANVIEN where LOAINV = 6)
	loop
		execute immediate 'grant update(TRIEUCHUNG,CHANDOAN, MOTATHEM) on PHIEUKHAM to ' || username.MANV;
	end loop;
end;

-- CS: Bộ phận tiếp tân và điều phối insert và chỉnh sửa các thông tin trên bảng PHIEUKHAM trừ thông tin liên quan đến ChanDoan
grant insert, delete on PHIEUKHAM to BoPhanTiepTanVaDieuPhoi;
grant update(MAPK,MABN,MABS,NGAYKHAM,TRIEUCHUNG, MOTATHEM) on PHIEUKHAM to BoPhanTiepTanVaDieuPhoi;

-- CS : Bác sĩ chỉ xem được và chỉnh sửa được thông tin phiếu khám của những bệnh nhân do mình điều trị
connect SEC_QLBV/123;
create or replace function vpd_PhieuKham_BacSi(p_schema in varchar2, p_obj in varchar2)
return varchar2
as
user varchar2(100);
userrole varchar2(100);
begin
user := SYS_CONTEXT('userenv', 'SESSION_USER');
---lấy role của user
select granted_role  into userrole from dba_ROLE_PRIVS where granted_role <> 'CONNECT' and rownum=1 and grantee= '' || user || '';
---nếu role là NhomQuanLyChuyenMon, NhanVienKeToan, NhomQuanLyTaiNguyen thi duoc doc tat ca
if userrole = 'BACSI' then
  return 'MABS = ''' || user || '''';
else
  return '1=1';
end if;
end;

connect SEC_QLBV/123;
begin dbms_rls.add_policy(object_schema =>'QuanLyBenhVien',
object_name => 'PHIEUKHAM',
policy_name => 'PhieuKham_BacSi',
function_schema => 'sec_QLBV',
policy_function => 'vpd_PhieuKham_BacSi',
statement_types => 'SELECT, UPDATE',
update_check => true
);
end;

connect NV3/123;
  select * from quanlybenhvien.PHIEUKHAM;
connect NV6/123;
  select * from quanlybenhvien.PHIEUKHAM;
connect NV11/123;
  select * from quanlybenhvien.PHIEUKHAM;
  
------------------------------------------------------------
------------------------------------------------------------
--- bang DichVu
-- Nhóm quản lý, nhân viên phòng tài vụ, bác sĩ, kỹ thuật viên, bộ phận tiếp tân và điều phối được quyền xem
grant select on DichVu to NhomQuanLyTaiNguyen;
grant select on DichVu to NhomQuanLyTaiVu;
grant select on DichVu to NhomQuanLyChuyenMon;
--CS: Bộ phận tiếp tân và điều phối, nhân viên tài vụ, bác sĩ và kỹ thuật viên được xem (RBAC)
grant select on DichVu to BoPhanTiepTanVaDieuPhoi;
grant select on DichVu to NhanVienPhongTaiVu;
grant select on DichVu to BacSi;
grant select on DichVu to KyThuatVien;

-- CS: Nhân viên phòng tài vụ được cập nhật thông tin về giá tiền của dịch vụ
grant update(GIADV) on DICHVU to NhanVienPhongTaiVu;
-- CS: Nhóm quản lý tài vụ được quyền thêm, xóa, sửa thông tin dịch vụ
grant insert,update,delete on DICHVU to NhomQuanLyTaiVu;

-- CS: Bộ phận tiếp tân và điều phối không thể xem các thông tin liên quan đến số tiền (VPD cột)
connect SEC_QLBV/123;
create or replace function vpd_GIADV (p_schema in varchar2, p_obj in varchar2)
return varchar2
as
user varchar2(100);
userrole varchar2(100);
begin
user := SYS_CONTEXT('userenv', 'SESSION_USER');
---lấy role của user
select granted_role into userrole from dba_ROLE_PRIVS where granted_role <> 'CONNECT' and rownum=1 and grantee= '' || user || '';
if userrole <> 'BOPHANTIEPTANVADIEUPHOI' then
	return '1=1';
else
	return '1=0';
end if;
end;

connect SEC_QLBV/123;
begin dbms_rls.add_policy(object_schema =>'QuanLyBenhVien',
object_name => 'DICHVU',
policy_name => 'GIADV_policy',
function_schema => 'sec_QLBV',
policy_function => 'vpd_GIADV',
sec_relevant_cols => 'GIADV',
sec_relevant_cols_opt => dbms_rls.ALL_ROWS
);
end;

/*connect SEC_QLBV/123;
begin dbms_rls.drop_policy(object_schema =>'QuanLyBenhVien',
object_name => 'DICHVU',
policy_name => 'GIADV_policy'
);
end;*/
connect NV4/123;
select * from quanlybenhvien.DICHVU;
connect NV2/123;
select * from quanlybenhvien.DICHVU;
connect NV5/123;
select * from quanlybenhvien.DICHVU;

------------------------------------------------------------
------------------------------------------------------------
--- bang PK_DV
-- Nhóm quản lý, nhân viên phòng tài vụ, bác sĩ, kỹ thuật viên, bộ phận tiếp tân và điều phối được quyền xem
grant select on PK_DV to NhomQuanLyTaiNguyen;
grant select on PK_DV to NhomQuanLyTaiVu;
grant select on PK_DV to NhomQuanLyChuyenMon;
--CS: Bộ phận tiếp tân và điều phối, nhân viên tài vụ, bác sĩ và kỹ thuật viên được xem (RBAC)
grant select on PK_DV to BoPhanTiepTanVaDieuPhoi;
grant select on PK_DV to NhanVienPhongTaiVu;
grant select on PK_DV to BacSi;
grant select on PK_DV to KyThuatVien;
-- CS: Bộ phận điều phối và tiếp tân được quyền chỉnh sửa MaNV
grant update(MANV) on PK_DV to BoPhanTiepTanVaDieuPhoi;

-- CS: Bác sĩ chỉ định dịch vụ của bệnh nhân
grant insert, update, delete on PK_DV to BacSi
------------
-- CS: Bác sĩ chỉ có quyền trên những dòng do bệnh nhân mình điều trị (VPD)
-- CS: Kỹ thuật viên chỉ nhìn thấy những dòng mình được phân công (VPD)
connect SEC_QLBV/123;
create or replace function vpd_PK_DV_BacSi(p_schema in varchar2, p_obj in varchar2)
return varchar2
as
user varchar2(100);
userrole varchar2(100);
begin
user := SYS_CONTEXT('userenv', 'SESSION_USER');
---lấy role của user
select granted_role  into userrole from dba_ROLE_PRIVS where granted_role <> 'CONNECT' and rownum=1 and grantee= '' || user || '';
if userrole = 'BACSI' then
   return 'MAPK in (select MAPK from QuanLyBenhVien.PhieuKham where MABS = ''' || user || ''')';
else if userrole = 'KYTHUATVIEN' then
   return 'MANV=  ''' || user ||'''';
else
  return '1=1';
end if;
end if;
end;

connect SEC_QLBV/123;
begin dbms_rls.add_policy(object_schema =>'QuanLyBenhVien',
object_name => 'PK_DV',
policy_name => 'PK_DV_BacSi_policy',
function_schema => 'sec_QLBV',
policy_function => 'vpd_PK_DV_BacSi',
statement_types => 'SELECT, UPDATE, INSERT, DELETE',
update_check => true
);
end;

/*connect SEC_QLBV/123;
begin dbms_rls.drop_policy(object_schema =>'QuanLyBenhVien',
object_name => 'PK_DV',
policy_name => 'PK_DV_BacSi_policy'
);
end;*/

connect NV1/123;
  select * from quanlybenhvien.PK_DV;
connect NV6/123;
  select * from quanlybenhvien.PK_DV;
connect NV11/123;
  select * from quanlybenhvien.PK_DV;

connect NV7/123;
  select * from quanlybenhvien.PK_DV;
connect NV10/123;
  select * from quanlybenhvien.PK_DV;


-----------------------------------------------------------
---- bang THUOC
-- Nhóm quản lý, nhân viên phòng tài vụ, bác sĩ, nhân viên bán thuốc được quyền xem
grant select on THUOC to NhomQuanLyTaiNguyen;
grant select on THUOC to NhomQuanLyTaiVu;
grant select on THUOC to NhomQuanLyChuyenMon;
-- CS: Chỉ nhân viên phòng tài vụ, nhân viên bộ phận bán thuốc và bác sĩ mới có quyền xem
grant select on THUOC to NhanVienPhongTaiVu;
grant select on THUOC to NhanVienBoPhanBanThuoc;
grant select on THUOC to BacSi;

-- CS: Nhóm quản lý tài vụ được quyền thêm, xóa, sửa thông tin thuốc
grant insert, update, delete on THUOC to NhomQuanLyTaiVu;

------------------------------------------------------------
-- Bảng PK_THUOC
-- Nhóm quản lý, nhân viên phòng tài vụ, bác sĩ, nhân viên bán thuốc được quyền xem
grant select on PK_THUOC to NhomQuanLyTaiNguyen;
grant select on PK_THUOC to NhomQuanLyTaiVu;
grant select on PK_THUOC to NhomQuanLyChuyenMon;
-- CS: Chỉ nhân viên phòng tài vụ, nhân viên bộ phận bán thuốc và bác sĩ mới có quyền xem
grant select on PK_THUOC to NhanVienPhongTaiVu;
grant select on PK_THUOC to NhanVienBoPhanBanThuoc;
grant select on PK_THUOC to BacSi;

-- CS: Bác sĩ chỉ định thuốc của bệnh nhân. Bác sĩ chỉ có quyền trên những dòng do bệnh nhân mình điều trị (VPD)
grant insert, update, delete on PK_THUOC to BacSi
select * from PK_THUOC
------------
connect SEC_QLBV/123;
create or replace function vpd_PK_THUOC_BacSi(p_schema in varchar2, p_obj in varchar2)
return varchar2
as
user varchar2(100);
userrole varchar2(100);
begin
user := SYS_CONTEXT('userenv', 'SESSION_USER');
---lấy role của user
select granted_role  into userrole from dba_ROLE_PRIVS where granted_role <> 'CONNECT' and rownum=1 and grantee= '' || user || '';
if userrole = 'BACSI' then
   return 'MAPK in (select MAPK from QuanLyBenhVien.PhieuKham where MABS = ''' || user || ''')';
else
  return '1=1';
end if;
end;

connect SEC_QLBV/123;
begin dbms_rls.add_policy(object_schema =>'QuanLyBenhVien',
object_name => 'PK_THUOC',
policy_name => 'PK_THUOC_BacSi_policy',
function_schema => 'sec_QLBV',
policy_function => 'vpd_PK_THUOC_BacSi',
statement_types => 'SELECT, UPDATE, INSERT, DELETE',
update_check => true
);
end;

/*connect SEC_QLBV/123;
begin dbms_rls.drop_policy(object_schema =>'QuanLyBenhVien',
object_name => 'PK_DV',
policy_name => 'PK_DV_BacSi_policy'
);
end;*/

connect NV3/123;
  select * from quanlybenhvien.PK_THUOC;
connect NV6/123;
  select * from quanlybenhvien.PK_THUOC;
 connect NV11/123;
  select * from quanlybenhvien.PK_THUOC;

------------------------------------------
----- bảng Thông báo

insert into THONGBAO values ('Thông báo bí mật');
insert into THONGBAO values ('Thông báo giới hạn');
insert into THONGBAO values ('Thông báo thường');

--
-- Cấp quyền cho tài khoản các tài khoản được gán nhãn lên bảng THONGBAO
--grant select,insert,update,delete on THONGBAO to lbacsys;
grant select,insert,update,delete on THONGBAO to SEC_QLBV with grant option;
grant select,insert,update,delete on THONGBAO to NhomQuanLyTaiNguyen;
grant select,insert,update,delete on THONGBAO to NhomQuanLyTaiVu;
grant select,insert,update,delete on THONGBAO to NhomQuanLyChuyenMon;
grant select on THONGBAO to BoPhanTiepTanVaDieuPhoi;
grant select on THONGBAO to NhanVienPhongTaiVu;
grant select on THONGBAO to BacSi;
grant select on THONGBAO to KyThuatVien;
grant select on THONGBAO to NhanVienBoPhanBanThuoc;
grant select on THONGBAO to NhanVienKeToan;

-- Tạo chính sách
connect LBACSYS/123;
BEGIN
sa_sysdba.create_policy
(policy_name => 'THONGBAO_OLS',
column_name => 'NOIDUNG_OLS');
END;


connect LBACSYS/123;
begin
sa_sysdba.drop_policy(policy_name => 'THONGBAO_OLS', drop_column => TRUE);
end;

connect LBACSYS/123;
grant THONGBAO_OLS_dba to sec_QLBV;
GRANT EXECUTE ON sa_components TO SEC_QLBV;
GRANT EXECUTE ON sa_label_admin TO SEC_QLBV;
GRANT EXECUTE ON sa_user_admin TO SEC_QLBV;
GRANT EXECUTE ON char_to_label TO SEC_QLBV;


connect sec_QLBV/123;
exec sa_policy_admin.apply_table_policy('THONGBAO_OLS','QuanLyBenhVien', 'THONGBAO', 'NO_CONTROL');
--tạo level
connect sec_QLBV/123;
BEGIN
 SA_COMPONENTS.CREATE_LEVEL 
 (
   policy_name   => 'THONGBAO_OLS',
   level_num     => 300,
   short_name    => 'BM',
    long_name    => 'BIMAT'
  );
END;

connect sec_QLBV/123;
BEGIN
 SA_COMPONENTS.CREATE_LEVEL 
 (
   policy_name   => 'THONGBAO_OLS',
   level_num     => 200,
   short_name    => 'GH',
    long_name    => 'GIOIHAN'
  );
END;

connect sec_QLBV/123;
BEGIN
 SA_COMPONENTS.CREATE_LEVEL 
 (
   policy_name   => 'THONGBAO_OLS',
   level_num     => 100,
   short_name    => 'TT',
    long_name    => 'THONGTHUONG'
  );
END;

--- create label
connect sec_QLBV/123;
execute SA_LABEL_ADMIN.CREATE_LABEL ('THONGBAO_OLS',30,'BM');
execute SA_LABEL_ADMIN.CREATE_LABEL ('THONGBAO_OLS',20,'GH');
execute SA_LABEL_ADMIN.CREATE_LABEL ('THONGBAO_OLS',10,'TT');

connect sec_QLBV/123;
--- gắn level vào dữ liệu
-- Nhãn thấp nhất cho mọi dữ liệu
UPDATE QUANLYBENHVIEN.THONGBAO
SET NOIDUNG_OLS = char_to_label ('THONGBAO_OLS', 'TT');
-- Nhãn giới hạn
UPDATE QUANLYBENHVIEN.THONGBAO
SET NOIDUNG_OLS = char_to_label ('THONGBAO_OLS', 'GH')
WHERE NOIDUNG LIKE '%giới hạn%';
-- Nhãn bí mật
UPDATE QUANLYBENHVIEN.THONGBAO
SET NOIDUNG_OLS = char_to_label ('THONGBAO_OLS', 'BM')
WHERE NOIDUNG LIKE '%bí mật%';

-- gắn nhãn người dùng
connect sec_QLBV/123;
begin
sa_user_admin.set_user_labels(policy_name => 'THONGBAO_OLS', user_name => 'NV1',max_read_label => 'BM');
sa_user_admin.set_user_labels(policy_name => 'THONGBAO_OLS', user_name => 'NV2',max_read_label => 'BM');
sa_user_admin.set_user_labels(policy_name => 'THONGBAO_OLS', user_name => 'NV3',max_read_label => 'BM');
sa_user_admin.set_user_labels(policy_name => 'THONGBAO_OLS', user_name => 'NV4',max_read_label => 'GH');
sa_user_admin.set_user_labels(policy_name => 'THONGBAO_OLS', user_name => 'NV5',max_read_label => 'GH');
sa_user_admin.set_user_labels(policy_name => 'THONGBAO_OLS', user_name => 'NV6',max_read_label => 'GH');
sa_user_admin.set_user_labels(policy_name => 'THONGBAO_OLS', user_name => 'NV7',max_read_label => 'GH');
sa_user_admin.set_user_labels(policy_name => 'THONGBAO_OLS', user_name => 'NV8',max_read_label => 'TT');
sa_user_admin.set_user_labels(policy_name => 'THONGBAO_OLS', user_name => 'NV9',max_read_label => 'TT');
sa_user_admin.set_user_labels(policy_name => 'THONGBAO_OLS', user_name => 'NV10',max_read_label => 'GH');
sa_user_admin.set_user_labels(policy_name => 'THONGBAO_OLS', user_name => 'NV11',max_read_label => 'GH');
end;
--
-- Gỡ bỏ rồi gán lại chính sách
connect LBACSYS/123;
BEGIN
 SA_POLICY_ADMIN.REMOVE_TABLE_POLICY 
 (
    policy_name    => 'THONGBAO_OLS',
    schema_name    => 'QUANLYBENHVIEN', 
    table_name     => 'THONGBAO'
  );
END;

-- Gán lai chinh sach
connect sec_QLBV/123;
BEGIN
 SA_POLICY_ADMIN.APPLY_TABLE_POLICY 
 (
    policy_name    => 'THONGBAO_OLS',
    schema_name    => 'QUANLYBENHVIEN', 
    table_name     => 'THONGBAO',
    table_options  => 'READ_CONTROL,WRITE_CONTROL,CHECK_CONTROL' 
  );
END;
-----------
------- TEST
connect NV1/123;
select * from quanlybenhvien.THONGBAO;
connect NV5/123;
select * from quanlybenhvien.THONGBAO;
connect NV7/123;
select * from quanlybenhvien.THONGBAO;
connect NV9/123;
select * from quanlybenhvien.THONGBAO;
--=====================

------- MA HOA TRONG BANG BenhNhan
------------<Tham khao: Script mau>---------------

connect sec_QLBV/123
-- Tao công cu
    CREATE OR REPLACE PACKAGE chuyendoi AS
    FUNCTION encrypt (p_text  IN  VARCHAR2) RETURN RAW;
    FUNCTION decrypt (p_raw  IN  RAW) RETURN VARCHAR2;
    END chuyendoi;

-- Tao phan than cua cong cu chuyendoi
    CREATE OR REPLACE PACKAGE BODY chuyendoi AS
     g_key     RAW(32767)  := UTL_RAW.cast_to_raw('12341234');
     g_pad_chr VARCHAR2(1) := '~';
    PROCEDURE padstring (p_text  IN OUT  VARCHAR2);
	--------------------------------------------------------------------------------------
    FUNCTION encrypt (p_text  IN  VARCHAR2) RETURN RAW IS
      l_text       VARCHAR2(32767) := p_text;
      l_encrypted  RAW(32767);
    BEGIN
      padstring(l_text);
      DBMS_OBFUSCATION_TOOLKIT.desencrypt(input          => UTL_RAW.cast_to_raw(l_text),
                                          key            => g_key,
                                          encrypted_data => l_encrypted);
      RETURN l_encrypted;
    END;
	--------------------------------------------------------------------------------------
    FUNCTION decrypt (p_raw  IN  RAW) RETURN VARCHAR2 IS
      l_decrypted  VARCHAR2(32767);
    BEGIN
    if p_raw is null then --- truong hop khong duoc xem CMND
    return 'Khong the xem thong tin nay';
    else
      DBMS_OBFUSCATION_TOOLKIT.desdecrypt(input => p_raw,
                                          key   => g_key,
                                          decrypted_data => l_decrypted);

      RETURN RTrim(UTL_RAW.cast_to_varchar2(l_decrypted), g_pad_chr);
      end if;
    END;
    PROCEDURE padstring (p_text  IN OUT  VARCHAR2) IS
      l_units  NUMBER;
    BEGIN
      IF LENGTH(p_text) MOD 8 > 0 THEN
        l_units := TRUNC(LENGTH(p_text)/8) + 1;
        p_text  := RPAD(p_text, l_units * 8, g_pad_chr);
      END IF;
    END;
  END chuyendoi;
  -- tạo trigger
 create or replace trigger encrypted_BenhNhan
  before insert or update on quanlybenhvien.BenhNhan
  for each row
  declare
begin
   :new.CMND:=chuyendoi.encrypt(utl_raw.cast_to_varchar2(:new.CMND));
end;

-- connect quanlybenhvien/123;
update BENHNHAN set CMND= utl_raw.cast_to_raw('123456789') where maNV = 'NV1';
update BENHNHAN set CMND= utl_raw.cast_to_raw('456712421') where maNV = 'NV2';
update BENHNHAN set CMND= utl_raw.cast_to_raw('412455224') where maNV = 'NV3';
update BENHNHAN set CMND= utl_raw.cast_to_raw('442211126') where maNV = 'NV4';
update BENHNHAN set CMND= utl_raw.cast_to_raw('366552397') where maNV = 'NV5';
update BENHNHAN set CMND= utl_raw.cast_to_raw('753336455') where maNV = 'NV6';
update BENHNHAN set CMND= utl_raw.cast_to_raw('640064634') where maNV = 'NV7';
update BENHNHAN set CMND= utl_raw.cast_to_raw('241555336') where maNV = 'NV8';
update BENHNHAN set CMND= utl_raw.cast_to_raw('340003600') where maNV = 'NV9';

select * from BenhNhan

select chuyendoi.decrypt(CMND) as "CMND" from BenhNhan

connect NV4/123;
select * from quanlybenhvien.BenhNhan;

connect NV4/123;
select quanlybenhvien.chuyendoi.decrypt(CMND) as "CMND" from quanlybenhvien.BenhNhan;

grant execute on chuyendoi to BoPhanTiepTanVaDieuPhoi;

