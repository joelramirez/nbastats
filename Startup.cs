using Microsoft.Owin;
using Owin;

[assembly: OwinStartup(typeof(NBAStats.Startup))]
namespace NBAStats
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuthentication(app);
            app.MapSignalR();
        }

    }
}
