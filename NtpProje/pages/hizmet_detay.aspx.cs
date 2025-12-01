using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business.Abstract;
using NtpProje.Business.Concrete;
using NtpProje.Entities.Concrete;

namespace _241613001_Mehmet_Kıvrak_NtpProje.pages
{
    public partial class hizmet_detay : System.Web.UI.Page
    {
        private readonly IBaseService<ServiceDTO> _serviceService = new ServiceService();
        private ServiceDTO _currentService;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadServiceData();
            }
        }

        private void LoadServiceData()
        {
            string idStr = Request.QueryString["id"];
            if (string.IsNullOrEmpty(idStr) || !int.TryParse(idStr, out int serviceId))
            {
                Response.Redirect("hizmetler.aspx");
                return;
            }

            _currentService = _serviceService.GetById(serviceId);
            if (_currentService == null || !_currentService.IsActive)
            {
                Response.Redirect("hizmetler.aspx");
                return;
            }

            // View count artır
            _currentService.ViewCount++;
            _serviceService.Update(_currentService);

            // Sayfayı doldur
            BindServiceData();
        }

        private void BindServiceData()
        {
            if (_currentService == null) return;

            // Başlık ve ikon
            var hizmetBaslik = FindControlRecursive(Page, "hizmetBaslik") as Literal;
            if (hizmetBaslik != null)
            {
                string icon = !string.IsNullOrEmpty(_currentService.Icon) ? _currentService.Icon : "💻";
                hizmetBaslik.Text = $"<span class=\"hizmet_icon\">{icon}</span>{_currentService.Name}";
            }

            // Özet
            var hizmetOzet = FindControlRecursive(Page, "hizmetOzet") as Literal;
            if (hizmetOzet != null)
            {
                hizmetOzet.Text = !string.IsNullOrEmpty(_currentService.ShortDescription) 
                    ? _currentService.ShortDescription 
                    : _currentService.Description;
            }

            // Ana görsel
            var hizmetAnaGorsel = FindControlRecursive(Page, "hizmetAnaGorsel") as Literal;
            if (hizmetAnaGorsel != null)
            {
                if (!string.IsNullOrEmpty(_currentService.ImageUrl))
                {
                    string imageUrl = _currentService.ImageUrl;
                    if (!imageUrl.StartsWith("http://") && !imageUrl.StartsWith("https://") && !imageUrl.StartsWith("/"))
                    {
                        imageUrl = ResolveUrl("~/images/" + imageUrl);
                    }
                    hizmetAnaGorsel.Text = $"<img src=\"{imageUrl}\" alt=\"{_currentService.Name}\" />";
                }
                else if (!string.IsNullOrEmpty(_currentService.Icon))
                {
                    hizmetAnaGorsel.Text = $"<div style=\"text-align:center;padding:60px;font-size:120px;\">{_currentService.Icon}</div>";
                }
            }

            // Detay içerik
            var hizmetDetayIcerik = FindControlRecursive(Page, "hizmetDetayIcerik") as Literal;
            if (hizmetDetayIcerik != null)
            {
                hizmetDetayIcerik.Text = !string.IsNullOrEmpty(_currentService.Description) 
                    ? _currentService.Description 
                    : "<p>Detaylı bilgi yakında eklenecektir.</p>";
            }

            // Features (Özellikler)
            BindFeatures();

            // Technologies (Teknolojiler)
            BindTechnologies();

            // Process Steps (Süreç Adımları)
            BindProcessSteps();

            // Highlight Features (Öne Çıkan Özellikler)
            BindHighlightFeatures();

            // Why Choose Us (Neden Bizi Tercih Etmelisiniz)
            BindWhyChooseUs();
        }

        private void BindFeatures()
        {
            var ph = FindControlRecursive(Page, "phFeatures") as PlaceHolder;
            var rpt = FindControlRecursive(Page, "rptFeatures") as Repeater;
            
            if (ph != null && rpt != null && !string.IsNullOrEmpty(_currentService.Features))
            {
                var features = ParseFeatures(_currentService.Features);
                if (features.Count > 0)
                {
                    rpt.DataSource = features;
                    rpt.DataBind();
                    ph.Visible = true;
                }
            }
        }

        private void BindTechnologies()
        {
            var ph = FindControlRecursive(Page, "phTechnologies") as PlaceHolder;
            var rpt = FindControlRecursive(Page, "rptTechnologies") as Repeater;
            
            if (ph != null && rpt != null && !string.IsNullOrEmpty(_currentService.Technologies))
            {
                var technologies = ParseTechnologies(_currentService.Technologies);
                if (technologies.Count > 0)
                {
                    rpt.DataSource = technologies;
                    rpt.DataBind();
                    ph.Visible = true;
                }
            }
        }

        private void BindProcessSteps()
        {
            var ph = FindControlRecursive(Page, "phProcessSteps") as PlaceHolder;
            var rpt = FindControlRecursive(Page, "rptProcessSteps") as Repeater;
            
            if (ph != null && rpt != null && !string.IsNullOrEmpty(_currentService.ProcessSteps))
            {
                var steps = ParseProcessSteps(_currentService.ProcessSteps);
                if (steps.Count > 0)
                {
                    rpt.DataSource = steps;
                    rpt.DataBind();
                    ph.Visible = true;
                }
            }
        }

        private void BindHighlightFeatures()
        {
            var ph = FindControlRecursive(Page, "phHighlightFeatures") as PlaceHolder;
            var rpt = FindControlRecursive(Page, "rptHighlightFeatures") as Repeater;
            
            if (ph != null && rpt != null && !string.IsNullOrEmpty(_currentService.HighlightFeatures))
            {
                var features = ParseHighlightFeatures(_currentService.HighlightFeatures);
                if (features.Count > 0)
                {
                    rpt.DataSource = features;
                    rpt.DataBind();
                    ph.Visible = true;
                }
            }
        }

        private void BindWhyChooseUs()
        {
            var ph = FindControlRecursive(Page, "phWhyChooseUs") as PlaceHolder;
            var rpt = FindControlRecursive(Page, "rptWhyChooseUs") as Repeater;
            
            if (ph != null && rpt != null && !string.IsNullOrEmpty(_currentService.WhyChooseUs))
            {
                var reasons = ParseWhyChooseUs(_currentService.WhyChooseUs);
                if (reasons.Count > 0)
                {
                    rpt.DataSource = reasons;
                    rpt.DataBind();
                    ph.Visible = true;
                }
            }
        }

        // Parse metodları
        private List<FeatureItem> ParseFeatures(string featuresText)
        {
            var list = new List<FeatureItem>();
            if (string.IsNullOrEmpty(featuresText)) return list;

            var lines = featuresText.Split(new[] { '\n', '\r' }, StringSplitOptions.RemoveEmptyEntries);
            foreach (var line in lines)
            {
                var parts = line.Split('|');
                if (parts.Length >= 3)
                {
                    list.Add(new FeatureItem
                    {
                        Icon = parts[0].Trim(),
                        Title = parts[1].Trim(),
                        Description = parts[2].Trim()
                    });
                }
            }
            return list;
        }

        private List<TechnologyCategory> ParseTechnologies(string technologiesText)
        {
            var list = new List<TechnologyCategory>();
            if (string.IsNullOrEmpty(technologiesText)) return list;

            var lines = technologiesText.Split(new[] { '\n', '\r' }, StringSplitOptions.RemoveEmptyEntries);
            foreach (var line in lines)
            {
                var parts = line.Split(':');
                if (parts.Length >= 2)
                {
                    var category = parts[0].Trim();
                    var items = parts[1].Split(',').Select(x => x.Trim()).Where(x => !string.IsNullOrEmpty(x)).ToList();
                    if (items.Count > 0)
                    {
                        list.Add(new TechnologyCategory
                        {
                            Category = category,
                            Items = items
                        });
                    }
                }
            }
            return list;
        }

        private List<ProcessStep> ParseProcessSteps(string processStepsText)
        {
            var list = new List<ProcessStep>();
            if (string.IsNullOrEmpty(processStepsText)) return list;

            var lines = processStepsText.Split(new[] { '\n', '\r' }, StringSplitOptions.RemoveEmptyEntries);
            foreach (var line in lines)
            {
                var parts = line.Split('|');
                if (parts.Length >= 2)
                {
                    list.Add(new ProcessStep
                    {
                        Title = parts[0].Trim(),
                        Description = parts[1].Trim()
                    });
                }
            }
            return list;
        }

        private List<FeatureItem> ParseHighlightFeatures(string highlightFeaturesText)
        {
            var list = new List<FeatureItem>();
            if (string.IsNullOrEmpty(highlightFeaturesText)) return list;

            var lines = highlightFeaturesText.Split(new[] { '\n', '\r' }, StringSplitOptions.RemoveEmptyEntries);
            foreach (var line in lines)
            {
                var parts = line.Split('|');
                if (parts.Length >= 2)
                {
                    list.Add(new FeatureItem
                    {
                        Title = parts[0].Trim(),
                        Description = parts[1].Trim()
                    });
                }
            }
            return list;
        }

        private List<FeatureItem> ParseWhyChooseUs(string whyChooseUsText)
        {
            var list = new List<FeatureItem>();
            if (string.IsNullOrEmpty(whyChooseUsText)) return list;

            var lines = whyChooseUsText.Split(new[] { '\n', '\r' }, StringSplitOptions.RemoveEmptyEntries);
            foreach (var line in lines)
            {
                var parts = line.Split('|');
                if (parts.Length >= 2)
                {
                    list.Add(new FeatureItem
                    {
                        Title = parts[0].Trim(),
                        Description = parts[1].Trim()
                    });
                }
            }
            return list;
        }

        // Helper sınıflar
        public class FeatureItem
        {
            public string Icon { get; set; }
            public string Title { get; set; }
            public string Description { get; set; }
        }

        public class TechnologyCategory
        {
            public string Category { get; set; }
            public List<string> Items { get; set; }
        }

        public class ProcessStep
        {
            public string Title { get; set; }
            public string Description { get; set; }
        }

        // Technologies Repeater ItemDataBound
        protected void rptTechnologies_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var category = e.Item.DataItem as TechnologyCategory;
                if (category != null && category.Items != null)
                {
                    var rptTechItems = e.Item.FindControl("rptTechItems") as Repeater;
                    if (rptTechItems != null)
                    {
                        rptTechItems.DataSource = category.Items;
                        rptTechItems.DataBind();
                    }
                }
            }
        }

        protected Control FindControlRecursive(Control root, string id)
        {
            if (root.ID == id) return root;
            foreach (Control c in root.Controls)
            {
                Control t = FindControlRecursive(c, id);
                if (t != null) return t;
            }
            return null;
        }

        public string GetServiceImage(object imageUrl, object icon)
        {
            if (imageUrl != null && !string.IsNullOrEmpty(imageUrl.ToString()))
            {
                string url = imageUrl.ToString();
                if (!url.StartsWith("http://") && !url.StartsWith("https://") && !url.StartsWith("/"))
                {
                    url = ResolveUrl("~/images/" + url);
                }
                return $"<img src=\"{url}\" alt=\"Hizmet Görseli\" />";
            }
            else if (icon != null && !string.IsNullOrEmpty(icon.ToString()))
            {
                return $"<div class=\"hizmet_icon\">{icon}</div>";
            }
            return "<div class=\"hizmet_icon\">💻</div>";
        }
    }
}