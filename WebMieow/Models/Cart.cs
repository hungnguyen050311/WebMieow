using Microsoft.AspNetCore.Mvc;

namespace WebMieow.Models
{
    public class Cart : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
