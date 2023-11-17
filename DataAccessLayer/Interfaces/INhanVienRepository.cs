using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer.Interfaces
{
    public partial interface INhanVienRepository
    {
        NhanVienModel GetDatabyID(string id);
        bool Create(NhanVienModel model);
        bool Update(NhanVienModel model);
        bool Delete(string id);
    }
}
