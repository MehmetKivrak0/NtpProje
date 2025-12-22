using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.DTOs
{
    // Dashboard özet metrikleri için basit DTO
    public class DashboardCountsDTO : BaseDTO
    {
        // Projeler
        public int TotalProjects { get; set; }
        public int ActiveProjects { get; set; }
        public int CompletedProjects { get; set; }
        
        // Hizmetler
        public int TotalServices { get; set; }
        
        // Takım Üyeleri
        public int TotalTeamMembers { get; set; }
        
        // Blog Yazıları
        public int TotalPosts { get; set; }
        
        // Yorumlar
        public int PendingComments { get; set; }
        
        // Mesajlar
        public int UnreadMessages { get; set; }
        public int UnreadRequests { get; set; }
        
        // Kullanıcılar
        public int TotalUsers { get; set; }
    }
}

