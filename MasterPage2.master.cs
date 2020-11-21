using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Providers;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage2 : System.Web.UI.MasterPage, IPostBackEventHandler
{
  public  Guid currentUserId;
  string path;
  string user_name;
  Guid user_id=Guid.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["user_name"] != null)
        {
            if (!String.IsNullOrEmpty(Request.Cookies["user_name"].Value))
            {
                user_name = Request.Cookies["user_name"].Value;
            }
        }
      
         path = HttpContext.Current.Request.Url.AbsolutePath;

        if (path.Contains("index"))
        {
            profile_line.Visible = true;
        }
        if (path.Contains("home"))
        {
            home_line.Visible = true;
        }
        if (path.Contains("race"))
        {
            race_line.Visible = true;
        }
        if (path.Contains("covert"))
        {
            covert_line.Visible = true;
        }

        if (Page.User.Identity.IsAuthenticated)
        {
            
            MembershipUser currentUser = Membership.GetUser();

            currentUserId = (Guid)currentUser.ProviderUserKey;
            current_user_id.Value = currentUserId.ToString();
        }
        else
        {
            Response.Redirect("~/login.aspx");
        }

        u1905.Attributes["onclick"] = Page.ClientScript.GetPostBackEventReference(this, "ClickSettings");
        u1919.Attributes["onclick"] = Page.ClientScript.GetPostBackEventReference(this, "ClickNotifications");
        u1912.Attributes["onclick"] = Page.ClientScript.GetPostBackEventReference(this, "ClickMessaging");
        u1926.Attributes["onclick"] = Page.ClientScript.GetPostBackEventReference(this, "ClickFriendrequest"); 
        u1948.Attributes["onclick"] = Page.ClientScript.GetPostBackEventReference(this, "ClickLogout");
        home_link.Attributes["onclick"] = Page.ClientScript.GetPostBackEventReference(this, "ClickHome");
        covert_link.Attributes["onclick"] = Page.ClientScript.GetPostBackEventReference(this, "ClickCovert");
        race_link.Attributes["onclick"] = Page.ClientScript.GetPostBackEventReference(this, "ClickRace");
        profile_link.Attributes["onclick"] = Page.ClientScript.GetPostBackEventReference(this, "ClickProfile");
        try { 
        user_id = (Guid) Session["user_id"];
        }
        catch { }
     
        //var user_search = HttpContext.Current.Session["user_search"];
        //string pg = Page.ToString();
        //if (!pg.Contains("profile_list_search"))
        //{
        //    user_search = null;
        //}
        //if (user_search==null){
        //    bdy1.Attributes.Add("style", "background: url('" + "ThumbnailHandlerBackground.ashx?userid=" + user_id + "') no-repeat center center fixed;background-size: cover;width:100%");
        //}
        //else
        //{
        if (user_id == Guid.Empty || path.Contains("friendrequest") || path.Contains("settings") || path.Contains("Messaging") || path.Contains("Notifications"))
        {
            bdy1.Attributes.Add("style", "background: url('" + "ThumbnailHandlerBackground.ashx?userid=" + currentUserId + "') no-repeat center center fixed;background-size: cover;width:100%");
        }
        else
        {
            bdy1.Attributes.Add("style", "background: url('" + "ThumbnailHandlerBackground.ashx?userid=" + Session["user_id"].ToString() + "') no-repeat center center fixed;background-size: cover;width:100%");

        }

        //}
    }
    protected void u1948_Click()
    {

        FormsAuthentication.SignOut();
        FormsAuthentication.RedirectToLoginPage();

    }
    protected void u4882_Click()
    {

        if (path.Contains("list"))
        {
            Response.Redirect("~/home-list_m.aspx?un=" + user_name);
        } else
            Response.Redirect("~/home_m.aspx?un=" + user_name);

    }

    protected void u4889_Click()
    {
        if (path.Contains("list"))
        {
            Response.Redirect("~/covert-list_m.aspx?un=" + user_name);
        } else
            Response.Redirect("~/covert_m.aspx?un=" + user_name);

    }

    protected void u4875_Click()
    {
        if (path.Contains("list"))
        {
            Response.Redirect("~/race-list_m.aspx?un=" + user_name);
        } else
            Response.Redirect("~/race_m.aspx?un=" + user_name);

    }

    protected void u1905_Click()
    {
      {
            Response.Redirect("~/settings.aspx?un=" + user_name);
        }      
 }
 

