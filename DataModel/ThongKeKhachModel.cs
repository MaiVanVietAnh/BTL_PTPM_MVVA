using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class ThongKeKhachModel
    {
        public string MatHangID { get; set; }
        public string TenHang { get; set; }
        public int SoLuong { get; set; }
        public int TongGia { get; set; }
        public DateTime NgayTao { get; set; }
        public string HoTenKH { get; set; }
        public string DiaChiKH { get; set; }
    }
     
}
