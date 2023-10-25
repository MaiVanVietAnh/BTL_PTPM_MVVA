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
    public class HoaDonBusiness:IHoaDonBusiness
    {
        private IHoaDonRepository _res;
        public HoaDonBusiness(IHoaDonRepository res)
        {
            _res = res;
        }
         
        public HoaDonModel GetDatabyID(int id)
        {
            return _res.GetDatabyID(id);
        }
        public bool Create(HoaDonModel model)
        {
            return _res.Create(model);
        }
        public bool Update(HoaDonModel model)
        {
            return _res.Update(model);
        }
        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
    }
}