protected void u1912_Click()
    {    
          Response.Redirect("~/Messaging.aspx?un=" + user_name);
               }


protected void u1919_Click()
    {
       Response.Redirect("~/Notifications.aspx?un=" + user_name);
      }

protected void u1926_Click()
    {
     Response.Redirect("~/friendrequest.aspx?un=" + user_name);
 }


    protected void u4896_Click()
    {
        if (path.Contains("list"))
        {
            Response.Redirect("~/profile-list_m.aspx?un=" + user_name);
        } else
            Response.Redirect("~/index_m.aspx?un=" + user_name);

    }
    #region IPostBackEventHandler Members

    public void RaisePostBackEvent(string eventArgument)
    {

        if (!string.IsNullOrEmpty(eventArgument))
        {

            if (eventArgument == "ClickLogout") { u1948_Click(); }
            if (eventArgument == "ClickHome") { u4882_Click(); }
            if (eventArgument == "ClickCovert") { u4889_Click(); }
            if (eventArgument == "ClickRace") { u4875_Click(); }
            if (eventArgument == "ClickProfile") { u4896_Click(); }
            if (eventArgument == "ClickSettings") { u1905_Click(); }
            if (eventArgument == "ClickMessaging") { u1912_Click(); }
            if (eventArgument == "ClickNotifications") { u1919_Click(); }
            if (eventArgument == "ClickFriendrequest") { u1926_Click(); }


        }

    }

    #endregion
    public string getGroupName(int n)
    {

        string result = "";

        switch (n)
        {
            case 0:
                result = "Recruit";
                break;
            case 1:
                result = "Beginner";
                break;
            case 2:
                result = "Newbie";
                break;
            case 3:
                result = "Raw";
                break;
            case 4:
                result = "Greenhorn";
                break;
            case 5:
                result = "Ardent";
                break;
            case 6:
                result = "Escalate";
                break;
            case 7:
                result = "Tanatious";
                break;
            case 8:
                result = "Wiseman";
                break;
            case 9:
                result = "Aristocrat";
                break;
            case 10:
                result = "Avant-Grade";
                break;
            case 11:
                result = "Master";
                break;
            case 12:
                result = "Grand-Master";
                break;
            case 13:
                result = "Magestic";
                break;
            case 14:
                result = "Legend";
                break;
            case 15:
                result = "Oracle";
                break;
            case 16:
                result = "Inhuman";
                break;
            case 17:
                result = "Unparalleled";
                break;
            case 18:
                result = "Mythical";
                break;
            case 19:
                result = "Divine";
                break;
            default:
                Console.WriteLine("Default case");
                break;
        };

        return result;
    }
    public void UpdateNotifications(Guid currentUser_Id) 
    {
        string connectionString4 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string insertSql3 = "SELECT COUNT(NotifyTo) FROM [Notifications] WHERE ([NotifyTo] = @NotifyTo and MarkasRead=0)";

        using (SqlConnection myConnection = new SqlConnection(connectionString4))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql3, myConnection);
            myCommand.Parameters.AddWithValue("@NotifyTo", currentUser_Id);
       

          var n=  myCommand.ExecuteScalar();
          Label1.Text = n.ToString();
          if (Label1.Text == "0") { Label1.Visible = false; }
            myConnection.Close();
        }

        string connectionString5 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string insertSql4 = "SELECT COUNT(DISTINCT Message_from) FROM [Messaging] WHERE ([Message_to] = @Message_to)";

        using (SqlConnection myConnection = new SqlConnection(connectionString5))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql4, myConnection);
            myCommand.Parameters.AddWithValue("@Message_to", currentUser_Id);


            var n = myCommand.ExecuteScalar();
            Label2.Text = n.ToString();
            if (Label2.Text == "0") { Label2.Visible = false; }
            myConnection.Close();
        }
        string connectionString6 = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
        string insertSql5 = "SELECT COUNT(Request_to) FROM [FriendRequests] WHERE ([Request_to] = @Request_to and Request_status=0)";

        using (SqlConnection myConnection = new SqlConnection(connectionString6))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSql5, myConnection);
            myCommand.Parameters.AddWithValue("@Request_to", currentUser_Id);


            var n = myCommand.ExecuteScalar();
            Label3.Text = n.ToString();
            if (Label3.Text == "0") { Label3.Visible = false; }
            myConnection.Close();
        }
    
    }
    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters["@UserId"].Value = currentUserId;
    }
}
