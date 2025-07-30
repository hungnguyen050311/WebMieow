using Microsoft.AspNetCore.Mvc;

namespace WebMieow.Models
{
    public class Product : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
