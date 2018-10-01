using System;
using System.Collections.Generic;
using System.Net.Mail;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace NBAStats
{
    public partial class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            GlobalConfiguration.Configure(WebApiConfig.Register);
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);            
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        protected void Application_Error(object sender, EventArgs e)
        {
            // Code that runs when an unhandled error occurs

            // Get the exception object.
            Exception exc = Server.GetLastError();

            // Handle HTTP errors
            if (exc.GetType() == typeof(HttpException))
            {
                // The Complete Error Handling Example generates
                // some errors using URLs with "NoCatch" in them;
                // ignore these here to simulate what would happen
                // if a global.asax handler were not implemented.
                if (exc.Message.Contains("NoCatch") || exc.Message.Contains("maxUrlLength"))
                {
                    return;
                }
                else
                {
                    Elmah.ErrorSignal.FromCurrentContext().Raise(exc);                    
                }
            }
        }

        //ELMAH Emailer
        protected void ErrorMail_Mailing(object sender, Elmah.ErrorMailEventArgs e)
        {
            var toAddress = new MailAddressCollection();
            toAddress.Add(GlobalVariables.MAIL_TO);

            e.Mail.To.Clear();
            e.Mail.To.Add(toAddress.ToString());

            e.Mail.From = new MailAddress(GlobalVariables.MAIL_FROM);

            e.Mail.Subject = "[" + GlobalVariables.ENVIRONMENT + "] Exception from NBA Stats Page";
        }
    }
}
