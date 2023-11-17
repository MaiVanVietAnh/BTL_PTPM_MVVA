using BusinessLogicLayer.Interfaces;
using DataAccessLayer.Interfaces;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public class NhanVienBusiness : INhanVienBusiness
    {
        private INhanVienRepository _res;
        public NhanVienBusiness(INhanVienRepository res)
        {
            _res = res;
        }
        public NhanVienModel GetDatabyID(string id)
        {
            return _res.GetDatabyID(id);
        }
        public bool Create(NhanVienModel model)
        {
            return _res.Create(model);
        }
        public bool Update(NhanVienModel model)
        {
            return _res.Update(model);
        }
        public bool Delete(string id)
        {
            return _res.Delete(id);
        }
    }
}
