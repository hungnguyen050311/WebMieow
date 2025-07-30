using System.ComponentModel.DataAnnotations;

namespace WebMieow.Models
{
    public class CardStock
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string Type { get; set; } // ví dụ: "Garena", "Steam Wallet", "Netflix",...

        [Required]
        public int Amount { get; set; } // số tiền: 100000, 245000...

        [Required]
        public string Code { get; set; } // mã thẻ: ví dụ 1234-5678-9999

        public bool IsUsed { get; set; } = false; // đã được giao cho đơn nào chưa

        public string? OrderCode { get; set; } // lưu mã đơn nếu đã gán
    }

}
