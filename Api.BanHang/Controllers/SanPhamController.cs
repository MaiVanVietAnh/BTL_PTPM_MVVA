using BusinessLogicLayer.Interfaces;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.BanHang.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SanPhamController : ControllerBase
    {
        private IMatHangBusiness _mathangBusiness;
        public SanPhamController(IMatHangBusiness mathangBusiness)
        {
            _mathangBusiness = mathangBusiness;
        }
        [Route("get-by-id/{id}")]
        [HttpGet]
        public SanPhamModel GetChiTietMatHang(string id)
        {
            return _mathangBusiness.GetChiTietMatHang(id);
        }
    }
}
