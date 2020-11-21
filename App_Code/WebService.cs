using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;

/// <summary>
/// Summary description for WebService2
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService
{

    public WebService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    
    public List<string> GetFriendInfo(string prefixText, int count)
    {
       
    
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT top 5 UserProfiles.FullName,UserProfiles.FirstName, UserProfiles.UserName FROM UserProfiles WHERE (UserProfiles.FullName like + '%' + @SearchText + '%')";
                cmd.Parameters.AddWithValue("@SearchText", prefixText);
                MembershipUser currentUser = Membership.GetUser();
                //if (currentUser != null)
                //{
                //    Guid currentUserId = (Guid)currentUser.ProviderUserKey;
                //    cmd.Parameters.AddWithValue("@my_id", currentUserId);

                //}
                cmd.Connection = conn;
                conn.Open();
                List<string> customers = new List<string>();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        string item = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr["FullName"].ToString(), sdr["UserName"].ToString());
                        customers.Add(item);
                    }
                }
                conn.Close();
                string seemore = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem("See More...", "See More");
                customers.Add(seemore);
                return customers;
            }
        }
    }

    [WebMethod]

    public List<string> GetFriendTag(string prefixText, int count)
    {
       
       string[] tokens = prefixText.Split('@');
       prefixText = tokens[0];
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT UserProfiles.FullName,UserProfiles.FirstName, UserProfiles.UserId FROM UserProfiles INNER JOIN FriendsList ON UserProfiles.UserId = FriendsList.friend_id WHERE (UserProfiles.FirstName like + '%' + @SearchText + '%')";
                cmd.Parameters.AddWithValue("@SearchText", prefixText);
                MembershipUser currentUser = Membership.GetUser();
                //if (currentUser != null)
                //{
                //    Guid currentUserId = (Guid)currentUser.ProviderUserKey;
                //    cmd.Parameters.AddWithValue("@my_id", currentUserId);

                //}
                cmd.Connection = conn;
                conn.Open();
                List<string> customers = new List<string>();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        string item = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr["FirstName"].ToString(), sdr["UserId"].ToString());
                        customers.Add(item);
                    }
                }
                conn.Close();
             
                return customers;
            }
        }
    }

}
