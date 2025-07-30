using Microsoft.AspNetCore.Mvc;

namespace WebMieow.Controllers
{
    public class TestController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
