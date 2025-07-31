using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace WebMieow.Models
{
    public class ProfileViewModel
    {
        
        public Account Account { get; set; }

        // Các thông tin tài khoản
        
        public string Username { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string FullName { get; set; }
        public string Address { get; set; }

        public int Role { get; set; } // ➕ thêm Role vào ViewModel


        // Danh sách đơn hàng
        public List<Order> Orders { get; set; }
    }
}
