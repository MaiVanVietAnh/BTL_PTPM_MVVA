create database PTPM_BanMyPham

use PTPM_BanMyPham

create table LoaiSanPham(
	MaLoai char(10) primary key,
	TenLoai nvarchar(50) not null
);

create table SanPham(
	MaSanPham char(10) primary key,
	MaLoai char(10) foreign key references LoaiSanPham(MaLoai),
	TenSanPham nvarchar(250) not null,
	SoLuong int,
	Gia int,
);

create table KhachHang(
	MaKhachHang char(10) primary key,
	TenKhachHang nvarchar(200),
	SoDienThoai varchar(20),
	DiaChi nvarchar(500),
	Email varchar(50),
);

create table NhanVien(
	MaNhanVien char(10) primary key,
	TenNhanVien nvarchar(100),
	SoDienThoai varchar(20),
	DiaChi nvarchar(100), 
	Email varchar(50),
);

create table NhaCungCap(
	MaNhaCungCap char(10) primary key,
	TenNhaCungCap nvarchar(200),
	DiaChi nvarchar(200),
	SoDienThoai varchar(20),
);


create table HoaDonNhap(
	MaHoaDonNhap char(10) primary key,
	MaNhanVien char(10) foreign key references NhanVien(MaNhanVien) on delete cascade on update cascade,
	MaNhaCungCap char(10) foreign key references NhaCungCap(MaNhaCungCap) on delete cascade on update cascade,
	NgayNhap datetime, 
	ThanhTien float,
);

create table ChiTietHoaDonNhap(
	MaChiTietHoaDonNhap char(10) primary key,
	MaHoaDonNhap char(10) foreign key references HoaDonNhap(MaHoaDonNhap) on delete cascade on update cascade,
	MaSanPham char(10) foreign key references SanPham(MaSanPham) on delete cascade on update cascade,
	DonGia float,
	SoLuong int,
);

create table HoaDonBan(
	MaHoaDonBan int identity(1,1) not null primary key,
	MaKhachHang char(10) foreign key references KhachHang(MaKhachHang) on delete cascade on update cascade,
	NgayBan datetime,
	ThanhTien float,
);
create table ChiTietHoaDonBan(
	MaChiTietHoaDonBan int identity(1,1) not null primary key,
	MaHoaDonBan int,
	MaSanPham char(10),
	SoLuongBan int,	
	GiaBan float,
	FOREIGN KEY (MaHoaDonBan) REFERENCES HoaDonBan (MaHoaDonBan) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (MaSanPham) REFERENCES SanPham (MaSanPham) ON DELETE CASCADE ON UPDATE CASCADE,
);



create table TaiKhoan
(
	MaTaiKhoan int primary key,
	MaLoai int,
	TenTaiKhoan nvarchar(50) NULL,
	MatKhau nvarchar(50) NULL,
	Email nvarchar(150) NULL
)

create table LoaiTk
(
	MaLoai int primary key,
	TenLoai nvarchar(50) NULL,
	MoTa nvarchar(250) NULL
)

create table ChiTietTaiKhoan
(
	MaChitietTaiKhoan int  primary key,
	MaTaiKhoan int NULL foreign key references TaiKhoan(MaTaiKhoan) on delete cascade on update cascade,
	HoTen nvarchar(50) NULL,
	DiaChi nvarchar(250) NULL,
	SoDienThoai nvarchar(11) NULL,
)

INSERT INTO LoaiSanPham (MaLoai,TenLoai)
VALUES
  (1,N'Chăm sóc da mặt'),
  (2,N'Trang điểm'),
  (3,N'Nước hoa'),
  (4,N'Chăm sóc tóc'),
  (5,N'Thực phẩm chức năng')

INSERT INTO SanPham(MaSanPham,MaLoai, TenSanPham, SoLuong, Gia)
VALUES
    (1,1, N'Tẩy trang',  50,100000),
    (2,2, N'Son Thỏi',  50, 100000),
    (3,3, N'Carolina Herrera',  60, 1000000),
    (4,4, N'Dầu gội C',  50, 150000),
    (5,5, N'Vitamin/ Khoáng chất',  25, 250000);

