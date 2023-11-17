using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class TaiKhoanModel
    {
        public int MaTaiKhoan { get; set; }
        public int MaLoai { get; set; }
        public string TenTaiKhoan { get; set; }
        public string MatKhau { get; set; }
        public string Email { get; set; }
        public string token { get; set; }
        public List<ChiTietTaiKhoanModel> list_json_chitiettaikhoan { get; set; }
    }
    public class ChiTietTaiKhoanModel
    {
        public string MaChitietTaiKhoan { get; set; }
        public string MaTaiKhoan { get; set; }
        public string HoTen { get; set; }
        public string DiaChi { get; set; }
        public string SoDienThoai { get; set; }
    }
}
