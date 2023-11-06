using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer.Interfaces
{
    public partial interface IHomeBusiness
    {
        HomeModel Login(string taikhoan, string matkhau);
        bool Register(HomeModel model);
    }
}
