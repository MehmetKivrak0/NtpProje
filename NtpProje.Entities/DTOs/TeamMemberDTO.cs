using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.DTOs
{
    public class TeamMemberDTO : BaseDTO
    {
        // SQL: team_member_id
        public int Id { get; set; }

        // SQL: name (Ad ve Soyad tek s�tunda tutuluyor)
        public string Name { get; set; }

        // SQL: title
        public string Title { get; set; }

        // SQL: position
        public string Position { get; set; }

        // SQL: image_url
        public string ImageUrl { get; set; }

        // SQL: bio
        public string Bio { get; set; }

        // SQL: email
        public string Email { get; set; }

        // SQL: phone_number
        public string PhoneNumber { get; set; }

        // SQL: linkedin_url
        public string LinkedInUrl { get; set; }

        // SQL: twitter_url
        public string TwitterUrl { get; set; }

        // SQL: github_url
        public string GithubUrl { get; set; }

        // SQL: is_active
        public bool IsActive { get; set; }

        // SQL: display_order
        public int DisplayOrder { get; set; }
    }
}