using BusinessLogicLayer;
using BusinessLogicLayer.Interfaces;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.NguoiDung.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SanPhamSrController : ControllerBase
    {
        private ISanPhamBusiness _sanphamBusiness;
        public SanPhamSrController(ISanPhamBusiness matHangBusiness)
        {
            _sanphamBusiness = matHangBusiness;
        }
        [Route("getAllMatHang")]
        [HttpGet]   
        public List<HomeModel> GetAllMH()
        {
            return _sanphamBusiness.GetAllMH();
        }
        [Route("get-by-name/{name}")]
        [HttpGet]
        public HomeModel GetMH_Ten(string name)
        {
            return _sanphamBusiness.GetMH_Ten(name);
        }
        [Route("get-by-lh/{lh}")]
        [HttpGet]
        public HomeModel GetMH_LH(string lh)
        {
            return _sanphamBusiness.GetMH_LH(lh);
        }
        [Route("get-by-top số lượng/{top}")]
        [HttpGet]
        public List<HomeModel> GetMH_Top(int top)
        {
            return _sanphamBusiness.GetMH_Top(top);
        }

        [Route("get-by-top mới nhất/{topnew}")]
        [HttpGet]
        public List<HomeModel> GetMH_TopNew(int topnew)
        {
            return _sanphamBusiness.GetMH_Top(topnew);
        }
        [Route("get-by-gia/{gia}")]
        [HttpGet]
        public List<HomeModel> GetMH_Gia(int gia)
        {
            return _sanphamBusiness.GetMH_Gia(gia);
        }
    }
}
