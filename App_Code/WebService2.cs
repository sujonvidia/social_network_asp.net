using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Security;
using System.Web.Services;


/// <summary>
/// Summary description for WebService2
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]

public class WebService2 : System.Web.Services.WebService {

    public WebService2 () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
//    public string[] GetFriendInfo(string prefixText)
//{
// int count = 10;

// string sql = "SELECT UserProfiles.FullName FROM UserProfiles INNER JOIN FriendsList ON UserProfiles.UserId = FriendsList.friend_id WHERE (FriendsList.my_id = @my_id AND UserProfiles.FullName like @prefixText)";
// SqlDataAdapter da = new SqlDataAdapter(sql,ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString);
// da.SelectCommand.Parameters.Add("@prefixText", SqlDbType.VarChar, 50).Value = prefixText+ "%";
// MembershipUser currentUser = Membership.GetUser();
// if (currentUser != null)
// {
//     Guid currentUserId = (Guid)currentUser.ProviderUserKey;
// da.SelectCommand.Parameters.AddWithValue("@my_id", currentUserId);
 
// }
// DataTable dt = new DataTable();
// da.Fill(dt);
// string[] items = new string[dt.Rows.Count];
// int i = 0;
// foreach (DataRow dr in dt.Rows)
// {
//     items.SetValue(dr["FullName"].ToString(), i);
//  i++;
// }
// return items;
//}
    public List<string> GetFriendInfo(string prefixText, int count)
    {
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT UserProfiles.FullName, UserProfiles.UserId, UserProfiles.FirstName FROM UserProfiles INNER JOIN FriendsList ON UserProfiles.UserId = FriendsList.friend_id WHERE (FriendsList.my_id = @my_id AND UserProfiles.FullName like @SearchText + '%')";
                cmd.Parameters.AddWithValue("@SearchText", prefixText);
                MembershipUser currentUser = Membership.GetUser();
                if (currentUser != null)
                {
                    Guid currentUserId = (Guid)currentUser.ProviderUserKey;
                    cmd.Parameters.AddWithValue("@my_id", currentUserId);

                }
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
    [WebMethod]
    public List<string> GetFriendTag(string prefixText, int count)
    {
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT UserProfiles.FullName, UserProfiles.FirstName UserProfiles.UserId FROM UserProfiles INNER JOIN FriendsList ON UserProfiles.UserId = FriendsList.friend_id WHERE (FriendsList.my_id = @my_id AND UserProfiles.FullName like @SearchText + '%')";
                cmd.Parameters.AddWithValue("@SearchText", prefixText);
                MembershipUser currentUser = Membership.GetUser();
                if (currentUser != null)
                {
                    Guid currentUserId = (Guid)currentUser.ProviderUserKey;
                    cmd.Parameters.AddWithValue("@my_id", currentUserId);

                }
                cmd.Connection = conn;
                conn.Open();
                List<string> customers = new List<string>();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        string item = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr["FirstName"].ToString(), sdr["FirstName"].ToString());
                        customers.Add(item);
                    }
                }
                conn.Close();
                return customers;
            }
        }
    }
    //[WebMethod]
    //public List<string> GetChatMsg(string Message_to, string Message_from)
    //{
    //}


    [WebMethod]


    public List<string> GetChatMsg(string Message_to, string Message_from)
    {
        List<string> msg;
            string connectionString =
                     ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string Sql = "SELECT * FROM [Messaging] where Message_to=@Message_to and Message_from=@Message_from ORDER BY Message_date";

                using (SqlConnection myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(Sql, myConnection);
                    myCommand.Parameters.AddWithValue("@Message_to", new Guid(Message_to));
                    myCommand.Parameters.AddWithValue("@Message_from", new Guid(Message_from));

                     msg = new List<string>();
                    using (SqlDataReader sdr = myCommand.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            string item = sdr["Message"].ToString();
                            msg.Add(item);
                        }
                    }
                    myConnection.Close();
                }
                return msg;
    }
    [WebMethod]
    public string GetCurrentUserId()
    {
        MembershipUser currentUser = Membership.GetUser();
       
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;
            return currentUserId.ToString();

        
    }
    [WebMethod]
    public string SendChatMsg(string messageText, string UserFromId, string otherUserId)
    {
        int n;
     string connectionString =
                     ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string insertSql = "INSERT INTO Messaging(Message, Message_from, Message_to) VALUES(@Message, @Message_from, @Message_to)";

                using (SqlConnection myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
                    myCommand.Parameters.AddWithValue("@Message", messageText);
                    myCommand.Parameters.AddWithValue("@Message_from", new Guid(UserFromId));
                    //myCommand.Parameters.AddWithValue("@Message_from_name", HttpContext.Current.Session["user"]);
                    myCommand.Parameters.AddWithValue("@Message_to", new Guid(otherUserId));
                 

                   n=  myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
                using (SqlConnection myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
                    myCommand.Parameters.AddWithValue("@Message", messageText);
                    myCommand.Parameters.AddWithValue("@Message_from", new Guid(otherUserId));
                    //myCommand.Parameters.AddWithValue("@Message_from_name", HttpContext.Current.Session["user"]);
                    myCommand.Parameters.AddWithValue("@Message_to", new Guid(UserFromId));


                    n = myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
                return n.ToString();
            }
            

    [WebMethod]
    public List<string> GetFriendList()
    {
      
            List<string> friends = new List<string>();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "SELECT UserProfiles.[FullName], UserProfiles.UserId, UserProfiles.ProfilePicture,UserProfiles.E_mail FROM UserProfiles INNER JOIN FriendsList ON UserProfiles.UserId = FriendsList.friend_id WHERE (FriendsList.my_id = @my_id)";

                    MembershipUser currentUser = Membership.GetUser();
                    if (currentUser != null)
                    {
                        Guid currentUserId = (Guid)currentUser.ProviderUserKey;
                        friends.Add("");
                        friends.Add(currentUserId.ToString());
                        friends.Add("myemail");
                        friends.Add("myphoto");
                        cmd.Parameters.AddWithValue("@my_id", currentUserId);

                    }
                    cmd.Connection = conn;
                    conn.Open();

                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            string name = sdr["FullName"].ToString();
                            string id = sdr["UserId"].ToString();
                            string email = sdr["E_mail"].ToString();
                            byte[] profile = (byte[])sdr["ProfilePicture"];
                            System.IO.MemoryStream ms = new System.IO.MemoryStream((byte[])sdr["ProfilePicture"]);
                            System.Drawing.Image image = System.Drawing.Image.FromStream(ms);
                            System.Drawing.Image thumbnailImage = image.GetThumbnailImage(122, 146, new System.Drawing.Image.GetThumbnailImageAbort(ThumbnailCallback), IntPtr.Zero);

                            string path = Server.MapPath("~") + "images\\" + id + ".jpg";
                            thumbnailImage.Save(path, System.Drawing.Imaging.ImageFormat.Jpeg);
                            friends.Add(name);
                            friends.Add(id);
                            friends.Add(email);
                            friends.Add("images\\" + id + ".jpg");
                        }
                    }
                    conn.Close();
                    return friends;
                }
            }
      
    }
    public bool ThumbnailCallback()
    {
        return true;
    }
    
}

