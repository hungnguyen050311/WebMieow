using System.ComponentModel.DataAnnotations;

namespace WebMieow.Models
{
    public class Card
    {
        public int Id { get; set; }  // ID tự tăng
        public string Code { get; set; }  // Mã thẻ
        public string ServiceType { get; set; }  // Steam, Netflix...
        public int Amount { get; set; }  // Mệnh giá
        public bool IsUsed { get; set; }  // Đã dùng hay chưa
    }

}
