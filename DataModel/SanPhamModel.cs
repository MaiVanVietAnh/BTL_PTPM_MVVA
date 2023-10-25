

namespace DataModel
{
    public class SanPhamModel
    {
        public string LoaiHangID { get; set; }
        public string MaSanPham { get; set; }

        public string TenSanPham { get; set; }

        public string DVTinh { get; set; }
        public int SLTon { get; set; }
        public List<SanPhamModel> list_json_chitietmathang { get; set; }
    }
}
