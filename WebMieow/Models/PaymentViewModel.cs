using Microsoft.AspNetCore.Mvc;
using System.ComponentModel.DataAnnotations;

namespace WebMieow.Models
{
    public class PaymentViewModel
    {
        public string? Email { get; set; }
        public string? Plan { get; set; }
        public int Amount { get; set; }
        public string? Code { get; set; }
        public Order? Order { get; set; }
    }


}

