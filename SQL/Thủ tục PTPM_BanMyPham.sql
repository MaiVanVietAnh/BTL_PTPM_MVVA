--Thủ tục hóa đơn

--tìm
ALTER PROCEDURE TimKiemHoaDon
(
    @MaHoaDonBan CHAR(10)
)
AS
BEGIN
    SELECT h.*, 
    (
        SELECT c.*
        FROM ChiTietHoaDonBan AS c
        WHERE h.MaHoaDonBan = c.MaHoaDonBan FOR JSON PATH
    ) AS list_json_chitietdonhangban
    FROM HoaDonBan AS h
    WHERE h.MaHoaDonBan = @MaHoaDonBan;
END;



--Thêm
ALTER PROCEDURE ThemHoaDonBan
(@MaKhachHang   NVARCHAR(50),
 @NgayBan		datetime,
 @ThanhTien     float,
 @list_json_chitietdonhangban NVARCHAR(MAX)
)
AS
    BEGIN
		DECLARE @MaHoaDonBan INT;
        INSERT INTO HoaDonBan
                (MaKhachHang , 
				 NgayBan,
                 ThanhTien             
                )
                VALUES
                (@MaKhachHang, 
				 @NgayBan, 
                 @ThanhTien
                );

				SET @MaHoaDonBan = (SELECT SCOPE_IDENTITY());
                IF(@list_json_chitietdonhangban IS NOT NULL)
                    BEGIN
                        INSERT INTO ChiTietHoaDonBan
						 (MaSanPham, 
						  MaHoaDonBan,
                          SoLuong, 
                          GiaBan               
                        )
                    SELECT JSON_VALUE(p.value, '$.MaSanPham'), 
                            @MaHoaDonBan, 
                            JSON_VALUE(p.value, '$.soLuong'), 
                            JSON_VALUE(p.value, '$.giaBan')    
                    FROM OPENJSON(@list_json_chitietdonhangban) AS p;
                END;
        SELECT '';
    END;





-- Sửa
CREATE PROCEDURE SuaHoaDonBan
    @MaHoaDonBan char(10),
    @MaKhachHang char(10),
    @NgayBan datetime,
    @ThanhTien float
AS
BEGIN
    UPDATE HoaDonBan
    SET MaKhachHang = @MaKhachHang, NgayBan = @NgayBan, ThanhTien = @ThanhTien
    WHERE MaHoaDonBan = @MaHoaDonBan
END

-- Xóa
CREATE PROCEDURE XoaHoaDonBan
    @MaHoaDonBan char(10)
AS
BEGIN
    DELETE FROM HoaDonBan
    WHERE MaHoaDonBan = @MaHoaDonBan
END


--Thủ tục--

--Khách HÀng

--Tim Khách Hàng
alter PROCEDURE TimKiemKhachHang
    @MaKhachHang char(10)
AS
BEGIN
    SELECT *
    FROM KhachHang
    WHERE MaKhachHang = @MaKhachHang
END



select * from KhachHang


--Thêm Khách hàng
alter PROCEDURE ThemKhachHang
	@MaKhachHang char(10),
    @TenKhachHang nvarchar(200),
    @SoDienThoai varchar(20),
    @DiaChi nvarchar(500),
    @Email varchar(50)
AS
BEGIN
    INSERT INTO KhachHang (MaKhachHang,TenKhachHang, SoDienThoai, DiaChi, Email)
    VALUES (@MaKhachHang,@TenKhachHang, @SoDienThoai, @DiaChi, @Email)
END

--Sửa Khách Hàng
alter PROCEDURE SuaKhachHang
    @MaKhachHang char(10),
    @TenKhachHang nvarchar(200),
    @SoDienThoai varchar(20),
    @DiaChi nvarchar(500),
    @Email varchar(50)
AS
BEGIN
    UPDATE KhachHang
    SET TenKhachHang = @TenKhachHang, SoDienThoai = @SoDienThoai, DiaChi = @DiaChi, Email = @Email
    WHERE MaKhachHang = @MaKhachHang
END


--Xóa kHách Hàng
create PROCEDURE XoaKhachHang
    @MaKhachHang char(10)
AS
BEGIN
    DELETE FROM KhachHang
    WHERE MaKhachHang = @MaKhachHang
END


------------Thủ tục với Tai Khoản------------

create PROCEDURE login1(@taikhoan nvarchar(50), @matkhau nvarchar(50))
AS
    BEGIN
      SELECT  *
      FROM TaiKhoan
      where TenTaiKhoan= @taikhoan and MatKhau = @matkhau;
    END;

	exec login1 'admin1','123'



--------------THủ tục với sản phẩm--
--tìm theo tên sản phẩm

ALTER PROCEDURE TimSanPhamTheoTen
    @TenSanPham nvarchar(250)
AS
BEGIN
    SELECT *
    FROM SanPham
    WHERE TenSanPham = @TenSanPham;
END;



--Thêm
CREATE PROCEDURE ThemSanPham
    @MaSanPham CHAR(10),
    @MaLoai CHAR(10),
    @TenSanPham NVARCHAR(250),
    @SoLuong INT,
    @Gia INT
AS
BEGIN
    INSERT INTO SanPham (MaSanPham, MaLoai, TenSanPham, SoLuong, Gia)
    VALUES (@MaSanPham, @MaLoai, @TenSanPham, @SoLuong, @Gia);
END;

--Sửa
ALTER PROCEDURE SuaSanPham
    @MaSanPham CHAR(10),
	@MaLoai CHAR(10),
    @TenSanPham NVARCHAR(250),
    @SoLuong INT,
    @Gia INT
AS
BEGIN
    UPDATE SanPham
    SET TenSanPham = @TenSanPham, MaLoai=@MaLoai, SoLuong = @SoLuong, Gia = @Gia
    WHERE MaSanPham = @MaSanPham;
END;


--Xóa
CREATE PROCEDURE XoaSanPham
    @MaSanPham CHAR(10)
AS
BEGIN
    DELETE FROM SanPham
    WHERE MaSanPham = @MaSanPham;
END;