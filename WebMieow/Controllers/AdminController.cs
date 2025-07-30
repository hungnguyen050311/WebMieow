using Microsoft.AspNetCore.Mvc;
using System.Linq;
using WebMieow.Data;
using WebMieow.Models;
using System.Text.Json;


namespace WebMieow.Controllers
{
    public class AdminController : Controller
    {
        private readonly AppDbContext _context;

        public AdminController(AppDbContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            var pendingOrders = _context.Orders
                .Where(o => o.Status == "pending")
                .OrderByDescending(o => o.CreatedAt)
                .ToList();

            return View(pendingOrders);
        }

        [HttpPost]
        public IActionResult Approve(string orderCode)
        {
            var order = _context.Orders.FirstOrDefault(o => o.OrderCode == orderCode);
            if (order != null)
            {
                order.Status = "success";
                _context.SaveChanges();
            }
            return RedirectToAction("Index");
        }

        public IActionResult ConfirmPayment(string orderCode)
        {
            // Changed 'isUsed' to 'IsUsed' to match the property name in Card class
            var order = _context.Orders.FirstOrDefault(o => o.OrderCode == orderCode && o.Status == "opending");
            if (order == null) return RedirectToAction("Index");

            var card = _context.Cards.FirstOrDefault(c =>
                !c.IsUsed &&
                c.ServiceType == order.ServiceType &&
                c.Amount == order.Price); // <-- Fixed: use order.Price instead of OrderPrice

            if (card == null) return RedirectToAction("Index");

            order.Status = "success";
            order.Card = card.Code;

            card.IsUsed = true;
            // Removed: card.OrderCode = orderCode; // Card does not have OrderCode property

            _context.SaveChanges();

            return RedirectToAction("Index");
        }

        private string GetAvailableCard(string plan)
        {
            string filePath = Path.Combine(Directory.GetCurrentDirectory(), "Data", "cards.json");
            var jsonData = System.IO.File.ReadAllText(filePath);
            var cards = JsonSerializer.Deserialize<List<Card>>(jsonData);

            var card = cards.FirstOrDefault(c => !c.IsUsed && c.ServiceType == plan);
            if (card != null)
            {
                card.IsUsed = true;
                System.IO.File.WriteAllText(filePath, JsonSerializer.Serialize(cards));
                return card.Code;
            }

            return null;
        }


        [HttpPost]
        public IActionResult UpdateOrder(string orderCode, string status)
        {
            var order = _context.Orders.FirstOrDefault(o => o.OrderCode == orderCode);

            if (order != null)
            {
                order.Status = status;

                if (status == "success" && string.IsNullOrEmpty(order.Card))
                {
                    // Tìm thẻ phù hợp chưa dùng
                    var cardToAssign = _context.Cards
                        .FirstOrDefault(c => !c.IsUsed && c.ServiceType == order.Plan && c.Amount == order.Price);

                    if (cardToAssign != null)
                    {
                        order.Card = cardToAssign.Code;
                        cardToAssign.IsUsed = true;
                    }
                    else
                    {
                        TempData["Message"] = $"Không còn mã thẻ phù hợp cho đơn {order.OrderCode}.";
                        return RedirectToAction("Admin");
                    }
                }

                _context.SaveChanges();
                TempData["Message"] = $"Đơn {order.OrderCode} đã cập nhật.";
            }

            return RedirectToAction("Admin");
        }





    }
}
