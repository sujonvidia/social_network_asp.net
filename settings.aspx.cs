using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default3 : System.Web.UI.Page
{
    Guid currentUserId;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (User.Identity.IsAuthenticated)
        {
            Page.Title = HttpContext.Current.Session["user"].ToString();
            MembershipUser currentUser = Membership.GetUser();

            currentUserId = (Guid)currentUser.ProviderUserKey;
            (this.Master as MasterPage2).UpdateNotifications(currentUserId);

        }
        else
        {
            Response.Redirect("~/login.aspx");
        }
    }
    protected void ProfileGeneralDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();

        if (currentUser != null)
        {
            // Determine the currently logged on user's UserId value
             currentUserId = (Guid)currentUser.ProviderUserKey;

            // Assign the currently logged on user's UserId to the @UserId parameter
            e.Command.Parameters["@UserId"].Value = currentUserId;
        }
    }
   
    protected void ddlPrivacyPost_TextChanged(object sender, EventArgs e)
    {
        try
        {
            string connectionString =
               ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string updateSql = "INSERT INTO UserSettings(UserId,PrivacyPost) VALUES(@UserId,@PrivacyPost)";

            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(updateSql, myConnection);
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                myCommand.Parameters.AddWithValue("@PrivacyPost", ddlPrivacyPost.SelectedValue);

                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
        }
        catch
        {
            string connectionString2 =
               ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string updateSql2 = "update UserSettings set PrivacyPost=@PrivacyPost where UserId=@UserId";

            using (SqlConnection myConnection = new SqlConnection(connectionString2))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(updateSql2, myConnection);
               
                myCommand.Parameters.AddWithValue("@PrivacyPost", ddlPrivacyPost.SelectedValue);
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
        }
    }
    protected void ddlFrdReqWho_TextChanged(object sender, EventArgs e)
    {
        try
        {
            string connectionString =
               ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string updateSql = "INSERT INTO UserSettings(UserId,PrivacyFrdReq) VALUES(@UserId,@PrivacyFrdReq)";

            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(updateSql, myConnection);
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                myCommand.Parameters.AddWithValue("@PrivacyFrdReq", ddlFrdReqWho.SelectedValue);

                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
        }
        catch
        {
            string connectionString2 =
               ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string updateSql2 = "update UserSettings set PrivacyFrdReq=@PrivacyFrdReq where UserId=@UserId";

            using (SqlConnection myConnection = new SqlConnection(connectionString2))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(updateSql2, myConnection);

                myCommand.Parameters.AddWithValue("@PrivacyFrdReq", ddlFrdReqWho.SelectedValue);
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
        }
    }
    protected void ddlEmaillookup_TextChanged(object sender, EventArgs e)
    {
        try
        {
            string connectionString =
               ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string updateSql = "INSERT INTO UserSettings(UserId,PrivacyEmail) VALUES(@UserId,@PrivacyEmail)";

            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(updateSql, myConnection);
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                myCommand.Parameters.AddWithValue("@PrivacyEmail", ddlEmaillookup.SelectedValue);

                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
        }
        catch
        {
            string connectionString2 =
               ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string updateSql2 = "update UserSettings set PrivacyEmail=@PrivacyEmail where UserId=@UserId";

            using (SqlConnection myConnection = new SqlConnection(connectionString2))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(updateSql2, myConnection);

                myCommand.Parameters.AddWithValue("@PrivacyEmail", ddlEmaillookup.SelectedValue);
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
        }
    }
    protected void ddlPhonelookup_TextChanged(object sender, EventArgs e)
    {
        try
        {
            string connectionString =
               ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string updateSql = "INSERT INTO UserSettings(UserId,PrivacyPhone) VALUES(@UserId,@PrivacyPhone)";

            using (SqlConnection myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(updateSql, myConnection);
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                myCommand.Parameters.AddWithValue("@PrivacyPhone", ddlPhonelookup.SelectedValue);

                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
        }
        catch
        {
            string connectionString2 =
               ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string updateSql2 = "update UserSettings set PrivacyPhone=@PrivacyPhone where UserId=@UserId";

            using (SqlConnection myConnection = new SqlConnection(connectionString2))
            {
                myConnection.Open();
                SqlCommand myCommand = new SqlCommand(updateSql2, myConnection);

                myCommand.Parameters.AddWithValue("@PrivacyPhone", ddlPhonelookup.SelectedValue);
                myCommand.Parameters.AddWithValue("@UserId", currentUserId);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
        }
    }
    protected void ProfileGeneralDataSource1_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {
        e.Command.Parameters.Add(new SqlParameter("@UserId", currentUserId));
    }
}