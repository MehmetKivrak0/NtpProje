using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.DTOs
{
    // Dashboard özet metrikleri için basit DTO
    public class DashboardCountsDTO : BaseDTO
    {
        public int TotalPosts { get; set; }
        public int PendingComments { get; set; }
        public int UnreadRequests { get; set; }
        public int TotalUsers { get; set; }
    }
}

