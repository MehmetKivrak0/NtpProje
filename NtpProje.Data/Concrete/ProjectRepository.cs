using System;
using System.Collections.Generic;
using System.Linq;
using NtpProje.Data.DataModel;
using NtpProje.Entities.DTOs;

namespace NtpProje.Data.Concrete
{
    /// <summary>
    /// ProjectRepository - Generic Repository'den türetilmiş + Özel metodlar içeren
    /// NOT: VIEW, SP, Function veritabanında var ama LINQ to SQL DataContext'te tanımlı değil.
    /// Bu yüzden normal LINQ sorguları kullanılıyor (Alternatif implementasyon)
    /// </summary>
    public class ProjectRepository : Repository<project>
    {
        // Generic Repository'den constructor kalıtım alınıyor
        // GetAll(), Get(), Add(), Update(), Delete() metodları zaten Generic Repository'de var

        // ========================================
        // ÖZEL METODLAR (VIEW Alternatifi - Normal LINQ)
        // ========================================

        /// <summary>
        /// VIEW alternatifi: Proje detaylarını normal LINQ ile getirir
        /// NOT: vw_ProjectDetails VIEW'ı veritabanında var ama DataContext'te tanımlı değil
        /// </summary>
        public List<ProjectDTO> GetProjectDetailsFromView()
        {
            try
            {
                // VIEW yerine normal LINQ sorgusu
                var projects = _context.projects.ToList();

                var dtos = new List<ProjectDTO>();
                foreach (var p in projects)
                {
                    dtos.Add(new ProjectDTO
                    {
                        Id = p.project_id,
                        Title = p.project_name ?? string.Empty,
                        Description = p.description ?? string.Empty,
                        ClientName = p.client_name ?? string.Empty,
                        ImageUrl = p.image_url ?? string.Empty,
                        IsActive = p.is_published ?? false
                    });
                }
                return dtos;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("GetProjectDetailsFromView Hatası: " + ex.Message);
                return new List<ProjectDTO>();
            }
        }

        /// <summary>
        /// Stored Procedure alternatifi: Dashboard sayılarını normal LINQ ile hesaplar
        /// NOT: sp_GetDashboardCounts SP'si veritabanında var ama DataContext'te tanımlı değil
        /// </summary>
        public DashboardCountsDTO GetDashboardCountsFromSp()
        {
            try
            {
                // SP yerine normal LINQ ile sayım
                return new DashboardCountsDTO
                {
                    TotalProjects = _context.projects.Count(),
                    ActiveProjects = _context.projects.Count(p => p.is_published == true),
                    CompletedProjects = _context.projects.Count(p => p.status == "Completed"),
                    TotalServices = _context.services.Count(),
                    TotalTeamMembers = _context.team_members.Count(),
                    TotalPosts = _context.posts.Count(),
                    UnreadMessages = _context.contact_messages.Count(c => c.is_read == false)
                };
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("GetDashboardCountsFromSp Hatası: " + ex.Message);
                return new DashboardCountsDTO();
            }
        }

        /// <summary>
        /// Function alternatifi: Aktif projeleri normal LINQ ile getirir
        /// NOT: fn_GetActiveProjects Function'ı veritabanında var ama DataContext'te tanımlı değil
        /// </summary>
        public List<ProjectDTO> GetActiveProjectsFromFunction()
        {
            try
            {
                // Function yerine normal LINQ sorgusu
                var activeProjects = _context.projects
                    .Where(p => p.is_published == true)
                    .ToList();

                var dtos = new List<ProjectDTO>();
                foreach (var p in activeProjects)
                {
                    dtos.Add(new ProjectDTO
                    {
                        Id = p.project_id,
                        Title = p.project_name ?? string.Empty,
                        Description = p.description ?? string.Empty,
                        ClientName = p.client_name ?? string.Empty,
                        ImageUrl = p.image_url ?? string.Empty,
                        IsActive = p.is_published ?? false
                    });
                }
                return dtos;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("GetActiveProjectsFromFunction Hatası: " + ex.Message);
                return new List<ProjectDTO>();
            }
        }
    }
}
