using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using WebMieow.Models;
// Use an alias to resolve ambiguity
using DataContext = WebMieow.Data.AppDbContext;
using System.Collections.Generic;
using System;
using System.Linq;
using Microsoft.AspNetCore.Http;
using System.Text.Json;

namespace WebMieow.Controllers
{
    public class UserController : Controller
    {
        private readonly DataContext _context;

        public UserController(DataContext context)
        {
            _context = context;
        }

        public IActionResult Profile()
        {
            var jsonUser = HttpContext.Session.GetString("User");

            if (string.IsNullOrEmpty(jsonUser))
            {
                return RedirectToAction("Login", "Account");
            }

            var user = JsonSerializer.Deserialize<Account>(jsonUser);

            // ✅ Lấy danh sách đơn hàng từ CSDL theo username
            var userOrders = _context.Orders
                .Where(o => o.Username == user.Username)
                .OrderByDescending(o => o.CreatedAt)
                .ToList();

            var profileVM = new ProfileViewModel
            {
                Account = user,
                Username = user.Username,
                Email = user.Email,
                Phone = user.Phone,
                FullName = user.FullName,
                Address = user.Address,
                Orders = userOrders,
                Role = user.Role
            };

            return View(profileVM);
        }

        // ❌ AccountController KHÔNG nên lồng trong UserController – Glow nên đưa ra file riêng
    }
}
