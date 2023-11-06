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
(@MaKhachHang     CHAR(10), 
 @NgayBan		  datetime,
 @ThanhTien       float,
 @list_json_chitietdonhangban NVARCHAR(MAX)
)
AS
    BEGIN
		DECLARE @MaHoaDonBan INT;
        INSERT INTO HoaDonBan
                (MaKhachHang, 
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
                          SoLuongBan, 
                          GiaBan              
                        )
                    SELECT JSON_VALUE(p.value, '$.MaSanPham'), 
                            @MaHoaDonBan, 
                            JSON_VALUE(p.value, '$.slBan'), 
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
ALTER PROCEDURE XoaHoaDonBan
    @MaHoaDonBan int
AS
BEGIN
    -- Kiểm tra xem MaHoaDonBan có tồn tại không
    IF EXISTS (SELECT 1 FROM HoaDonBan WHERE MaHoaDonBan = @MaHoaDonBan)
    BEGIN
        -- Xóa chi tiết hóa đơn bán liên quan	
        DELETE FROM ChiTietHoaDonBan WHERE MaHoaDonBan = @MaHoaDonBan;
        
        -- Xóa hóa đơn bán
        DELETE FROM HoaDonBan WHERE MaHoaDonBan = @MaHoaDonBan;
        
        PRINT 'Hóa đơn bán đã được xóa thành công.';
    END
    ELSE
    BEGIN
        PRINT 'Không tìm thấy hóa đơn bán có MaHoaDonBan = ' + CAST(@MaHoaDonBan AS nvarchar);
    END
END

--exec XoaHoaDonBan'4'

--------
ALTER PROCEDURE SuaHoaDonBan
		(@MaHoaDonBan char(10),
		@MaKhachHang char(10),
		@NgayBan datetime,
		@ThanhTien float,
		@list_json_chitietdonhangban NVARCHAR(MAX))
AS
    BEGIN
		UPDATE HoaDonBan
		SET
			MaKhachHang  = @MaKhachHang ,
			NgayBan = @NgayBan,
			ThanhTien = @ThanhTien
		WHERE MaHoaDonBan = @MaHoaDonBan;
		
		IF(@list_json_chitietdonhangban IS NOT NULL) 
		BEGIN
			 -- Insert data to temp table 
		   SELECT
			  JSON_VALUE(p.value, '$.maChiTietHoaDon') as maChiTietHoaDonBan,
			  JSON_VALUE(p.value, '$.maHoaDonBan') as maHoaDonBan,
			  JSON_VALUE(p.value, '$.maSanPham') as maSanPham,
			  JSON_VALUE(p.value, '$.soLuong') as soLuong,
			  JSON_VALUE(p.value, '$.giaBan') as giaBan,
			  JSON_VALUE(p.value, '$.status') as status
			  INTO #Results 
		   FROM OPENJSON(@list_json_chitietdonhangban) AS p;
		 
		 -- Insert data to table with STATUS = 1;
			INSERT INTO ChiTietHoaDonBan (MaSanPham, 
						  MaHoaDonBan,
                          SoLuong, 
                          GiaBan ) 
			   SELECT
				  #Results.MaSanPham,
				  @MaHoaDonBan,
				  #Results.soLuong,
				  #Results.GiaBan			 
			   FROM  #Results 
			   WHERE #Results.status = '1' 
			
			-- Update data to table with STATUS = 2
			  UPDATE ChiTietHoaDonBan 
			  SET
				 SoLuong = #Results.soLuong,
				 GiaBan = #Results.giaBan
			  FROM #Results 
			  WHERE  ChiTietHoaDonBan.maChiTietHoaDonBan = #Results.maChiTietHoaDonban AND #Results.status = '2';
			
			-- Delete data to table with STATUS = 3
			DELETE C
			FROM ChiTietHoaDonBan C
			INNER JOIN #Results R
				ON C.maChiTietHoaDonBan=R.maChiTietHoaDonBan
			WHERE R.status = '3';
			DROP TABLE #Results;
		END;
        SELECT '';
    END;



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
--người dùng đăng nhập--
alter PROCEDURE login(@taikhoan nvarchar(50), @matkhau nvarchar(50))
AS
    BEGIN
      SELECT  *
      FROM TaiKhoan
      where TenTaiKhoan= @taikhoan and MatKhau = @matkhau;
    END;


--admin kiểm tra tài khoản---
Create PROCEDURE login1(@taikhoan nvarchar(50), @matkhau nvarchar(50))
AS
    BEGIN
      SELECT h.*, 
		(
			SELECT c.*
			FROM ChiTietTaiKhoan AS c
			WHERE h.TenTaiKhoan = c.HoTen FOR JSON PATH
		) AS list_json_chitiettaikhoan
    FROM TaiKhoan AS h
    WHERE h.TenTaiKhoan= @taikhoan and h.MatKhau = @matkhau ;
END;

---Đăng ký tài khoản ( người dùng)--
CREATE PROCEDURE DangKy
	@TenTaiKhoan nvarchar(50),
	@MatKhau nvarchar(50),
	@Email nvarchar(150)
AS
BEGIN
    INSERT INTO TaiKhoan(MaLoai, TenTaiKhoan, MatKhau, Email)
    VALUES (2, @TenTaiKhoan, @MatKhau, @Email)
END


--------------THủ tục với sản phẩm--
--tìm theo tên sản phẩm

alter PROCEDURE TimKiemSanPham
    @MaSanPham char(10)
AS
BEGIN
    SELECT *
    FROM SanPham
    WHERE MaSanPham = @MaSanPham
END


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


















-----API.NguoiDung
--Tìm sp theo tên
CREATE PROCEDURE TimSanPhamTheoTen
    @TenSanPham NVARCHAR(250)
AS
BEGIN
    SELECT MaSanPham, TenSanPham, SoLuong, Gia
    FROM SanPham
    WHERE TenSanPham = @TenSanPham;
END;