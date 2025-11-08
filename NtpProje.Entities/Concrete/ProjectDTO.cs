using System;

namespace NtpProje.Entities.Concrete
{
    public class ProjectDTO
    {
        public int ProjectId { get; set; }
        public string ProjectName { get; set; }
        public string Description { get; set; }
        public string ImageUrl { get; set; }
        public DateTime ProjectDate { get; set; }
        public string ClientName { get; set; }

        public ProjectDTO() { }

        public ProjectDTO(int projectId, string projectName, string description)
        {
            this.ProjectId = projectId;
            this.ProjectName = projectName;
            this.Description = description;
        }

        public override string ToString()
        {
            return $"Project: {ProjectName} - Client: {ClientName}";
        }
    }
}

