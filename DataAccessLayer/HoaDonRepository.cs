using DataAccessLayer.Interfaces;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataAccessLayer
{
    public class HoaDonRepository : IHoaDonRepository
    {
        private IDatabaseHelper _dbHelper;
        public HoaDonRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }
        public HoaDonModel GetDatabyID(int id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "TimKiemHoaDon",
                     "@MaHoaDonBan", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<HoaDonModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool Create(HoaDonModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "ThemHoaDonBan",
                "@MaHoaDonBan", model.MaHoaDonBan,
                "@MaKhachHang", model.MaKhachHang,
                "@NgayBan", model.NgayBan,
                "@ThanhTien", model.ThanhTien,
                "@list_json_chitietdonhangban", model.list_json_chitiethoadonban != null ? MessageConvert.SerializeObject(model.list_json_chitiethoadonban) : null);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool Update(HoaDonModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "SuaHoaDonBan",
                "@MaHoaDonBan", model.MaHoaDonBan,
                "@MaKhachHang", model.MaKhachHang,
                "@NgayBan", model.NgayBan,
                "@ThanhTien", model.ThanhTien,
                "@list_json_chitietdonhangban", model.list_json_chitiethoadonban != null ? MessageConvert.SerializeObject(model.list_json_chitiethoadonban) : null);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<ThongKeKhachModel> Search(int pageIndex, int pageSize, out long total, string ten_khach, DateTime? fr_NgayTao, DateTime? to_NgayTao)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_thong_ke_khach",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@ten_khach", ten_khach,
                    "@fr_NgayTao", fr_NgayTao,
                    "@to_NgayTao", to_NgayTao
                     );
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<ThongKeKhachModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Delete(int id)
        {
            string msgError = "";
            bool kq; // Khởi tạo mặc định là false
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "XoaHoaDonBan",
                     "@MaHoaDonBan", id);
                // Kiểm tra kết quả trả về từ hàm ExecuteScalarSProcedureWithTransaction
                if (Convert.ToInt32(result) > 0)
                {
                    kq = true; // Xóa thành công, đặt kq thành true
                }
                else
                {
                    kq = false;
                }
                return kq;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        
    }
}