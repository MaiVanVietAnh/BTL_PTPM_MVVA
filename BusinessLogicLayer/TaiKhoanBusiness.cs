using BusinessLogicLayer.Interfaces;
using DataAccessLayer.Interfaces;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using DataModel;
using DataAccessLayer;


namespace BusinessLogicLayer
{
    public class TaiKhoanBusiness : ITaiKhoanBusiness
    {
        private ITaiKhoanRepository _res;
        private string secret;
        public TaiKhoanBusiness(ITaiKhoanRepository res, IConfiguration configuration)
        {
            _res = res;
            secret = configuration["AppSettings:Secret"];
        }

        public TaiKhoanModel Login(string taikhoan, string matkhau)
        {
            var user = _res.Login(taikhoan, matkhau);
            if (user == null)
                return null;

            if (string.IsNullOrEmpty(secret))
            {
                // Xử lý trường hợp khóa bí mật chưa được khởi tạo đúng cách
                throw new Exception("Khóa bí mật chưa được cấu hình đúng cách.");
            }

            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
            new Claim(ClaimTypes.Name, user.TenTaiKhoan.ToString()),
            new Claim(ClaimTypes.Email, user.Email)
                }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };

            var token = tokenHandler.CreateToken(tokenDescriptor);
            user.token = tokenHandler.WriteToken(token);
            return user;
        }

    }
}
