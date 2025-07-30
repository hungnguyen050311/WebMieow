using Microsoft.AspNetCore.Mvc;
using WebMieow.Models;
using System;
using System.Linq;
using Microsoft.AspNetCore.Http;
using WebMieow.Data;

using Microsoft.EntityFrameworkCore;
using DataContext = WebMieow.Data.AppDbContext;

namespace WebMieow.Controllers
{
    public class ShopController : Controller
    {
        private readonly AppDbContext _context;

        public ShopController(AppDbContext context)
        {
            _context = context;
        }


        // ----------------------- Utility methods -----------------------

        private List<Order> ReadOrders()
        {
            return _context.Orders.ToList();
        }

        private void SaveOrders(List<Order> orders)
        {
            _context.Orders.AddRange(orders);
            _context.SaveChanges();
        }

        private string GetUsernameFromSession()
        {
            var jsonUser = HttpContext.Session.GetString("User");
            if (string.IsNullOrEmpty(jsonUser)) return null;

            var user = System.Text.Json.JsonSerializer.Deserialize<Account>(jsonUser);
            return user?.Username;
        }

        private string GenerateOrderCode()
        {
            return "MieowShop-" + Guid.NewGuid().ToString("N").Substring(0, 6).ToUpper();
        }

        // ----------------------- Actions -----------------------

        public IActionResult Index() => View();

        public IActionResult Admin()
        {
            var orders = ReadOrders();
            return View(orders);

        }




        public IActionResult Payment(string email, string plan, string amount)
        {
            var username = GetUsernameFromSession();
            var account = _context.Accounts.FirstOrDefault(a => a.Username == username);

            if (account == null)
            {
                TempData["Error"] = "Bạn cần đăng nhập trước khi thanh toán.";
                return RedirectToAction("Login", "Account");
            }

            // Tách giá từ plan
            var price = (int)decimal.Parse(plan.Split('-')[1].Replace("đ", "").Replace(".", "").Trim());

            // Tạo mã code nếu chưa có
            var code = Guid.NewGuid().ToString("N").Substring(0, 6).ToUpper();

            // Tạo Order mới
            var newOrder = new Order
            {
                Username = username,
                Contact = email,
                Email = email,
                Phone = "",
                OrderCode = code,
                Status = "pending",
                Card = "",
                CreatedAt = DateTime.UtcNow,
                Plan = plan,
                ServiceType = plan.Split('-')[0].Trim(),
                Price = price,
                AccountId = account.Id
            };

            _context.Orders.Add(newOrder);
            _context.SaveChanges();

            // Truyền model cho View
            var model = new PaymentViewModel
            {
                Email = email,
                Plan = plan,
                Amount = price,
                Code = code,
                Order = newOrder
            };

            return View(model);
        }





        [HttpPost]
        public IActionResult UpdateOrder(string orderCode, string status, string card)
        {
            var order = _context.Orders.FirstOrDefault(o => o.OrderCode == orderCode);
            if (order != null)
            {
                order.Status = status;
                order.Card = card;
                _context.SaveChanges();
            }

            return RedirectToAction("Admin");
        }

        // ----------------------- API JSON endpoint -----------------------

        
        [HttpGet]
        public IActionResult GetOrder(string contact, string orderCode)
        {
            var order = _context.Orders
                .FirstOrDefault(o => o.Contact == contact && o.OrderCode == orderCode);

            if (order == null)
                return NotFound();

            return Json(order);

        }

        [HttpPost]
        public IActionResult ConfirmPayment(string orderCode)
        {
            var order = _context.Orders.FirstOrDefault(o => o.OrderCode == orderCode && o.Status == "pending");

            if (order == null)
            {
                return NotFound("Đơn hàng không tồn tại hoặc đã được xử lý.");
            }

            // Replace this line in ConfirmPayment:
            var card = _context.CardStock.FirstOrDefault(c =>
                !c.IsUsed &&
                c.Type == order.ServiceType &&
                c.Amount == order.Price);


            if (card != null)
            {
                order.Status = "success";
                order.Card = card.Code;

                card.IsUsed = true;
                card.OrderCode = order.OrderCode;

                _context.SaveChanges();

                return View("PaymentSuccess", order); // hoặc Redirect đến trang xác nhận
            }
            else
            {
                order.Status = "waiting"; // trạng thái đợi admin xử lý
                _context.SaveChanges();

                return View("PaymentPending", order); // thông báo đang chờ admin
            }
        }

    }
}
