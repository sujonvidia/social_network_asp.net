using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Default2 : System.Web.UI.Page
{
   static String frd_id;
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
        PanelMessageBox.PreRender += new EventHandler(pnlHistory_OnPreRender);
        this.DataBind();
    }
    protected void pnlHistory_OnPreRender(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(
        PanelMessageBox, PanelMessageBox.GetType(), "scrollPanelToBottom",
        "scrollPanelToBottom();",
        true);
    }
    protected void FriendDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();
        if (currentUser != null)
        {
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;
            e.Command.Parameters["@my_id"].Value = currentUserId;
            
        }
    }
    protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
    {
        //if (e.CommandName == "FriendLink")
        //{

        //   frd_id=  (e.CommandArgument.ToString());
        //   Response.Cookies["frd_id"].Value = frd_id;

        //   this.DataBind();
        //}
    }
    protected void btnReply_Click(object sender, EventArgs e)
    {
        if (Request.Cookies["frd_id"] != null)
        {
            if (String.IsNullOrEmpty(Request.Cookies["frd_id"].Value))
            {
                Response.Write(@"<script language='javascript'>alert('Please select the person from left with whom you want to send message');</script>");
                return;
            }
            MembershipUser currentUser = Membership.GetUser();
            if (currentUser != null)
            {
                Guid currentUserId = (Guid)currentUser.ProviderUserKey;

                //if (txtNewPost.Text != string.Empty)
                //{
                string connectionString =
                     ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
                string insertSql = "INSERT INTO Messaging(Message, Message_from,Message_from_id, Message_to, Message_content, Message_contentType,Message_from_name) VALUES(@Message, @Message_from,@Message_from_id, @Message_to, @Message_content,@Message_contentType,@Message_from_name)";

                using (SqlConnection myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
                    myCommand.Parameters.AddWithValue("@Message", txtMessage.Text.Trim());
                    myCommand.Parameters.AddWithValue("@Message_from", currentUserId);
                    myCommand.Parameters.AddWithValue("@Message_from_name", HttpContext.Current.Session["user"]);
                    myCommand.Parameters.AddWithValue("@Message_from_id", currentUserId);
                    myCommand.Parameters.AddWithValue("@Message_to", new Guid(Request.Cookies["frd_id"].Value));
                    if (FileUpload1.HasFile)
                    {
                        HttpPostedFile file = FileUpload1.PostedFile;

                        byte[] data = new byte[file.ContentLength];

                        file.InputStream.Read(data, 0, file.ContentLength);
                        myCommand.Parameters.AddWithValue("@Message_content", data);
                        myCommand.Parameters.AddWithValue("@Message_contentType", file.ContentType);
                    }
                    else
                    {
                        myCommand.Parameters.AddWithValue("@Message_content", new byte[0]);
                        myCommand.Parameters.AddWithValue("@Message_contentType", DBNull.Value);

                    }

                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
                using (SqlConnection myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    SqlCommand myCommand = new SqlCommand(insertSql, myConnection);
                    myCommand.Parameters.AddWithValue("@Message", txtMessage.Text.Trim());
                    myCommand.Parameters.AddWithValue("@Message_from", new Guid(Request.Cookies["frd_id"].Value));
                    myCommand.Parameters.AddWithValue("@Message_from_name", HttpContext.Current.Session["user"]);
                    myCommand.Parameters.AddWithValue("@Message_from_id", currentUserId);
                    myCommand.Parameters.AddWithValue("@Message_to", currentUserId);
                    if (FileUpload1.HasFile)
                    {
                        HttpPostedFile file = FileUpload1.PostedFile;

                        byte[] data = new byte[file.ContentLength];

                        file.InputStream.Read(data, 0, file.ContentLength);
                        myCommand.Parameters.AddWithValue("@Message_content", data);
                        myCommand.Parameters.AddWithValue("@Message_contentType", file.ContentType);
                    }
                    else
                    {
                        myCommand.Parameters.AddWithValue("@Message_content", new byte[0]);
                        myCommand.Parameters.AddWithValue("@Message_contentType", DBNull.Value);

                    }

                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
                txtMessage.Text = string.Empty;
                // }
            }
            this.DataBind();
            UpdatePanel1.Update();
        }
    }
    protected void Page_Init()
    {
        AsyncPostBackTrigger trigger = new AsyncPostBackTrigger();
        trigger.EventName = "Tick";
        trigger.ControlID = Timer1.UniqueID.ToString();
        UpdatePanel1.Triggers.Add(trigger);
    }
    protected void MsgboxDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        if (Request.Cookies["frd_id"] != null)
        { 
        if (string.IsNullOrEmpty(Request.Cookies["frd_id"].Value)) { e.Cancel = true; return; }
        MembershipUser currentUser = Membership.GetUser();
        if (currentUser != null)
        {
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;
            e.Command.Parameters["@Message_to"].Value = currentUserId;
            e.Command.Parameters["@Message_from"].Value = new Guid(Request.Cookies["frd_id"].Value);
            //e.Command.Parameters["@Message_from"].Value = new Guid(frd_id) ;

        }
        }
    }
    protected void Timer1_Tick(object sender, EventArgs e)
    {
        MsgboxDataSource1.DataBind();
        UpdatePanel1.Update();
    }


    protected void frd_ServerClick(object sender, EventArgs e)
    {

        HtmlButton button = sender as HtmlButton;

        string frd_id = button.Attributes[("Value")];
     
      Response.Cookies["frd_id"].Value = frd_id;

      MsgboxDataSource1.DataBind();

    }
    protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        //HtmlButton fbtn = e.Item.FindControl("frd") as HtmlButton;
        //string fid = fbtn.Attributes[("Value")];
        //if (Request.Cookies["frd_id"] != null)
        //{
        //    if (Request.Cookies["frd_id"].Value == fid)
        //    {

        //    }
        //}
    }
}