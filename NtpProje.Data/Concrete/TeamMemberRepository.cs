using NtpProje.Data.Abstract;
using NtpProje.Data.DataModel; // DataContext ve team_member Entity'si için
using System.Linq;
using System.Collections.Generic;
using System.Linq.Expressions;
using System;

namespace NtpProje.Data.Concrete
{
    // IRepository'yi 'team_member' Entity'si ile uyguluyoruz.
    public class TeamMemberRepository : IRepository<team_member>
    {
        private readonly ýnnovateyzlmDataContext _context = new ýnnovateyzlmDataContext();

        // ** ADD **
        public void Add(team_member entity)
        {
            _context.team_members.InsertOnSubmit(entity);
            _context.SubmitChanges();
        }

        // ** UPDATE **
        public void Update(team_member entity)
        {
            // LINQ to SQL: Varlýk takip edildiði için sadece SubmitChanges yeterlidir.
            _context.SubmitChanges();
        }

        // ** DELETE **
        public void Delete(team_member entity)
        {
            _context.team_members.DeleteOnSubmit(entity);
            _context.SubmitChanges();
        }

        // ** GET BY ID **
        public team_member Get(int id)
        {
            return _context.team_members.FirstOrDefault(tm => tm.team_member_id == id);
        }

        // ** GET BY FILTER **
        public team_member Get(Expression<Func<team_member, bool>> filter)
        {
            return _context.team_members.FirstOrDefault(filter);
        }

        // ** GET ALL **
        public List<team_member> GetAll()
        {
            return _context.team_members.ToList();
        }

        // ** GET ALL WITH FILTER **
        public List<team_member> GetAll(Expression<Func<team_member, bool>> filter)
        {
            return _context.team_members.Where(filter).ToList();
        }
    }
}