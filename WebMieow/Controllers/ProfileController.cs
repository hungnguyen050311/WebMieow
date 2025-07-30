using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using WebMieow.Models;
using System;
using System.Linq;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
// Alias AppDbContext thành DataContext cho dễ nhớ
using DataContext = WebMieow.Data.AppDbContext;

namespace WebMieow.Controllers
{
    public class ProfileController : Controller
    {
        private readonly DataContext _context;

        public ProfileController(DataContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            var contact = HttpContext.Session.GetString("UserContact"); // Phone hoặc Email
            if (string.IsNullOrEmpty(contact))
                return RedirectToAction("Login", "Account");

            // Lấy account từ database
            var account = _context.Accounts.FirstOrDefault(a => a.Phone == contact || a.Email == contact);
            if (account == null)
                return RedirectToAction("Login", "Account");

            // Lấy đơn hàng từ database
            var orders = _context.Orders
                .Where(o => o.Email == contact || o.Phone == contact)
                .OrderByDescending(o => o.CreatedAt)
                .ToList();

            // Gộp vào ViewModel
            var viewModel = new ProfileViewModel
            {
                Account = account,
                Orders = orders
            };

            return View(viewModel);
        }
    }
}
