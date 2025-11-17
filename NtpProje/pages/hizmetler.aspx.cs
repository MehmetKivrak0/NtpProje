using NtpProje.Business.Concrete;
using NtpProje.Entities.Concrete;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls; // Repeater için gerekli

namespace _241613001_Mehmet_Kıvrak_NtpProje.pages
{
    // rptHizmetler'i görmesi için manuel tanımlama (en inatçı hatalar için)
    public partial class hizmetler : System.Web.UI.Page
    {

        private readonly ServiceService _serviceService = new ServiceService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindServices();
            }
        }

        private void BindServices()
        {
            try
            {
                // 1. ServiceService'den aktif hizmet listesini al
                // Bu metot, List<ServiceDTO> döndürmelidir.
                List<ServiceDTO> hizmetler = _serviceService.GetAll();

                // 2. Repeater'a bağla
                rptHizmetler.DataSource = hizmetler;
                rptHizmetler.DataBind();
            }
            catch (Exception ex)
            {
                // Hata Loglama ve bilgilendirme
                System.Diagnostics.Debug.WriteLine("HİZMETLER YÜKLEME HATASI: " + ex.ToString());
                // Response.Write("Hizmetler yüklenirken bir sorun oluştu.");
            }
        }
    }
}