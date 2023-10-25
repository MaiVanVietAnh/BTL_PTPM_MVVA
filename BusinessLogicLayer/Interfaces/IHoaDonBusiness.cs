using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public partial interface IHoaDonBusiness
    {
        HoaDonModel GetDatabyID(int id);
        bool Create(HoaDonModel model);
        bool Update(HoaDonModel model);
        bool Delete(int id);
    }
}