INSERT INTO KhachHang (MaKhachHang,TenKhachHang, SoDienThoai, DiaChi, Email)
VALUES
    (1,N'Nguyễn Văn A', '0123456789', N'123 Đường ABC, Quận XYZ', 'nguyenvana@example.com'),
    (2,N'Trần Thị B', '0987654321', N'456 Đường DEF, Quận UVW', 'tranthib@example.com'),
    (3,N'Lê Minh C', '0365987412', N'789 Đường GHI, Quận RST', 'leminhc@example.com'),
    (4,N'Phạm Đức D', '0754623987', N'101 Đường JKL, Quận MNO', 'phamducd@example.com'),
    (5,N'Huỳnh Ngọc E', '0923456710', N'222 Đường PQR, Quận LMN', 'huynhngoce@example.com');
INSERT INTO NhanVien (MaNhanVien,TenNhanVien, SoDienThoai, DiaChi, Email)
VALUES
    (1,N'Nguyễn Văn Nam', '0123456789', N'123 Đường XYZ, Quận ABC', 'namnguyen@example.com'),
    (2,N'Trần Thị Hương', '0987654321', N'456 Đường UVW, Quận DEF', 'huongtran@example.com'),
    (3,N'Lê Minh Tâm', '0365987412', N'789 Đường RST, Quận GHI', 'tamle@example.com'),
    (4,N'Phạm Đức Hùng', '0754623987', N'101 Đường MNO, Quận JKL', 'hungho@example.com'),
    (5,N'Huỳnh Ngọc Trâm', '0923456710', N'222 Đường LMN, Quận PQR', 'tramhuynh@example.com');
INSERT INTO NhaCungCap (MaNhaCungCap,TenNhaCungCap, DiaChi, SoDienThoai)
VALUES
    (1,N'Công ty A', N'123 Đường XYZ, Quận ABC', '0123456789'),
    (2,N'Công ty B', N'456 Đường UVW, Quận DEF', '0987654321'),
    (3,N'Công ty C', N'789 Đường RST, Quận GHI', '0365987412'),
    (4,N'Công ty D', N'101 Đường MNO, Quận JKL', '0754623987'),
    (5,N'Công ty E', N'222 Đường LMN, Quận PQR', '0923456710');

INSERT INTO TaiKhoan (MaTaiKhoan, MaLoai, TenTaiKhoan, MatKhau,Email)
VALUES
    ('1', '1', 'admin', '123','vietanh@gmail.com'),
	('2', '2', 'user', '123','ptp@gmail.com'),
	('3', '2', 'vanh', '123','vanh@gmail.com'),
	('4', '2', 'nhat', '123','nhat@gmail.com')

INSERT INTO LoaiTk (MaLoai, TenLoai, MoTa)
VALUES
    ('1', 'admin', 'quan ly'),
	('2', 'user', 'nguoi dung')

INSERT INTO ChiTietTaiKhoan (MaChitietTaiKhoan, MaTaiKhoan, HoTen,DiaChi,SoDienThoai)
VALUES
    ('1', '1', 'Vanh','ThaiBinh','0987654321'),
	('2', '2', 'Phuong','ThaiBinh','0984654321')


-- Thêm dữ liệu mẫu cho bảng HoaDonBan
INSERT INTO HoaDonBan (MaKhachHang, NgayBan, ThanhTien)
VALUES
    (1, '2023-10-15 08:30:00', 500000),
    (2, '2023-10-16 10:15:00', 750000),
    (3, '2023-10-17 14:45:00', 1000000),
    (4, '2023-10-18 12:00:00', 300000); 

--Thêm dữ liệu cho bảng chitiethoadonban
-- Thêm dữ liệu mẫu cho bảng ChiTietHoaDonBan
INSERT INTO ChiTietHoaDonBan (MaHoaDonBan, MaSanPham, SoLuong, GiaBan)
VALUES
    (1, '5', 2, 250000),
    (2, '1', 3, 100000),
    (3, '3', 1, 1000000),
    (4, '4', 2, 120000);