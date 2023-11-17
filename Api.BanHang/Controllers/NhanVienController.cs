using BusinessLogicLayer.Interfaces;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.BanHang.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NhanVienController : ControllerBase
    {
        private INhanVienBusiness _nhanvienBusiness;
        public NhanVienController(INhanVienBusiness nhanvienBusiness)
        {
            _nhanvienBusiness = nhanvienBusiness;
        }
        [Route("Get-by-id/{id}")]
        [HttpGet]
        public NhanVienModel GetDatabyID(string id)
        {
            return _nhanvienBusiness.GetDatabyID(id);
        }
        [Route("Create-NhanVien")]
        [HttpPost]
        public NhanVienModel CreateItem([FromBody] NhanVienModel model)
        {
            _nhanvienBusiness.Create(model);
            return model;
        }
        [Route("Update-NhanVien")]
        [HttpPost]
        public NhanVienModel UpdateItem([FromBody] NhanVienModel model)
        {
            _nhanvienBusiness.Update(model);
            return model;
        }
        [Route("Delete-NhanVien")]
        [HttpDelete]
        public IActionResult DeleteItem(string id)
        {
            _nhanvienBusiness.Delete(id);
            return Ok(new { message ="Bạn đã xóa thành công!" });
        }
    }
}
