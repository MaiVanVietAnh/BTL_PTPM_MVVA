using BusinessLogicLayer;
using BusinessLogicLayer.Interfaces;
using DataAccessLayer;
using DataModel;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Api.NguoiDung.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HomeController : ControllerBase
    {
        private IHomeBusiness _homeBusiness;
        public HomeController(IHomeBusiness homeBusiness)
        {
            _homeBusiness = homeBusiness;
        }
        [AllowAnonymous]
        [HttpPost("Login")]
        public IActionResult Login([FromBody] AuthenticateModel model)
        {
            var user = _homeBusiness.Login(model.Username, model.Password);
            if (user == null)
                return BadRequest(new { message = "Tài khoản hoặc mật khẩu không đúng!" });
            return Ok(new { message = "Bạn đã đăng nhập thành công!",  taikhoan = user.TenTaiKhoan, email = user.Email });
        }

        [Route("register")]
        [HttpPost]
        public HomeModel Register([FromBody] HomeModel model)
        {
            _homeBusiness.Register(model);
            return model;
        }
    }
}