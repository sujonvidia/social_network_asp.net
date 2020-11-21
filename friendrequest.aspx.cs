using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default2 : System.Web.UI.Page
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
    protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
    {
         MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey;
        DataList lv = (DataList)source;
        String req_from = lv.DataKeys[e.Item.ItemIndex].ToString();
      Label lblNotify=  lv.FindControl("LabelNotify") as Label;
                   
                        
        if (e.CommandName == "CommandAccept")
        {
            string connectionString =
            ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string updateSql = "UPDATE FriendRequests SET Request_status = @Request_status WHERE Request_to = @Request_to";
            try
            {
                using (SqlConnection myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(updateSql, myConnection);
                   
                        myCommand.Parameters.AddWithValue("@Request_to", currentUserId);
                        myCommand.Parameters.AddWithValue("@Request_status", 1);
                    
                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
            }
            catch { }

           

            System.Data.SqlClient.SqlDataReader rdr = null;
            System.Data.SqlClient.SqlConnection conn = null;
            System.Data.SqlClient.SqlCommand sqlcmd = null;

            try
            {
                string connectionString3 = System.Configuration.ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                conn = new System.Data.SqlClient.SqlConnection(connectionString3);

                sqlcmd = new System.Data.SqlClient.SqlCommand("select * from [FriendsList] where my_id='" + currentUserId + "'", conn);
                conn.Open();

                rdr = sqlcmd.ExecuteReader();

                if (rdr.HasRows) { 
                while (rdr.Read())
                {
                    String frd_id = rdr["friend_id"].ToString();
                    String my_id = rdr["my_id"].ToString();
                    if (frd_id == req_from && my_id == currentUserId.ToString())
                    {
                        lblNotify.Visible = true;
                        break;
                    }
                    else
                    {
                        string connectionString4 =
           ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                        string insertSql = "INSERT INTO FriendsList(friend_id, my_id) VALUES(@friend_id, @my_id)";

                        using (SqlConnection myConnection = new SqlConnection(connectionString4))
                        {
                            myConnection.Open();
                            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);

                            myCommand.Parameters.AddWithValue("@friend_id", req_from);
                            myCommand.Parameters.AddWithValue("@my_id", currentUserId);

                            myCommand.ExecuteNonQuery();
                            myConnection.Close();
                        }
                        using (SqlConnection myConnection = new SqlConnection(connectionString4))
                        {
                            myConnection.Open();
                            SqlCommand myCommand = new SqlCommand(insertSql, myConnection);

                            myCommand.Parameters.AddWithValue("@friend_id", currentUserId);
                            myCommand.Parameters.AddWithValue("@my_id", req_from);

                            myCommand.ExecuteNonQuery();
                            myConnection.Close();
                        }
                    }

                }
                }
                else
                {
                    string connectionString5 =
          ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                    string insertSql = "INSERT INTO FriendsList(friend_id, my_id) VALUES(@friend_id, @my_id)";

                    using (SqlConnection myConnection = new SqlConnection(connectionString5))
                    {
                        myConnection.Open();
                        SqlCommand myCommand = new SqlCommand(insertSql, myConnection);

                        myCommand.Parameters.AddWithValue("@friend_id", req_from);
                        myCommand.Parameters.AddWithValue("@my_id", currentUserId);

                        myCommand.ExecuteNonQuery();
                        myConnection.Close();
                    }
                    using (SqlConnection myConnection = new SqlConnection(connectionString5))
                    {
                        myConnection.Open();
                        SqlCommand myCommand = new SqlCommand(insertSql, myConnection);

                        myCommand.Parameters.AddWithValue("@friend_id", currentUserId);
                        myCommand.Parameters.AddWithValue("@my_id", req_from);

                        myCommand.ExecuteNonQuery();
                        myConnection.Close();
                    }
                }
                if (rdr != null)
                    rdr.Close();
            }
            catch (Exception ex)
            {

            }

            finally
            {
                if (conn != null)
                    conn.Close();
            }
        
            

        }

        if (e.CommandName == "CommandReject")
        {
            string connectionString =
            ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            string updateSql = "UPDATE FriendRequests SET Request_status = @Request_status WHERE Request_to = @Request_to";
            try
            {
                using (SqlConnection myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(updateSql, myConnection);

                    myCommand.Parameters.AddWithValue("@Request_to", currentUserId);
                    myCommand.Parameters.AddWithValue("@Request_status", 2);

                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
                
            }
            catch { }
        }
        this.DataBind();

    }
    protected void FriendDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();
        if (currentUser != null)
        {
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;
            e.Command.Parameters["@Request_to"].Value = currentUserId;
        }
    }
    protected void DataList1_ItemCreated(object sender, DataListItemEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey;
        DataList lv = (DataList)sender;
        String req_from = lv.DataKeys[e.Item.ItemIndex].ToString();

       

        System.Data.SqlClient.SqlDataReader rdr = null;
        System.Data.SqlClient.SqlConnection conn = null;
        System.Data.SqlClient.SqlCommand sqlcmd = null;

        try
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            conn = new System.Data.SqlClient.SqlConnection(connectionString);

            sqlcmd = new System.Data.SqlClient.SqlCommand("select * from [UserProfiles] where UserId='" + req_from + "'", conn);
            conn.Open();

            rdr = sqlcmd.ExecuteReader();


            while (rdr.Read())
            {
                String fullname = rdr["FullName"].ToString();
                Label lbl = e.Item.FindControl("FullNameLabel") as Label;
                lbl.Text = fullname;

            }
            if (rdr != null)
                rdr.Close();
        }
        catch (Exception ex)
        {

        }

        finally
        {
            if (conn != null)
                conn.Close();
        }

        try
        {
            string connectionString3 = System.Configuration.ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            conn = new System.Data.SqlClient.SqlConnection(connectionString3);

            sqlcmd = new System.Data.SqlClient.SqlCommand("select * from [FriendsList] where my_id='" + currentUserId + "'", conn);
            conn.Open();

            rdr = sqlcmd.ExecuteReader();
            Label lblNotify = e.Item.FindControl("LabelNotify") as Label;
            Button btnAccept = e.Item.FindControl("ButtonReqAccept") as Button;
            if (rdr.HasRows)
            {

                while (rdr.Read())
                {
                    String frd_id = rdr["friend_id"].ToString();
                    String my_id = rdr["my_id"].ToString();
                    if (frd_id == req_from && my_id == currentUserId.ToString())
                    {
                        lblNotify.Visible = true;
                        btnAccept.Visible = false;

                        break;
                    }
                    else
                    {
                        lblNotify.Visible = false;
                        btnAccept.Visible = true;
                    }
                }
            }
            else
            {
                lblNotify.Visible = false;
                btnAccept.Visible = true;
            }
        }
        catch { }
    }
}