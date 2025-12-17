using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.DTOs
{
    public class ProjectDTO : BaseDTO
    {
        // SQL: project_id
        public int Id { get; set; }

        // SQL: project_name
        public string Title { get; set; }

        // SQL: description
        public string Description { get; set; }

        // SQL: short_description (Sitede Teknolojiler olarak g�r�necek)
        public string Technologies { get; set; }

        // SQL: image_url
        public string ImageUrl { get; set; }

        // SQL: category_id (categories tablosuna foreign key)
        public int CategoryId { get; set; }
        
        // UI için JOIN sonucu (veritabanında yok)
        public string CategoryName { get; set; }

        // SQL: client_name
        public string ClientName { get; set; }

        // SQL: view_count
        public int ViewCount { get; set; }

        // SQL: completion_date
        public DateTime? CompletionDate { get; set; }

        // SQL: status
        public string Status { get; set; }
    }
}