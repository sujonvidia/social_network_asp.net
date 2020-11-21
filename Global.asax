<%@ Application Language="C#" %>
<%@ Import Namespace="WebSite1" %>
<%@ Import Namespace="System.Web.Optimization" %>
<%@ Import Namespace="System.Web.Routing" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        RouteConfig.RegisterRoutes(RouteTable.Routes);
        BundleConfig.RegisterBundles(BundleTable.Bundles);
     
        //RouteTable.Routes.MapHubs();
    }
    protected void RegisterRoutes(RouteCollection routes)
    {
        routes.MapPageRoute("UserRoute", "{Name}", "~/index_m.aspx");

    }
    void Application_PostAcquireRequestState(object sender, EventArgs e)
    {
        //RegisterRoutes(RouteTable.Routes);
        try
        {
            MembershipUser currentUser = Membership.GetUser();

            Guid currentUserId = (Guid)currentUser.ProviderUserKey;
            string connectionString2 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            //string selectSql = "SELECT * FROM UserLikes WHERE UserId = @UserId";
            string selectSql = "select [FullName] from [UserProfiles] WHERE UserId=@UserId";

            using (System.Data.SqlClient.SqlConnection myConnection = new System.Data.SqlClient.SqlConnection(connectionString2))
            {
                myConnection.Open();
                System.Data.SqlClient.SqlCommand myCommand = new System.Data.SqlClient.SqlCommand(selectSql, myConnection);
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);


                var fname = myCommand.ExecuteScalar();


                if (Context.Session != null)
                {
                    Application.Lock();
                    Session["user"] = fname;
                    Application.UnLock();
                }
                myConnection.Close();

            }
        }
        catch { }
    }

</script>
