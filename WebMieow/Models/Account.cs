using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebMieow.Models
{
    public class Account
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string Username { get; set; }

        public string Password { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string FullName { get; set; }
        public string Address { get; set; }

        public int Role { get; set; } = 0; // 0: User, 1: Admin

        public ICollection<Order> Orders { get; set; }
    }




}
