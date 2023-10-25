using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class HoaDonModel
    {
        public String MaHoaDonBan { get; set; }
        public string MaKhachHang { get; set; }
        public DateTime NgayBan { get; set; }
        public string ThanhTien { get; set; }
        public List<ChiTietHoaDonModel> list_json_chitiethoadonban { get; set; }
    }
    public class ChiTietHoaDonModel
    {
        public int MaChiTietHoaDonBan { get; set; }
        public int MaHoaDonBan { get; set; }        
        public string MaSanPham { get; set; }
        public int SoLuong { get; set; }
        public double GiaBan { get; set; }
    }
}
