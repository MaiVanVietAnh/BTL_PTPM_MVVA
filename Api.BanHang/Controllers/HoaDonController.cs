using BusinessLogicLayer;
using BusinessLogicLayer.Interfaces;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.BanHang.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HoaDonController : ControllerBase
    {
        private IHoaDonBusiness _hoadonBusiness;
        public HoaDonController(IHoaDonBusiness hoadonBusiness)
        {
            _hoadonBusiness = hoadonBusiness;
        }
        [Route("get-by-id/{id}")]
        [HttpGet]
        public HoaDonModel GetDatabyID(int id)
        {
            return _hoadonBusiness.GetDatabyID(id);
        }
        [Route("create-hoadon")]
        [HttpPost]
        public HoaDonModel CreateItem([FromBody] HoaDonModel model)
        {
            _hoadonBusiness.Create(model);
            return model;
        }
        [Route("update-hoadon")]
        [HttpPost]
        public HoaDonModel Update([FromBody] HoaDonModel model)
        {
            _hoadonBusiness.Update(model);
            return model;
        }
        [Route("delete-hoadon")]
        [HttpDelete]
        public IActionResult DeleteItem(int id)
        {
            _hoadonBusiness.Delete(id);
            return Ok(id);
        }
    }
}
