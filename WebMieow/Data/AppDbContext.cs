using Microsoft.EntityFrameworkCore;
using WebMieow.Models;

namespace WebMieow.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<Account> Accounts { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<CardStock> CardStock { get; set; }
        public DbSet<Card> Cards { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // Cấu hình quan hệ Order - Account
            modelBuilder.Entity<Order>()
            .HasOne(o => o.Account)
            .WithMany(a => a.Orders) // <<< thêm dòng này
            .HasForeignKey(o => o.AccountId)
            .OnDelete(DeleteBehavior.Cascade);


            // Gọi hàm seed nhiều loại Card
            SeedCards(modelBuilder);

            base.OnModelCreating(modelBuilder);


        }

        private void SeedCards(ModelBuilder modelBuilder)
        {
            var cards = new List<Card>();
            int idCounter = 1;

            var serviceData = new Dictionary<string, List<int>>()
            {
                { "Steam",        new List<int> { 100000, 200000, 500000 } },
                { "Netflix",      new List<int> { 150000, 300000 } },
                { "Zing",         new List<int> { 50000, 100000 } },
                { "Garena",       new List<int> { 20000, 50000, 100000 } },
                { "Google Play",  new List<int> { 100000, 200000 } },
                { "Spotify",      new List<int> { 59000, 129000 } }
            };

            foreach (var service in serviceData)
            {
                foreach (var amount in service.Value)
                {
                    for (int i = 1; i <= 2; i++) // Mỗi loại 2 mã thẻ
                    {
                        cards.Add(new Card
                        {
                            Id = idCounter++,
                            Code = $"{service.Key.ToUpper().Replace(" ", "")}{amount / 1000:D3}_{i}",
                            ServiceType = service.Key,
                            Amount = amount,
                            IsUsed = false
                        });
                    }
                }
            }

            modelBuilder.Entity<Card>().HasData(cards);
        }
    }
}
