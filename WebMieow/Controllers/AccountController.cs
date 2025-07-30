using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Text.Json;
using WebMieow.Data;
using WebMieow.Models;
// Use the correct AppDbContext from Data namespace
using DataContext = WebMieow.Data.AppDbContext;


namespace WebMieow.Controllers
{
    public class AccountController : Controller
    {
        private readonly IWebHostEnvironment _env;
        private readonly AppDbContext _context;

        public AccountController(IWebHostEnvironment env, DataContext context)
        {
            _env = env;
            _context = context;
        }



        public IActionResult Index()
        {
            ViewBag.IsLoggedIn = HttpContext.Session.GetString("username") != null;
            return View();
        }


        // Form đăng ký
        [HttpGet]
        public IActionResult Register()
        {
            return View();
        }

        // Xử lý đăng ký
        [HttpPost]
        public IActionResult Register(string username, string password, string confirmPassword, string email, string phone, string fullName)
        {
            if (password != confirmPassword)
            {
                ViewBag.Error = "Mật khẩu không khớp!";
                return View();
            }

            var newAcc = new Account
            {
                Username = username,
                Password = password,
                Email = email,
                Phone = phone,
                FullName = fullName,
                Address = "N/A" // Nếu Address chưa có input
            };

            _context.Accounts.Add(newAcc);
            _context.SaveChanges();

            TempData["Success"] = "Đăng ký thành công!";
            return RedirectToAction("Login");
        }


        [HttpGet]
        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Login(string username, string password)
        {
            var user = _context.Accounts.FirstOrDefault(a => a.Username == username && a.Password == password);
            if (user == null)
            {
                ViewBag.Error = "Sai tên đăng nhập hoặc mật khẩu!";
                return View();
            }

            var jsonUser = JsonSerializer.Serialize(user);
            HttpContext.Session.SetString("User", jsonUser);
            TempData["Success"] = "Đăng nhập thành công!";
            return RedirectToAction("Index", "Shop");
        }

        [HttpGet]
        public IActionResult ForgotPassword()
        {
            return View();
        }

        [HttpPost]
        public IActionResult ForgotPassword(string email)
        {
            var user = _context.Accounts.FirstOrDefault(a => a.Email == email);
            if (user == null)
            {
                ViewBag.Message = "Không tìm thấy tài khoản với email này.";
                return View();
            }

            // Tạm thời chỉ hiển thị lại mật khẩu (vì chưa có hệ thống gửi mail)
            ViewBag.Message = $"Mật khẩu của bạn là: {user.Password}";

            return View();
        }



        public IActionResult Logout()
        {
            // Xóa toàn bộ session
            HttpContext.Session.Clear();

            // Chuyển về trang chính (Shop/Index)
            return RedirectToAction("Index", "Shop");
        }



    }
}

