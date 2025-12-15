using System;
using System.Collections.Generic;
using System.Linq;
using NtpProje.Data.DataModel;
using NtpProje.Entities.Concrete;
using NtpProje.Entities.Logging;

namespace NtpProje.Data.Concrete
{
    public class ProjectRepository : Repository<project>
    {
        /// View kullanarak proje detaylarını getirir
        
        public List<ProjectDTO> GetProjectDetailsFromView()
        {
            try
            {
                // View'ı ExecuteQuery ile çağırıyoruz
                var viewResults = _context.ExecuteQuery<ProjectViewResult>(
                    "SELECT * FROM vw_ProjectDetails"
                ).ToList();

                // View sonuçlarını ProjectDTO'ya map et
                var projectDtos = new List<ProjectDTO>();
                foreach (var view in viewResults)
                {
                    projectDtos.Add(new ProjectDTO
                    {
                        Id = view.project_id,
                        Title = view.project_name ?? "",
                        Description = view.description ?? "",
                        Technologies = view.technologies ?? view.short_description ?? "",
                        ImageUrl = view.image_url ?? "",
                        Category = view.category ?? "",
                        ClientName = view.client_name ?? "",
                        ViewCount = view.view_count ?? 0,
                        CompletionDate = view.completion_date ?? view.project_date,
                        Status = view.status ?? ""
                    });
                }

                return projectDtos;
            }
            catch (Exception ex)
            {
                // View yoksa veya hata varsa normal GetAll() kullan
                System.Diagnostics.Debug.WriteLine("View kullanım hatası: " + ex.Message);
                return GetAll().Select(p => new ProjectDTO
                {
                    Id = p.project_id,
                    Title = p.project_name ?? "",
                    Description = p.description ?? "",
                    Technologies = p.short_description ?? "",
                    ImageUrl = p.image_url ?? "",
                    Category = p.category ?? "",
                    ClientName = p.client_name ?? "",
                    ViewCount = p.view_count ?? 0,
                    CompletionDate = p.project_date,
                    Status = p.status ?? ""
                }).ToList();
            }
        }

        // View'dan dönen sonuç için yardımcı sınıf
        private class ProjectViewResult
        {
            public int project_id { get; set; }
            public string project_name { get; set; }
            public string description { get; set; }
            public string short_description { get; set; }
            public string image_url { get; set; }
            public string thumbnail_url { get; set; }
            public DateTime? project_date { get; set; }
            public DateTime? completion_date { get; set; }
            public string client_name { get; set; }
            public string category { get; set; }
            public string status { get; set; }
            public int? view_count { get; set; }
            public int? technology_count { get; set; }
            public int? image_count { get; set; }
            public string technologies { get; set; }
        }

        /// <summary>
        /// Dashboard sayıları için Stored Procedure çağrısı (sp_GetDashboardCounts)
        /// </summary>
        public DashboardCountsDTO GetDashboardCountsFromSp()
        {
            try
            {
                var result = _context.ExecuteQuery<DashboardCountsDTO>("EXEC sp_GetDashboardCounts").FirstOrDefault();
                return result ?? new DashboardCountsDTO();
            }
            catch (Exception ex)
            {
                AppLogger.LogError(ex, "ProjectRepository.GetDashboardCountsFromSp");
                throw;
            }
        }

        /// <summary>
        /// Aktif projeleri döndüren TVF çağrısı (fn_GetActiveProjects)
        /// </summary>
        public List<ProjectDTO> GetActiveProjectsFromFunction()
        {
            try
            {
                // dbml importu sonrası tipli metot: _context.fn_GetActiveProjects()
                var results = _context.fn_GetActiveProjects().ToList();

                return results.Select(r => new ProjectDTO
                {
                    Id = r.project_id,
                    Title = r.project_name ?? "",
                    Status = r.status ?? "",
                    ViewCount = r.view_count ?? 0,
                    CompletionDate = r.completion_date
                }).ToList();
            }
            catch (Exception ex)
            {
                AppLogger.LogError(ex, "ProjectRepository.GetActiveProjectsFromFunction");
                throw;
            }
        }
    }
}

