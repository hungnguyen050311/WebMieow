using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebMieow.Models
{
    public class Order
    {
        [Key]
        public int OrderId { get; set; }

        // Khóa ngoại đến Account
        [ForeignKey("Account")]
        public int AccountId { get; set; }
        public Account Account { get; set; }

        // Thông tin đơn hàng
        public string Username { get; set; }
        public string Contact { get; set; }
        public string OrderCode { get; set; }
        public DateTime CreatedAt { get; set; }
        public string Status { get; set; }
        public string? Card { get; set; }

        // Chi tiết người mua
        public string Email { get; set; }
        public string Phone { get; set; }

        // Gói dịch vụ
        public string Plan { get; set; }
        public string ServiceType { get; set; }
        public int Price { get; set; }
    }


    public class OrdersRoot
    {
        public List<Order> orders { get; set; }
    }
}
